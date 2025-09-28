//
//  CareerInterestRatingView.swift
//  SynrgyApp
//
//  Created by Obinna Nwaokoro on 9/27/25.
//

import SwiftUI

struct CareerInterestRatingView: View {
    @State private var questions = [
        QuestionRating(question: "Build kitchen cabinets", lowLabel: "Low", highLabel: "High"),
        QuestionRating(question: "Develop a new medicine", lowLabel: "Low", highLabel: "High"),
        QuestionRating(question: "Write books or plays", lowLabel: "Low", highLabel: "High"),
        QuestionRating(question: "Help people with personal problems", lowLabel: "Low", highLabel: "High"),
        QuestionRating(question: "Buy and sell stocks and bonds", lowLabel: "Low", highLabel: "High"),
        QuestionRating(question: "Develop spreadsheets using software", lowLabel: "Low", highLabel: "High")
    ]
    
    @Binding var selectedTab: Int
    
    var body: some View {
        ZStack {
            Color(red: 245/255, green: 245/255, blue: 245/255).ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Progress indicator
                VStack(spacing: 8) {
                    HStack {
                        ForEach(0..<10) { index in
                            Circle()
                                .fill(index < 3 ? Color.black : Color.gray.opacity(0.3))
                                .frame(width: 6, height: 6)
                        }
                    }
                    Text("Questions 1-6 of 60")
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(.gray)
                }
                .padding(.top, 20)
                .padding(.bottom, 24)
                
                ScrollView {
                    VStack(spacing: 16) {
                        ForEach(questions.indices, id: \.self) { index in
                            VStack(spacing: 12) {
                                Text(questions[index].question)
                                    .font(.system(size: 14, weight: .medium))
                                    .multilineTextAlignment(.center)
                                
                                HStack {
                                    VStack(spacing: 4) {
                                        Image(systemName: "minus")
                                            .font(.system(size: 10, weight: .bold))
                                            .foregroundColor(.gray)
                                        Text("Low")
                                            .font(.system(size: 9, weight: .medium))
                                            .foregroundColor(.gray)
                                    }
                                    
                                    HStack(spacing: 12) {
                                        ForEach(1...5, id: \.self) { rating in
                                            Button(action: { selectRating(index, rating) }) {
                                                Circle()
                                                    .fill(isSelected(index, rating) ? Color.black : Color.clear)
                                                    .frame(width: 28, height: 28)
                                                    .overlay(Circle().stroke(Color.gray.opacity(0.5), lineWidth: 1))
                                            }
                                        }
                                    }
                                    
                                    VStack(spacing: 4) {
                                        Image(systemName: "plus")
                                            .font(.system(size: 10, weight: .bold))
                                            .foregroundColor(.gray)
                                        Text("High")
                                            .font(.system(size: 9, weight: .medium))
                                            .foregroundColor(.gray)
                                    }
                                }
                            }
                            .padding(.horizontal, 24)
                            .padding(.vertical, 12)
                        }
                    }
                }
                
                Button("Continue") {
                    selectedTab = 8
                }
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, height: 48)
                .background(Color.black)
                .cornerRadius(12)
                .padding(.horizontal, 24)
                .padding(.bottom, 32)
            }
        }
    }
    
    private func selectRating(_ questionIndex: Int, _ rating: Int) {
        questions[questionIndex].rating = rating
    }
    
    private func isSelected(_ questionIndex: Int, _ rating: Int) -> Bool {
        questions[questionIndex].rating == rating
    }
}

#Preview {
    CareerInterestRatingView(selectedTab: .constant(7))
}