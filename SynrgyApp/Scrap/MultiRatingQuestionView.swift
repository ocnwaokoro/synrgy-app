////
////  MultiRatingQuestionView.swift
////  SynrgyApp
////
////  Created by Obinna Nwaokoro on 9/27/25.
////
//
//import SwiftUI
//
//struct QuestionRating {
//    let question: String
//    let lowLabel: String
//    let highLabel: String
//    var rating: Int = 0
//}
//
//struct MultiRatingQuestionView: View {
//    @State private var questions = [
//        QuestionRating(question: "How confident do you feel?", lowLabel: "Not confident", highLabel: "Very confident"),
//        QuestionRating(question: "How motivated are you?", lowLabel: "Low energy", highLabel: "High energy"),
//        QuestionRating(question: "How clear is your direction?", lowLabel: "Confused", highLabel: "Crystal clear"),
//        QuestionRating(question: "How satisfied are you?", lowLabel: "Unsatisfied", highLabel: "Very satisfied")
//    ]
//    
//    @Binding var selectedTab: Int
//    
//    var body: some View {
//        ZStack {
//            Color(red: 245/255, green: 245/255, blue: 245/255).ignoresSafeArea()
//            
//            VStack(spacing: 32) {
//                Text("Rate Your Current State")
//                    .font(.system(size: 24, weight: .bold))
//                    .padding(.top, 32)
//                
//                VStack(spacing: 28) {
//                    ForEach(questions.indices, id: \.self) { index in
//                        VStack(spacing: 12) {
//                            Text(questions[index].question)
//                                .font(.system(size: 18, weight: .medium))
//                                .foregroundColor(.black)
//                            
//                            // Different visual styles for each question
//                            Group {
//                                if index == 0 {
//                                    confidenceRating(for: index)
//                                } else if index == 1 {
//                                    energyRating(for: index)
//                                } else if index == 2 {
//                                    clarityRating(for: index)
//                                } else {
//                                    satisfactionRating(for: index)
//                                }
//                            }
//                            
//                            HStack {
//                                Text(questions[index].lowLabel)
//                                    .font(.system(size: 12, weight: .medium))
//                                    .foregroundColor(.gray)
//                                Spacer()
//                                Text(questions[index].highLabel)
//                                    .font(.system(size: 12, weight: .medium))
//                                    .foregroundColor(.gray)
//                            }
//                        }
//                    }
//                }
//                .padding(.horizontal, 24)
//                
//                Spacer()
//                
//                Button("Continue") {
//                    selectedTab = 8
//                }
//                .font(.system(size: 20, weight: .semibold))
//                .foregroundColor(.white)
//                .frame(height: 54)
//                .frame(maxWidth: .infinity)
//                .background(Color.black)
//                .cornerRadius(16)
//                .padding(.horizontal, 24)
//                .padding(.bottom, 32)
//            }
//        }
//    }
//    
//    // Confidence: Growing size
//    private func confidenceRating(for questionIndex: Int) -> some View {
//        HStack(spacing: 8) {
//            ForEach(1...5, id: \.self) { rating in
//                Button(action: { selectRating(questionIndex, rating) }) {
//                    Text("\(rating)")
//                        .font(.system(size: 16, weight: .bold))
//                        .foregroundColor(isSelected(questionIndex, rating) ? .white : .black)
//                        .frame(width: CGFloat(35 + rating * 3), height: CGFloat(35 + rating * 3))
//                        .background(
//                            Circle()
//                                .fill(isSelected(questionIndex, rating) ? Color.black : Color(.systemGray5))
//                        )
//                }
//                .animation(.spring(response: 0.3), value: questions[questionIndex].rating)
//            }
//        }
//    }
//    
//    // Energy: Color intensity
//    private func energyRating(for questionIndex: Int) -> some View {
//        HStack(spacing: 8) {
//            ForEach(1...5, id: \.self) { rating in
//                Button(action: { selectRating(questionIndex, rating) }) {
//                    Text("\(rating)")
//                        .font(.system(size: 16, weight: .bold))
//                        .foregroundColor(.white)
//                        .frame(width: 45, height: 45)
//                        .background(
//                            RoundedRectangle(cornerRadius: 8)
//                                .fill(energyColor(for: rating, selected: isSelected(questionIndex, rating)))
//                        )
//                }
//                .animation(.easeInOut(duration: 0.2), value: questions[questionIndex].rating)
//            }
//        }
//    }
//    
//    // Clarity: Shape evolution
//    private func clarityRating(for questionIndex: Int) -> some View {
//        HStack(spacing: 8) {
//            ForEach(1...5, id: \.self) { rating in
//                Button(action: { selectRating(questionIndex, rating) }) {
//                    Text("\(rating)")
//                        .font(.system(size: 16, weight: .bold))
//                        .foregroundColor(isSelected(questionIndex, rating) ? .white : .black)
//                        .frame(width: 45, height: 45)
//                        .background(
//                            clarityShape(for: rating)
//                                .fill(isSelected(questionIndex, rating) ? Color.black : Color(.systemGray5))
//                        )
//                }
//                .animation(.spring(response: 0.4), value: questions[questionIndex].rating)
//            }
//        }
//    }
//    
//    // Satisfaction: Fill progress
//    private func satisfactionRating(for questionIndex: Int) -> some View {
//        HStack(spacing: 8) {
//            ForEach(1...5, id: \.self) { rating in
//                Button(action: { selectRating(questionIndex, rating) }) {
//                    ZStack {
//                        RoundedRectangle(cornerRadius: 8)
//                            .fill(Color(.systemGray5))
//                            .frame(width: 45, height: 45)
//                        
//                        RoundedRectangle(cornerRadius: 8)
//                            .fill(Color.black)
//                            .frame(width: 45, height: CGFloat(9 * rating))
//                            .opacity(isSelected(questionIndex, rating) ? 1.0 : 0.3)
//                        
//                        Text("\(rating)")
//                            .font(.system(size: 16, weight: .bold))
//                            .foregroundColor(isSelected(questionIndex, rating) ? .white : .black)
//                    }
//                }
//                .animation(.easeInOut(duration: 0.3), value: questions[questionIndex].rating)
//            }
//        }
//    }
//    
//    private func energyColor(for rating: Int, selected: Bool) -> Color {
//        let intensity = selected ? 1.0 : 0.4
//        switch rating {
//        case 1: return Color.red.opacity(intensity)
//        case 2: return Color.orange.opacity(intensity)
//        case 3: return Color.yellow.opacity(intensity)
//        case 4: return Color.green.opacity(intensity)
//        case 5: return Color.blue.opacity(intensity)
//        default: return Color.gray.opacity(intensity)
//        }
//    }
//    
//    private func clarityShape(for rating: Int) -> some Shape {
//        switch rating {
//        case 1: return AnyShape(Rectangle())
//        case 2: return AnyShape(RoundedRectangle(cornerRadius: 4))
//        case 3: return AnyShape(RoundedRectangle(cornerRadius: 8))
//        case 4: return AnyShape(RoundedRectangle(cornerRadius: 12))
//        case 5: return AnyShape(Circle())
//        default: return AnyShape(Rectangle())
//        }
//    }
//    
//    private func selectRating(_ questionIndex: Int, _ rating: Int) {
//        questions[questionIndex].rating = rating
//    }
//    
//    private func isSelected(_ questionIndex: Int, _ rating: Int) -> Bool {
//        questions[questionIndex].rating == rating
//    }
//}
//
//struct AnyShape: Shape {
//    private let _path: (CGRect) -> Path
//    
//    init<S: Shape>(_ shape: S) {
//        _path = { rect in
//            shape.path(in: rect)
//        }
//    }
//    
//    func path(in rect: CGRect) -> Path {
//        _path(rect)
//    }
//}
//
//#Preview {
//    MultiRatingQuestionView(selectedTab: .constant(7))
//}
