//
//  MessagesView.swift
//  SynrgyApp
//
//  Created by Obinna Nwaokoro on 9/27/25.
//

import SwiftUI

// MARK: - Main Messages View
struct MessagesView: View {
    @State private var messages: [Message] = []
    @State private var messageText: String = ""
    @State private var isTyping: Bool = false
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(spacing: 0) {
            // Navigation Header
//            NavigationHeader(
//                onBack: { dismiss() },
//                onDone: {
//                    print("Done button tapped")
//                    dismiss()
//                }
//            )
            
            // Messages List
            ScrollViewReader { proxy in
                ScrollView {
                    LazyVStack(spacing: 12) {
                        ForEach(messages) { message in
                            MessageBubble(message: message)
                                .id(message.id)
                        }
                        
                        // Typing Indicator
                        if isTyping {
                            TypingIndicator()
                                .id("typing")
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                }
                .onChange(of: messages.count) { _, _ in
                    if let lastMessage = messages.last {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            proxy.scrollTo(lastMessage.id, anchor: .bottom)
                        }
                    }
                }
                .onChange(of: isTyping) { _, typing in
                    if typing {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            proxy.scrollTo("typing", anchor: .bottom)
                        }
                    }
                }
            }
            
            // Message Input
            MessageInputView(
                messageText: $messageText,
                isTyping: $isTyping,
                onSend: sendMessage
            )
        }
        .background(Color(red: 245/255, green: 245/255, blue: 245/255))
        .onAppear {
            loadSampleMessages()
        }
    }
    
    private func sendMessage() {
        guard !messageText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return }
        
        let newMessage = Message(
            id: UUID(),
            text: messageText,
            isFromUser: true,
            timestamp: Date()
        )
        
        messages.append(newMessage)
        messageText = ""
        
        // Show typing indicator
        isTyping = true
        
        // Simulate AI response after a delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            isTyping = false
            
            let aiResponse = Message(
                id: UUID(),
                text: generateAIResponse(to: newMessage.text),
                isFromUser: false,
                timestamp: Date()
            )
            messages.append(aiResponse)
        }
    }
    
    private func generateAIResponse(to userMessage: String) -> String {
        let responses = [
            "That's a great question! Let me help you with that.",
            "I understand what you're looking for. Here's what I recommend...",
            "Based on your career goals, I suggest focusing on...",
            "That's an important step in your journey. Let's break it down...",
            "I can definitely help you with that. Here are some resources..."
        ]
        return responses.randomElement() ?? "I'm here to help with your career development!"
    }
    
    private func loadSampleMessages() {
        messages = [
            Message(
                id: UUID(),
                text: "Welcome! I'm here to help guide your career development. What would you like to work on today?",
                isFromUser: false,
                timestamp: Date().addingTimeInterval(-300)
            ),
            Message(
                id: UUID(),
                text: "I want to become a software engineer",
                isFromUser: true,
                timestamp: Date().addingTimeInterval(-180)
            ),
            Message(
                id: UUID(),
                text: "Excellent choice! Software engineering is a rewarding field. Let's start by building your foundation. What programming languages are you interested in learning?",
                isFromUser: false,
                timestamp: Date().addingTimeInterval(-120)
            )
        ]
    }
}

// MARK: - Typing Indicator
struct TypingIndicator: View {
    @State private var animationOffset: CGFloat = 0
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                HStack(spacing: 4) {
                    ForEach(0..<3) { index in
                        Circle()
                            .fill(Color.gray)
                            .frame(width: 8, height: 8)
                            .offset(y: animationOffset)
                            .animation(
                                .easeInOut(duration: 0.6)
                                .repeatForever()
                                .delay(Double(index) * 0.2),
                                value: animationOffset
                            )
                    }
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                .background(Color.white)
                .cornerRadius(18, corners: [.topLeft, .topRight, .bottomRight])
            }
            Spacer()
        }
        .onAppear {
            animationOffset = -4
        }
    }
}

// MARK: - Message Model
struct Message: Identifiable, Codable {
    let id: UUID
    let text: String
    let isFromUser: Bool
    let timestamp: Date
    
    init(id: UUID = UUID(), text: String, isFromUser: Bool, timestamp: Date) {
        self.id = id
        self.text = text
        self.isFromUser = isFromUser
        self.timestamp = timestamp
    }
}

// MARK: - Message Bubble
struct MessageBubble: View {
    let message: Message
    
    var body: some View {
        HStack {
            if message.isFromUser {
                Spacer()
                VStack(alignment: .trailing, spacing: 4) {
                    Text(message.text)
                        .font(.system(size: 16))
                        .foregroundColor(.white)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 12)
                        .background(Color.blue)
                        .cornerRadius(18, corners: [.topLeft, .topRight, .bottomLeft])
                    
                    Text(formatTime(message.timestamp))
                        .font(.system(size: 12))
                        .foregroundColor(.secondary)
                }
            } else {
                VStack(alignment: .leading, spacing: 4) {
                    Text(message.text)
                        .font(.system(size: 16))
                        .foregroundColor(.black)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 12)
                        .background(Color.white)
                        .cornerRadius(18, corners: [.topLeft, .topRight, .bottomRight])
                    
                    Text(formatTime(message.timestamp))
                        .font(.system(size: 12))
                        .foregroundColor(.secondary)
                }
                Spacer()
            }
        }
    }
    
    private func formatTime(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}

// MARK: - Message Input
struct MessageInputView: View {
    @Binding var messageText: String
    @Binding var isTyping: Bool
    let onSend: () -> Void
    
    var body: some View {
        HStack(spacing: 12) {
            // Text Input
            HStack {
                TextField("What are your thoughts?...", text: $messageText, axis: .vertical)
                    .font(.system(size: 16))
                    .padding(.horizontal, 16)
                    .padding(.vertical, 12)
                    .background(Color.white)
                    .cornerRadius(20)
                    .lineLimit(1...4)
                    .onSubmit {
                        if !messageText.isEmpty {
                            onSend()
                        }
                    }
            }
            .background(Color.white)
            .cornerRadius(20)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.gray.opacity(0.3), lineWidth: 1)
            )
            
            // Send Button
            Button(action: onSend) {
                Image(systemName: "arrow.up.circle.fill")
                    .font(.system(size: 32))
                    .foregroundColor(messageText.isEmpty ? .gray : .blue)
            }
            .disabled(messageText.isEmpty)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(Color(red: 245/255, green: 245/255, blue: 245/255))
    }
}

// MARK: - Navigation Header
private struct NavigationHeader: View {
    let onBack: () -> Void
    let onDone: () -> Void
    
    var body: some View {
        HStack {
            // Back Button
            Button(action: onBack) {
                HStack(spacing: 4) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 16, weight: .medium))
                    Text("Back")
                        .font(.system(size: 16, weight: .medium))
                }
                .foregroundColor(.black)
            }
            
            Spacer()
            
            // Center Title
            Text("Career Chat")
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(.black)
            
            Spacer()
            
            // Done Button
            Button(action: onDone) {
                Text("Done")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.black)
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 16)
        .background(Color(red: 245/255, green: 245/255, blue: 245/255))
    }
}

// MARK: - Corner Radius Extension
extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}

// MARK: - Preview
struct MessagesView_Previews: PreviewProvider {
    static var previews: some View {
        MessagesView()
    }
}
