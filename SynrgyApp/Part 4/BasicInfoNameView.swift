//
//  BasicInfoNameView.swift
//  SynrgyApp
//
//  Created by Obinna Nwaokoro on 9/27/25.
//


import SwiftUI

struct BasicInfoNameView: View {
    @ObservedObject var synrgyVM: SynrgyViewModel
    @State private var name: String = ""
    @Binding var selectedTab: Int
    
    private var canContinue: Bool {
        !name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    var body: some View {
        VStack(spacing: 32) {
            // Progress indicator - 3 dots
            HStack {
                ForEach(0..<3) { index in
                    Circle()
                        .fill(index == 0 ? Color.primary : Color.gray.opacity(0.3))
                        .frame(width: 8, height: 8)
                }
                Spacer()
            }
            .padding(.horizontal, 24)
            
            VStack(alignment: .leading, spacing: 32) {
                
                Spacer()
                
                // Question
                Text("What should we call you?")
                    .font(.title2)
                    .fontWeight(.medium)
                
                // Input
                TextField("Your name", text: $name)
                    .textFieldStyle(SynrgyTextFieldStyle())
                
                Spacer()
                
                // Continue button
                Button(action: {
                    synrgyVM.userName = name
                    // Move to next page (birthday)
                    withAnimation {
                        selectedTab = 1
                    }
                }) {
                    Text("Continue")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(canContinue ? Color.primary : Color.gray.opacity(0.4))
                        .cornerRadius(12)
                }
                .disabled(!canContinue)
            }
            .padding(.horizontal, 24)
        }
        .navigationBarHidden(true)
    }
}

#Preview {
    BasicInfoNameView(synrgyVM: .init(), selectedTab: .constant(1))
}
