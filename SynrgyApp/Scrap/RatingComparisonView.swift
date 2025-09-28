//
//  RatingComparisonView.swift
//  SynrgyApp
//
//  Created by Obinna Nwaokoro on 9/27/25.
//

import SwiftUI

struct RatingComparisonView: View {
    @State private var questions = [
        QuestionRating(question: "How confident do you feel about your direction?", lowLabel: "Not confident", highLabel: "Very confident"),
        QuestionRating(question: "How motivated are you right now?", lowLabel: "Low motivation", highLabel: "High motivation"),
        QuestionRating(question: "How clear are your next steps?", lowLabel: "Unclear", highLabel: "Crystal clear"),
        QuestionRating(question: "How satisfied are you with progress?", lowLabel: "Unsatisfied", highLabel: "Very satisfied"),
        QuestionRating(question: "How connected do you feel to others?", lowLabel: "Disconnected", highLabel: "Well connected"),
        QuestionRating(question: "How energized do you feel daily?", lowLabel: "Low energy", highLabel: "High energy")
    ]
    
    @Binding var selectedTab: Int
    
    var body: some View {
        ZStack {
            Color(red: 245/255, green: 245/255, blue: 245/255).ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 24) {
                    Text("Rating Scale Variations")
                        .font(.system(size: 20, weight: .bold))
                        .padding(.top, 20)
                    
                    // Minus/Plus icons only
                    VStack(spacing: 16) {
                        Text("Version A: Icon Anchors")
                            .font(.system(size: 16, weight: .medium))
                        
                        ForEach(0..<2) { index in
                            questionWithIconAnchors(index: index)
                        }
                    }
                    
                    Divider().padding(.vertical, 12)
                    
                    // Positioned text only
                    VStack(spacing: 16) {
                        Text("Version B: Positioned Text")
                            .font(.system(size: 16, weight: .medium))
                        
                        ForEach(2..<4) { index in
                            questionWithPositionedText(index: index)
                        }
                    }
                    
                    Divider().padding(.vertical, 12)
                    
                    // Combined approach
                    VStack(spacing: 16) {
                        Text("Version C: Icons + Positioned Text")
                            .font(.system(size: 16, weight: .medium))
                        
                        ForEach(4..<6) { index in
                            questionWithCombinedApproach(index: index)
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
    }
    
    // Version A: Icon anchors
    private func questionWithIconAnchors(index: Int) -> some View {
        VStack(spacing: 12) {
            Text(questions[index].question)
                .font(.system(size: 14, weight: .medium))
                .multilineTextAlignment(.center)
            
            HStack {
                Image(systemName: "minus")
                    .font(.system(size: 12, weight: .bold))
                    .foregroundColor(.gray)
                
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
                
                Image(systemName: "plus")
                    .font(.system(size: 12, weight: .bold))
                    .foregroundColor(.gray)
            }
        }
        .padding(.horizontal, 24)
    }
    
    // Version B: Positioned text
    private func questionWithPositionedText(index: Int) -> some View {
        VStack(spacing: 12) {
            Text(questions[index].question)
                .font(.system(size: 14, weight: .medium))
                .multilineTextAlignment(.center)
            
            VStack(spacing: 8) {
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
                
                HStack {
                    Text(questions[index].lowLabel)
                        .font(.system(size: 10, weight: .medium))
                        .foregroundColor(.gray)
                    Spacer()
                    Text(questions[index].highLabel)
                        .font(.system(size: 10, weight: .medium))
                        .foregroundColor(.gray)
                }
                .frame(width: 28 * 5 + 12 * 4) // Match circle width
            }
        }
        .padding(.horizontal, 24)
    }
    
    // Version C: Combined
    private func questionWithCombinedApproach(index: Int) -> some View {
        VStack(spacing: 12) {
            Text(questions[index].question)
                .font(.system(size: 14, weight: .medium))
                .multilineTextAlignment(.center)
            
            VStack(spacing: 8) {
                HStack {
                    VStack(spacing: 4) {
                        Image(systemName: "minus")
                            .font(.system(size: 10, weight: .bold))
                            .foregroundColor(.gray)
                        Text(questions[index].lowLabel)
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
                        Text(questions[index].highLabel)
                            .font(.system(size: 9, weight: .medium))
                            .foregroundColor(.gray)
                    }
                }
            }
        }
        .padding(.horizontal, 24)
    }
    
    private func selectRating(_ questionIndex: Int, _ rating: Int) {
        questions[questionIndex].rating = rating
    }
    
    private func isSelected(_ questionIndex: Int, _ rating: Int) -> Bool {
        questions[questionIndex].rating == rating
    }
}

#Preview {
    RatingComparisonView(selectedTab: .constant(7))
}
