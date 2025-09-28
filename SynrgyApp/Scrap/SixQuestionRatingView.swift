//
//  SixQuestionRatingView.swift
//  SynrgyApp
//
//  Created by Obinna Nwaokoro on 9/27/25.
//

//
//  SixQuestionRatingView.swift
//  SynrgyApp
//
//  Created by Obinna Nwaokoro on 9/27/25.
//

import SwiftUI

struct SixQuestionRatingView: View {
    @State private var questions = [
        QuestionRating(
            question: "How confident do you feel about your direction?",
            lowLabel: "Not confident", highLabel: "Very confident"),
        QuestionRating(
            question: "How motivated are you right now?",
            lowLabel: "Low motivation", highLabel: "High motivation"),
        QuestionRating(
            question: "How clear are your next steps?", lowLabel: "Unclear",
            highLabel: "Crystal clear"),
        QuestionRating(
            question: "How satisfied are you with progress?",
            lowLabel: "Unsatisfied", highLabel: "Very satisfied"),
        QuestionRating(
            question: "How connected do you feel to others?",
            lowLabel: "Disconnected", highLabel: "Well connected"),
        QuestionRating(
            question: "How energized do you feel daily?",
            lowLabel: "Low energy", highLabel: "High energy"),
    ]

    @Binding var selectedTab: Int

    var body: some View {
        ZStack {
            Color(red: 245 / 255, green: 245 / 255, blue: 245 / 255)
                .ignoresSafeArea()

            VStack(spacing: 0) {
                // Progress indicator
                VStack(spacing: 8) {
                    HStack {
                        ForEach(0..<10) { index in
                            Circle()
                                .fill(
                                    index < 3
                                        ? Color.black : Color.gray.opacity(0.3)
                                )
                                .frame(width: 6, height: 6)
                        }
                    }
                    Text("Questions 13-18 of 60")
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(.gray)
                }
                .padding(.top, 20)
                .padding(.bottom, 24)

                ScrollView {
                    VStack(spacing: 20) {
                        ForEach(questions.indices, id: \.self) { index in
                            VStack(spacing: 12) {
                                Text(questions[index].question)
                                    .font(.system(size: 16, weight: .medium))
                                    .foregroundColor(.black)
                                    .multilineTextAlignment(.center)

                                HStack(spacing: 12) {
                                    ForEach(1...5, id: \.self) { rating in
                                        Button(action: {
                                            selectRating(index, rating)
                                        }) {
                                            Circle()
                                                .fill(
                                                    isSelected(index, rating)
                                                        ? Color.black
                                                        : Color.clear
                                                )
                                                .frame(width: 32, height: 32)
                                                .overlay(
                                                    Circle()
                                                        .stroke(
                                                            Color.gray.opacity(
                                                                0.5),
                                                            lineWidth: 1)
                                                )
                                        }
                                    }
                                }

                                HStack {
                                    Text(questions[index].lowLabel)
                                        .font(
                                            .system(size: 11, weight: .medium)
                                        )
                                        .foregroundColor(.gray)
                                    Spacer()
                                    Text(questions[index].highLabel)
                                        .font(
                                            .system(size: 11, weight: .medium)
                                        )
                                        .foregroundColor(.gray)
                                }
                                .padding(.horizontal, 20)
                            }
                            .padding(.horizontal, 24)
                            .padding(.vertical, 16)
                        }
                    }
                }

                Button("Continue") {
                    selectedTab = 8
                }
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(.white)
                .frame(height: 48)
                .frame(maxWidth: .infinity)
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
    SixQuestionRatingView(selectedTab: .constant(7))
}
