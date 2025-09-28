//
//  CareerInterestRatingView.swift
//  SynrgyApp
//
//  Created by Obinna Nwaokoro on 9/27/25.
//

import SwiftUI

struct QuestionRating {
    let question: String
    let lowLabel: String
    let highLabel: String
    var rating: Int = 0
}

private let lowLabel = "Low"
private let highLabel = "High"

struct CareerInterestRatingView: View {
    
    @State private var currentPage = 0
    @State private var allQuestions = [
        // Page 1
        QuestionRating(question: "Build kitchen cabinets", lowLabel: lowLabel, highLabel: highLabel),
        QuestionRating(question: "Lay brick or tile", lowLabel: lowLabel, highLabel: highLabel),
        QuestionRating(question: "Develop a new medicine", lowLabel: lowLabel, highLabel: highLabel),
        QuestionRating(question: "Study ways to reduce water pollution", lowLabel: lowLabel, highLabel: highLabel),
        QuestionRating(question: "Write books or plays", lowLabel: lowLabel, highLabel: highLabel),
        QuestionRating(question: "Play a musical instrument", lowLabel: lowLabel, highLabel: highLabel),
        
        // Page 2
        QuestionRating(question: "Teach an individual an exercise routine", lowLabel: lowLabel, highLabel: highLabel),
        QuestionRating(question: "Help people with personal or emotional problems", lowLabel: lowLabel, highLabel: highLabel),
        QuestionRating(question: "Buy and sell stocks and bonds", lowLabel: lowLabel, highLabel: highLabel),
        QuestionRating(question: "Manage a retail store", lowLabel: lowLabel, highLabel: highLabel),
        QuestionRating(question: "Develop a spreadsheet using computer software", lowLabel: lowLabel, highLabel: highLabel),
        QuestionRating(question: "Proofread records or forms", lowLabel: lowLabel, highLabel: highLabel),
        
        // Page 3
        QuestionRating(question: "Repair household appliances", lowLabel: lowLabel, highLabel: highLabel),
        QuestionRating(question: "Raise fish in a fish hatchery", lowLabel: lowLabel, highLabel: highLabel),
        QuestionRating(question: "Conduct chemical experiments", lowLabel: lowLabel, highLabel: highLabel),
        QuestionRating(question: "Study the movement of planets", lowLabel: lowLabel, highLabel: highLabel),
        QuestionRating(question: "Compose or arrange music", lowLabel: lowLabel, highLabel: highLabel),
        QuestionRating(question: "Draw pictures", lowLabel: lowLabel, highLabel: highLabel),
        
        // Page 4
        QuestionRating(question: "Give career guidance to people", lowLabel: lowLabel, highLabel: highLabel),
        QuestionRating(question: "Perform rehabilitation therapy", lowLabel: lowLabel, highLabel: highLabel),
        QuestionRating(question: "Operate a beauty salon or barber shop", lowLabel: lowLabel, highLabel: highLabel),
        QuestionRating(question: "Manage a department within a large company", lowLabel: lowLabel, highLabel: highLabel),
        QuestionRating(question: "Install software across computers on a large network", lowLabel: lowLabel, highLabel: highLabel),
        QuestionRating(question: "Operate a calculator", lowLabel: lowLabel, highLabel: highLabel),
        
        // Page 5
        QuestionRating(question: "Assemble electronic parts", lowLabel: lowLabel, highLabel: highLabel),
        QuestionRating(question: "Drive a truck to deliver packages to offices and homes", lowLabel: lowLabel, highLabel: highLabel),
        QuestionRating(question: "Examine blood samples using a microscope", lowLabel: lowLabel, highLabel: highLabel),
        QuestionRating(question: "Investigate the cause of a fire", lowLabel: lowLabel, highLabel: highLabel),
        QuestionRating(question: "Create special effects for movies", lowLabel: lowLabel, highLabel: highLabel),
        QuestionRating(question: "Paint sets for plays", lowLabel: lowLabel, highLabel: highLabel),
        
        // Page 6
        QuestionRating(question: "Do volunteer work at a non-profit organization", lowLabel: lowLabel, highLabel: highLabel),
        QuestionRating(question: "Teach children how to play sports", lowLabel: lowLabel, highLabel: highLabel),
        QuestionRating(question: "Start your own business", lowLabel: lowLabel, highLabel: highLabel),
        QuestionRating(question: "Negotiate business contracts", lowLabel: lowLabel, highLabel: highLabel),
        QuestionRating(question: "Keep shipping and receiving records", lowLabel: lowLabel, highLabel: highLabel),
        QuestionRating(question: "Calculate the wages of employees", lowLabel: lowLabel, highLabel: highLabel),
        
        // Page 7
        QuestionRating(question: "Test the quality of parts before shipment", lowLabel: lowLabel, highLabel: highLabel),
        QuestionRating(question: "Repair and install locks", lowLabel: lowLabel, highLabel: highLabel),
        QuestionRating(question: "Develop a way to better predict the weather", lowLabel: lowLabel, highLabel: highLabel),
        QuestionRating(question: "Work in a biology lab", lowLabel: lowLabel, highLabel: highLabel),
        QuestionRating(question: "Write scripts for movies or television shows", lowLabel: lowLabel, highLabel: highLabel),
        QuestionRating(question: "Perform jazz or tap dance", lowLabel: lowLabel, highLabel: highLabel),
        
        // Page 8
        QuestionRating(question: "Teach sign language to people who are deaf or hard of hearing", lowLabel: lowLabel, highLabel: highLabel),
        QuestionRating(question: "Help conduct a group therapy session", lowLabel: lowLabel, highLabel: highLabel),
        QuestionRating(question: "Represent a client in a lawsuit", lowLabel: lowLabel, highLabel: highLabel),
        QuestionRating(question: "Market a new line of clothing", lowLabel: lowLabel, highLabel: highLabel),
        QuestionRating(question: "Inventory supplies using a hand-held computer", lowLabel: lowLabel, highLabel: highLabel),
        QuestionRating(question: "Record rent payments", lowLabel: lowLabel, highLabel: highLabel),
        
        // Page 9
        QuestionRating(question: "Set up and operate machines to make products", lowLabel: lowLabel, highLabel: highLabel),
        QuestionRating(question: "Put out forest fires", lowLabel: lowLabel, highLabel: highLabel),
        QuestionRating(question: "Invent a replacement for sugar", lowLabel: lowLabel, highLabel: highLabel),
        QuestionRating(question: "Do laboratory tests to identify diseases", lowLabel: lowLabel, highLabel: highLabel),
        QuestionRating(question: "Sing in a band", lowLabel: lowLabel, highLabel: highLabel),
        QuestionRating(question: "Edit movies", lowLabel: lowLabel, highLabel: highLabel),
        
        // Page 10
        QuestionRating(question: "Take care of children at a day-care center", lowLabel: lowLabel, highLabel: highLabel),
        QuestionRating(question: "Teach a high-school class", lowLabel: lowLabel, highLabel: highLabel),
        QuestionRating(question: "Sell merchandise at a department store", lowLabel: lowLabel, highLabel: highLabel),
        QuestionRating(question: "Manage a clothing store", lowLabel: lowLabel, highLabel: highLabel),
        QuestionRating(question: "Keep inventory records", lowLabel: lowLabel, highLabel: highLabel),
        QuestionRating(question: "Stamp, sort, and distribute mail for an organization", lowLabel: lowLabel, highLabel: highLabel)
    ]
    
    @Binding var selectedTab: Int
    
    private var currentQuestions: [QuestionRating] {
        let startIndex = currentPage * 6
        let endIndex = min(startIndex + 6, allQuestions.count)
        return Array(allQuestions[startIndex..<endIndex])
    }
    
    private var totalPages: Int {
        return (allQuestions.count + 5) / 6
    }
    
    private var allCurrentQuestionsAnswered: Bool {
        let startIndex = currentPage * 6
        let endIndex = min(startIndex + 6, allQuestions.count)
        return (startIndex..<endIndex).allSatisfy { allQuestions[$0].rating > 0 }
    }
    
    var body: some View {
        ZStack {
            Color(red: 245/255, green: 245/255, blue: 245/255).ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Progress indicator
                VStack(spacing: 8) {
                    HStack {
                        ForEach(0..<10) { index in
                            Circle()
                                .fill(index <= currentPage ? Color.black : Color.gray.opacity(0.3))
                                .frame(width: 6, height: 6)
                        }
                    }
                    Text("Questions \(currentPage * 6 + 1)-\(min((currentPage + 1) * 6, 60)) of 60")
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(.gray)
                }
                .padding(.top, 20)
                .padding(.bottom, 24)
                
                ScrollView {
                    VStack(spacing: 16) {
                        ForEach(currentQuestions.indices, id: \.self) { index in
                            let globalIndex = currentPage * 6 + index
                            VStack(spacing: 12) {
                                Text(currentQuestions[index].question)
                                    .font(.system(size: 14, weight: .medium))
                                    .multilineTextAlignment(.center)
                                    .id("question-\(globalIndex)")
                                
                                HStack {
                                    VStack(spacing: 4) {
                                        Image(systemName: "minus")
                                            .font(.system(size: 10, weight: .bold))
                                            .foregroundColor(.gray)
                                        Text(currentQuestions[index].lowLabel)
                                            .font(.system(size: 9, weight: .medium))
                                            .foregroundColor(.gray)
                                    }
                                    
                                    HStack(spacing: 12) {
                                        ForEach(1...5, id: \.self) { rating in
                                            Button(action: { selectRating(globalIndex, rating) }) {
                                                Circle()
                                                    .fill(isSelected(globalIndex, rating) ? Color.black : Color.clear)
                                                    .frame(width: 28, height: 28)
                                                    .overlay(Circle().stroke(Color.gray.opacity(0.5), lineWidth: 1))
                                            }
                                        }
                                    }
                                    
                                    VStack(spacing: 4) {
                                        Image(systemName: "plus")
                                            .font(.system(size: 10, weight: .bold))
                                            .foregroundColor(.gray)
                                        Text(currentQuestions[index].highLabel)
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
                
                // Navigation buttons
                HStack(spacing: 12) {
                    if currentPage > 0 {
                        Button("Previous") {
                            currentPage -= 1
                        }
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.black)
                        .frame(height: 48)
                        .frame(maxWidth: .infinity)
                        .background(Color(.systemGray5))
                        .cornerRadius(12)
                    }
                    
                    Button(currentPage == totalPages - 1 ? "Complete" : "Next") {
                        if currentPage == totalPages - 1 {
                            selectedTab = 8
                        } else {
                            currentPage += 1
                        }
                    }
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.white)
                    .frame(height: 48)
                    .frame(maxWidth: .infinity)
                    .background(allCurrentQuestionsAnswered ? Color.black : Color.gray.opacity(0.4))
                    .cornerRadius(12)
                    .disabled(!allCurrentQuestionsAnswered)
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 32)
            }
        }
    }
    
    private func selectRating(_ questionIndex: Int, _ rating: Int) {
        allQuestions[questionIndex].rating = rating
    }
    
    private func isSelected(_ questionIndex: Int, _ rating: Int) -> Bool {
        allQuestions[questionIndex].rating == rating
    }
}

#Preview {
    CareerInterestRatingView(selectedTab: .constant(7))
}
