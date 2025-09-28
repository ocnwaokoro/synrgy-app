//
//  RatingQuestionFlow.swift
//  SynrgyApp
//
//  Created by Obinna Nwaokoro on 9/27/25.
//

import SwiftUI

struct RatingQuestion {
    let text: String
    let lowLabel: String
    let highLabel: String
}

struct RatingQuestionFlow: View {
    @State private var currentIndex = 0
    @State private var ratings: [Int] = []
    @Binding var selectedTab: Int
    
    private let questions = [
        RatingQuestion(text: "How confident are you in your career direction?", lowLabel: "Not confident", highLabel: "Very confident"),
        RatingQuestion(text: "How satisfied are you with your current progress?", lowLabel: "Not satisfied", highLabel: "Very satisfied"),
        RatingQuestion(text: "How motivated do you feel right now?", lowLabel: "Not motivated", highLabel: "Very motivated"),
        RatingQuestion(text: "How clear are your next steps?", lowLabel: "Not clear", highLabel: "Very clear")
    ]
    
    private var currentQuestion: RatingQuestion {
        questions[currentIndex]
    }
    
    private var hasRating: Bool {
        ratings.indices.contains(currentIndex) && ratings[currentIndex] > 0
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
                    
                    VStack(spacing: 20) {
                        HStack {
                            Spacer()
                            ForEach(1...5, id: \.self) { rating in
                                Button(action: { selectRating(rating) }) {
                                    Text("\(rating)")
                                        .font(.system(size: 20, weight: .semibold))
                                        .foregroundColor(isSelected(rating) ? .white : .black)
                                        .frame(width: 50, height: 50)
                                        .background(
                                            RoundedRectangle(cornerRadius: 12)
                                                .fill(isSelected(rating) ? Color.black : Color(.systemGray5))
                                        )
                                }
                                .animation(.easeInOut(duration: 0.2), value: ratings)
                                Spacer()
                            }
                        }
                        
                        HStack {
                            Text(currentQuestion.lowLabel)
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(.gray)
                            Spacer()
                            Text(currentQuestion.highLabel)
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(.gray)
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
                        
                        Button(isLastQuestion ? "Complete" : "Next") { goNext() }
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundColor(.white)
                            .frame(height: 54)
                            .frame(maxWidth: .infinity)
                            .background(Color.black)
                            .cornerRadius(16)
                            .disabled(!hasRating)
                            .opacity(hasRating ? 1.0 : 0.6)
                    }
                    .padding(.horizontal, 24)
                    .padding(.bottom, 32)
                }
            }
        }
    }
    
    private func selectRating(_ rating: Int) {
        if ratings.indices.contains(currentIndex) {
            ratings[currentIndex] = rating
        } else {
            ratings.append(rating)
        }
    }
    
    private func isSelected(_ rating: Int) -> Bool {
        ratings.indices.contains(currentIndex) && ratings[currentIndex] == rating
    }
    
    private func goNext() {
        withAnimation(.easeInOut(duration: 0.4)) {
            if isLastQuestion {
                selectedTab = 7
            } else {
                currentIndex += 1
                if !ratings.indices.contains(currentIndex) {
                    ratings.append(0)
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
    RatingQuestionFlow(selectedTab: .constant(6))
}
