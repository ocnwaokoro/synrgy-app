//
//  ExperienceHobbiesView.swift
//  SynrgyApp
//
//  Created by Obinna Nwaokoro on 9/27/25.
//

import SwiftUI

struct HobbyEntry {
    var hobby: String = ""
}

struct ExperienceHobbiesView: View {
    @ObservedObject var synrgyVM: SynrgyViewModel
    @State private var hobbyEntries: [HobbyEntry] = [HobbyEntry()]
    @Binding var selectedTab: Int

    private var canContinue: Bool {
        let hasValidEntries = hobbyEntries.contains { entry in
            !entry.hobby.isEmpty
        }
        return hasValidEntries
    }

    var body: some View {
        VStack(spacing: 32) {
            // Progress indicator
            HStack {
                ForEach(0..<5) { index in
                    Circle()
                        .fill(
                            index == 4 ? Color.primary : Color.gray.opacity(0.3)
                        )
                        .frame(width: 8, height: 8)
                }
                Spacer()
            }
            .padding(.horizontal, 24)

            VStack(alignment: .leading, spacing: 16) {
                Spacer()

                // Question header
                Text("Any Hobbies?")
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding()

                // Form containers
                ScrollView(.vertical) {
                    LazyVStack(spacing: 12) {
                        ForEach(hobbyEntries.indices, id: \.self) { index in
                            HStack(spacing: 8) {
                                TextField(
                                    index == 0 ? "e.g., Reading, Basketball, Cooking" : "Another hobby...",
                                    text: $hobbyEntries[index].hobby
                                )
                                .textFieldStyle(SynrgyTextFieldStyle())

                                // Plus/Minus buttons horizontally
                                HStack(spacing: 4) {
                                    Button(action: {
                                        hobbyEntries.append(HobbyEntry())
                                    }) {
                                        Image(systemName: "plus")
                                            .foregroundColor(.white)
                                            .frame(width: 28, height: 28)
                                            .background(Color.black)
                                            .clipShape(Circle())
                                    }

                                    if hobbyEntries.count > 1 {
                                        Button(action: {
                                            hobbyEntries.remove(at: index)
                                        }) {
                                            Image(systemName: "minus")
                                                .foregroundColor(.white)
                                                .frame(width: 28, height: 28)
                                                .background(Color.red)
                                                .clipShape(Circle())
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                .padding(.horizontal, 24)

                Spacer()

                // Navigation buttons
                HStack(spacing: 12) {
                    Button("Back") {
                        withAnimation { selectedTab = 3 }
                    }
                    .frame(maxWidth: .infinity, maxHeight: 50)
                    .foregroundColor(.primary)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12).stroke(
                            Color.primary, lineWidth: 2))

                    Button("Continue") {
                        synrgyVM.hobbies = hobbyEntries.compactMap { $0.hobby.isEmpty ? nil : $0.hobby }.joined(separator: ", ")
                        withAnimation { selectedTab = 5 }
                    }
                    .frame(maxWidth: .infinity, maxHeight: 50)
                    .foregroundColor(.white)
                    .background(
                        canContinue ? Color.primary : Color.gray.opacity(0.4)
                    )
                    .cornerRadius(12)
                    .disabled(!canContinue)
                }
                .padding(.horizontal, 24)
            }
        }
        .navigationBarHidden(true)
    }
}

#Preview {
    ExperienceHobbiesView(synrgyVM: .init(), selectedTab: .constant(4))
}
