//
//  OnboardingFlowContainerView.swift
//  SynrgyApp
//
//  Created by Obinna Nwaokoro on 9/27/25.
//

import SwiftUI

struct OnboardingQuestion {
    let id: String
    let text: String
    let options: [String]?
    let isFreeText: Bool
    let showRoadmapInfo: Bool
}

struct OnboardingFlowContainerView: View {
    @ObservedObject var synrgyVM: SynrgyViewModel
    @State private var currentQuestionIndex: Int = 0
    @State private var answers: [String: String] = [:]
    @State private var freeTextAnswer: String = ""
    @State private var wantsRoadmapInfo: Bool = false
    @Binding var selectedTab: Int

    private let questions: [OnboardingQuestion] = [
        OnboardingQuestion(
            id: "goal",
            text: "What's one goal you're actively working toward?",
            options: [
                "Land an internship", "Build a brand", "Get into grad school",
                "Figure out my purpose", "Start a business",
            ],
            isFreeText: false,
            showRoadmapInfo: false
        ),
        OnboardingQuestion(
            id: "journey_stage",
            text: "Where are you currently on your journey?",
            options: [
                "In college", "Recent grad", "Early career", "Pivoting",
                "Exploring",
            ],
            isFreeText: false,
            showRoadmapInfo: false
        ),
        OnboardingQuestion(
            id: "focus_areas",
            text: "Which areas are you most focused on right now?",
            options: [
                "Career clarity", "Personal growth", "Financial literacy",
                "Building confidence", "Expanding my network",
            ],
            isFreeText: false,
            showRoadmapInfo: false
        ),
        OnboardingQuestion(
            id: "learning_style",
            text: "How do you learn best?",
            options: [
                "Interactive tools", "Short videos", "Peer discussion",
                "Structured guides",
            ],
            isFreeText: false,
            showRoadmapInfo: false
        ),
        OnboardingQuestion(
            id: "future_vision",
            text: "Where do you see yourself in 3–5 years?",
            options: nil,
            isFreeText: true,
            showRoadmapInfo: true
        ),
    ]

    private var currentQuestion: OnboardingQuestion {
        questions[currentQuestionIndex]
    }

    private var canGoNext: Bool {
        if currentQuestion.isFreeText {
            return !freeTextAnswer.isEmpty || wantsRoadmapInfo
        } else {
            return answers[currentQuestion.id] != nil
        }
    }

    private var canGoPrevious: Bool {
        return currentQuestionIndex > 0
    }

    private var isFinal: Bool {
        return currentQuestionIndex == questions.count - 1
    }

    var body: some View {
        ZStack {
            Color(red: 245 / 255, green: 245 / 255, blue: 245 / 255)
                .ignoresSafeArea()
            
            OnboardingQuestionView(
                step: currentQuestionIndex + 1,
                totalSteps: questions.count,
                question: currentQuestion.text,
                options: currentQuestion.options,
                freeText: currentQuestion.isFreeText,
                showRoadmapInfo: currentQuestion.showRoadmapInfo,
                selection: answers[currentQuestion.id],
                onSelect: { selectedOption in
                    answers[currentQuestion.id] = selectedOption
                },
                onFreeTextChange: { text in
                    freeTextAnswer = text
                },
                onRoadmapInfo: {
                    wantsRoadmapInfo = true
                },
                onNext: {
                    if isFinal {
                        // Save final answer
                        if currentQuestion.isFreeText {
                            answers[currentQuestion.id] = freeTextAnswer
                        }
                        
                        // Store all answers in view model
                        synrgyVM.answers = answers
                        synrgyVM.roadmapText = freeTextAnswer
                        synrgyVM.wantsRoadmapInfo = wantsRoadmapInfo
                        
                        // Navigate to next section
                        withAnimation {
                            selectedTab = 6  // or wherever roadmap generation happens
                        }
                    } else {
                        // Save current answer and move to next question
                        if currentQuestion.isFreeText {
                            answers[currentQuestion.id] = freeTextAnswer
                        }
                        
                        withAnimation {
                            currentQuestionIndex += 1
                            freeTextAnswer = ""
                        }
                    }
                },
                onPrevious: {
                    withAnimation {
                        currentQuestionIndex -= 1
                        freeTextAnswer = answers[currentQuestion.id] ?? ""
                    }
                },
                canGoNext: canGoNext,
                canGoPrevious: canGoPrevious,
                isFinal: isFinal,
                freeTextValue: $freeTextAnswer,
                wantsRoadmapInfo: $wantsRoadmapInfo
            )
        }
    }
    
}

struct AnswerOptionButton: View {
    let text: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(text)
                .font(.system(size: 17, weight: .medium))
                .foregroundColor(isSelected ? .white : .black)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.vertical, 16)
                .padding(.horizontal, 20)
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(isSelected ? Color.black : Color(.systemGray5))
                )
        }
    }
}

#Preview {
    OnboardingFlowContainerView(synrgyVM: .init(), selectedTab: .constant(5))
}

// A reusable onboarding question view for Synrgy.
struct OnboardingQuestionView: View {
    let step: Int
    let totalSteps: Int
    let question: String
    let options: [String]?
    let freeText: Bool
    let showRoadmapInfo: Bool
    let selection: String?
    let onSelect: (String) -> Void
    let onFreeTextChange: (String) -> Void
    let onRoadmapInfo: () -> Void
    let onNext: () -> Void
    let onPrevious: () -> Void
    let canGoNext: Bool
    let canGoPrevious: Bool
    let isFinal: Bool
    @Binding var freeTextValue: String
    @Binding var wantsRoadmapInfo: Bool
    @FocusState private var isTextFieldFocused: Bool

    var body: some View {
        VStack(spacing: 0) {
            ZStack(alignment: .top) {
                Color(red: 245 / 255, green: 245 / 255, blue: 245 / 255)
                    .ignoresSafeArea(edges: .bottom)
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 0) {
                        // Question
                        Text(question)
                            .font(
                                .system(
                                    size: 22, weight: .bold, design: .default)
                            )
                            .foregroundColor(.black)
                            .padding(.top, 32)
                            .padding(.horizontal, 24)
                            .padding(.bottom, 28)
                        // Options or free text
                        if let options = options {
                            VStack(spacing: 16) {
                                ForEach(options, id: \.self) { opt in
                                    AnswerOptionButton(
                                        text: opt, isSelected: selection == opt
                                    ) {
                                        onSelect(opt)
                                    }
                                }
                            }
                            .padding(.horizontal, 24)
                            .padding(.bottom, 36)
                        }
                        if freeText {
                            VStack(alignment: .leading, spacing: 12) {
                                TextField(
                                    "Type your answer...", text: $freeTextValue
                                )
                                .font(
                                    .system(
                                        size: 17, weight: .regular,
                                        design: .default)
                                )
                                .padding(16)
                                .background(
                                    RoundedRectangle(cornerRadius: 16).fill(
                                        Color(.systemGray5))
                                )
                                .padding(.horizontal, 24)
                                .focused($isTextFieldFocused)
                                if showRoadmapInfo {
                                    Button(action: onRoadmapInfo) {
                                        Text("Tell me more about roadmaps")
                                            .font(
                                                .system(
                                                    size: 17, weight: .medium,
                                                    design: .default)
                                            )
                                            .foregroundColor(.black)
                                            .frame(maxWidth: .infinity)
                                            .padding(.vertical, 16)
                                            .background(
                                                RoundedRectangle(
                                                    cornerRadius: 16
                                                ).fill(Color(.systemGray5)))
                                    }
                                    .padding(.horizontal, 24)
                                }
                            }
                            .padding(.bottom, 36)
                        }
                        Spacer(minLength: 0)
                        // Navigation controls
                        HStack(spacing: 16) {
                            if canGoPrevious {
                                Button(action: onPrevious) {
                                    Text("Previous")
                                        .font(
                                            .system(
                                                size: 17, weight: .medium,
                                                design: .default)
                                        )
                                        .foregroundColor(.black)
                                        .frame(maxWidth: .infinity)
                                        .frame(height: 54)
                                        .background(
                                            RoundedRectangle(cornerRadius: 16)
                                                .fill(Color(.systemGray5)))
                                }
                            }
                            Button(action: {
                                isTextFieldFocused = false
                                onNext()
                            }) {
                                Text(isFinal ? "Start" : "Next")
                                    .font(
                                        .system(
                                            size: 20, weight: .semibold,
                                            design: .default)
                                    )
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 54)
                                    .background(Color.black)
                                    .cornerRadius(16)
                            }
                            .disabled(!canGoNext)
                            .opacity(canGoNext ? 1.0 : 0.6)
                        }
                        .padding(.horizontal, 24)
                        .padding(.bottom, 32)
                    }
                    .frame(maxWidth: 500)
                }
            }
        }
    }
}
