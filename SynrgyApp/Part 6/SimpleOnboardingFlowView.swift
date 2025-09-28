//
//  SimpleOnboardingFlowView.swift
//  SynrgyApp
//
//  Created by Obinna Nwaokoro on 9/27/25.
//

import SwiftUI

struct Question {
    let text: String
    let options: [String]
}

struct SimpleOnboardingFlowView: View {
    @State private var currentIndex = 0
    @State private var selectedAnswers: [String] = []
    @Binding var selectedTab: Int
    
    private let questions = [
        Question(text: "What's one goal you're actively working toward?",
                options: ["Land an internship", "Build a brand", "Get into grad school", "Figure out my purpose", "Start a business"]),
        Question(text: "Where are you currently on your journey?",
                options: ["In college", "Recent grad", "Early career", "Pivoting", "Exploring"]),
        Question(text: "Which areas are you most focused on right now?",
                options: ["Career clarity", "Personal growth", "Financial literacy", "Building confidence", "Expanding my network"]),
        Question(text: "How do you learn best?",
                options: ["Interactive tools", "Short videos", "Peer discussion", "Structured guides"])
    ]
    
    private var currentQuestion: Question {
        questions[currentIndex]
    }
    
    private var hasAnswer: Bool {
        selectedAnswers.indices.contains(currentIndex) && !selectedAnswers[currentIndex].isEmpty
    }
    
    private var isLastQuestion: Bool {
        currentIndex == questions.count - 1
    }
    
    var body: some View {
        VStack(spacing: 0) {
            
            // Content
            ZStack {
                Color(red: 245/255, green: 245/255, blue: 245/255).ignoresSafeArea()
                VStack(alignment: .leading, spacing: 0) {
                    Text(currentQuestion.text)
                        .font(.system(size: 22, weight: .bold))
                        .foregroundColor(.black)
                        .padding(.top, 32)
                        .padding(.horizontal, 24)
                        .padding(.bottom, 28)
                        .animation(.easeInOut(duration: 0.3), value: currentIndex)
                    
                    VStack(spacing: 16) {
                        ForEach(currentQuestion.options, id: \.self) { option in
                            Button(action: { selectAnswer(option) }) {
                                Text(option)
                                    .font(.system(size: 17, weight: .medium))
                                    .foregroundColor(isSelected(option) ? .white : .black)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.vertical, 16)
                                    .padding(.horizontal, 20)
                                    .background(
                                        RoundedRectangle(cornerRadius: 16)
                                            .fill(isSelected(option) ? Color.black : Color(.systemGray5))
                                    )
                            }
                            .animation(.easeInOut(duration: 0.2), value: selectedAnswers)
                        }
                    }
                    .padding(.horizontal, 24)
                    .transition(.slide)
                    .animation(.easeInOut(duration: 0.4), value: currentIndex)
                    
                    Spacer()
                    
                    HStack(spacing: 16) {
                        if currentIndex > 0 {
                            Button("Previous") { goBack() }
                                .font(.system(size: 17, weight: .medium))
                                .foregroundColor(.black)
                                .frame(height: 54)
                                .frame(maxWidth: .infinity)
                                .background(RoundedRectangle(cornerRadius: 16).fill(Color(.systemGray5)))
                        }
                        
                        Button(isLastQuestion ? "Start" : "Next") { goNext() }
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundColor(.white)
                            .frame(height: 54)
                            .frame(maxWidth: .infinity)
                            .background(Color.black)
                            .cornerRadius(16)
                            .disabled(!hasAnswer)
                            .opacity(hasAnswer ? 1.0 : 0.6)
                    }
                    .padding(.horizontal, 24)
                    .padding(.bottom, 32)
                }
            }
        }
    }
    
    private func selectAnswer(_ answer: String) {
        if selectedAnswers.indices.contains(currentIndex) {
            selectedAnswers[currentIndex] = answer
        } else {
            selectedAnswers.append(answer)
        }
    }
    
    private func isSelected(_ option: String) -> Bool {
        selectedAnswers.indices.contains(currentIndex) && selectedAnswers[currentIndex] == option
    }
    
    private func goNext() {
        withAnimation(.easeInOut(duration: 0.4)) {
            if isLastQuestion {
                selectedTab = 6
            } else {
                currentIndex += 1
                if !selectedAnswers.indices.contains(currentIndex) {
                    selectedAnswers.append("")
                }
            }
        }
    }
    
    private func goBack() {
        withAnimation(.easeInOut(duration: 0.4)) {
            currentIndex -= 1
        }
    }
}

#Preview {
    SimpleOnboardingFlowView(selectedTab: .constant(5))
}
