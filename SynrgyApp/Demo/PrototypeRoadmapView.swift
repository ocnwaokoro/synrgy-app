//
//  PrototypeRoadmapView.swift
//  SynrgyApp
//
//  Created by Obinna Nwaokoro on 9/28/25.
//

import Foundation
import SwiftUI

// MARK: - Main View
struct PrototypeRoadmapView: View {
    let roadmap: Roadmap
    @Binding var isLoading: Bool
    @Environment(\.dismiss) private var dismiss
    let onBack: () -> Void
    @State private var showMessages = true
    @State private var currentDetent: PresentationDetent = .fraction(0.4)
    @ObservedObject var roadmapData: UnifiedRoadmapData
    @State private var showBasicInfo = false

    private let titleTopPadding: CGFloat = 24
    private let milestoneSpacing: CGFloat = 40
    private let betweenTitleDesc: CGFloat = 0
    private let horizontalPadding: CGFloat = 16
    private let markerSize: CGFloat = 28 + 8
    private let base: CGFloat = 199

    init(
        roadmap: Roadmap,
        isLoading: Binding<Bool> = .constant(false),
        onBack: @escaping () -> Void = {},
        roadmapData: UnifiedRoadmapData
    ) {
        self.roadmap = roadmap
        self._isLoading = isLoading
        self.onBack = onBack
        self.roadmapData = roadmapData
    }

    private func toggleSheets() {
        showMessages.toggle()
        showBasicInfo.toggle()
    }
    var body: some View {
        
        ZStack {
            VStack(spacing: 0) {
                NavigationHeader(
                    onBack: {
                        print("PrototypeRoadmapView: Back button tapped")
                        onBack()
                    },
                    onDone: {
                        print("PrototypeRoadmapView: Done button tapped")
                        onBack()
                    },
                    title: roadmap.title
                )
                
                ZStack(alignment: .top) {
                    Color(red: 245 / 255, green: 245 / 255, blue: 245 / 255)
                        .ignoresSafeArea()
                    
                    ScrollView(showsIndicators: false) {
                        VStack(alignment: .leading, spacing: 0) {
                            VStack(alignment: .leading, spacing: milestoneSpacing) {
                                ForEach(roadmap.milestones.indices, id: \.self) { index in
                                    MilestoneRow(
                                        milestone: roadmap.milestones[index],
                                        index: index,
                                        totalCount: roadmap.milestones.count,
                                        milestoneSpacing: milestoneSpacing,
                                        horizontalPadding: horizontalPadding,
                                        markerSize: markerSize,
                                        betweenTitleDesc: betweenTitleDesc
                                    ) {
                                        print("PrototypeRoadmapView: Toggled milestone \(roadmap.milestones[index].id) completion")
                                        roadmapData.updateMilestoneCompletion(
                                            roadmapId: roadmap.id,
                                            milestoneId: roadmap.milestones[index].id,
                                            isCompleted: !roadmap.milestones[index].isCompleted
                                        )
                                    }
                                }
                            }
                            .padding(.top, 8)
                            .padding(.horizontal, 24)
                            
                            if !roadmapData.sharedRoadmaps.contains(where: { $0.id == roadmap.id }) {
                                SaveButton {
                                    print("PrototypeRoadmapView: Save button tapped")
                                    roadmapData.addRoadmap(roadmap)
                                }
                                .padding(.horizontal, 24)
                                .padding(.top, 16)
                            }
                            
                            HStack {
                                Spacer()
                                PersonalizeButton {
                                    print("PrototypeRoadmapView: Basic Info button tapped")
                                    toggleSheets()
                                }
                                Spacer()
                            }
                            .padding(.top, 16)
                            
                            
                            TimelineFooter()
                            
                            Spacer(minLength: 250)
                        }
                        .frame(maxWidth: 500)
                    }
                }
                .sheet(isPresented: $showMessages) {
                    MessagesView()
                        .presentationDetents([.height(base), .height(base+1)], selection: $currentDetent)
                        .presentationBackgroundInteraction(.enabled(upThrough: .height(200)))
                        .presentationDragIndicator(.visible)
                        .interactiveDismissDisabled(true)
                }
                .sheet(isPresented: $showBasicInfo, onDismiss: !showMessages ? {} : toggleSheets ) {
                    ComprehensiveOnboardingFlow {
                        toggleSheets()
                    } onComplete: {
                        toggleSheets()
                    }
                    .padding(.top)
                }
            }
//            
//            Color.black.opacity(0.2).ignoresSafeArea()
//            BasicInfoBirthdayView(synrgyVM: .init(), selectedTab: .constant(0))
//                .padding()
//                .background(.white)
//                .padding()
//                .padding()
//                .padding()
                
            
        }
        
    }
}


// MARK: - New Components Only
struct SaveButton: View {
    let onSave: () -> Void
    
    var body: some View {
        Button(action: onSave) {
            HStack {
                Image(systemName: "plus.circle.fill")
                    .font(.system(size: 16, weight: .medium))
                Text("Save Roadmap")
                    .font(.system(size: 16, weight: .semibold))
            }
            .foregroundColor(.white)
            .padding(.horizontal, 20)
            .padding(.vertical, 12)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.blue)
            )
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct PersonalizeButton: View {
    let onTap: () -> Void
    
    var body: some View {
        Button(action: onTap) {
            HStack {
                Image(systemName: "person.circle.fill")
                    .font(.system(size: 16, weight: .medium))
                Text("Personalize This Roadmap")
                    .font(.system(size: 16, weight: .semibold))
            }
            .foregroundColor(.white)
            .padding(.horizontal, 20)
            .padding(.vertical, 12)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.black)
            )
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct BasicInfoButton: View {
    let onTap: () -> Void
    
    var body: some View {
        Button(action: onTap) {
            HStack {
                Image(systemName: "person.circle.fill")
                    .font(.system(size: 16, weight: .medium))
                Text("Personalize Roadmap")
                    .font(.system(size: 16, weight: .semibold))
            }
            .foregroundColor(.white)
            .padding(.horizontal, 20)
            .padding(.vertical, 12)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.green)
            )
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct BasicInfoFlowView: View {
    let onComplete: () -> Void
    let onBack: () -> Void
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Basic Info Flow")
                    .font(.title)
                    .fontWeight(.bold)
                
                Text("This is where the basic info flow will be implemented")
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                
                Button("Complete") {
                    onComplete()
                }
                .buttonStyle(.borderedProminent)
                
                Button("Back") {
                    onBack()
                }
                .buttonStyle(.bordered)
            }
            .padding()
            .navigationTitle("Personalize")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Back") {
                        onBack()
                    }
                }
            }
        }
    }
}

struct PrototypeRoadmapView_Previews: PreviewProvider {
    static var previews: some View {
        PrototypeRoadmapView(
            roadmap: UnifiedRoadmapData.shared.sharedRoadmaps[0],
            onBack: {
                print("Preview: Back button tapped")
            },
            roadmapData: UnifiedRoadmapData.shared
        )
    }
}

// MARK: - Navigation Header
private struct NavigationHeader: View {
    let onBack: () -> Void
    let onDone: () -> Void
    let title: String
    var body: some View {
        HStack {
            // Back Button
            Button(action: onBack) {
                HStack(spacing: 4) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 16, weight: .medium))
                    Text("Back")
                        .font(.system(size: 16, weight: .medium))
                }
                .foregroundColor(.black)
            }
            
            Spacer()

            // Center Title
            Text(title)
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(.black)

            Spacer()

            // Done Button
            Button(action: onDone) {
                Text("Done")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.black)
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 16)
        .background(Color(red: 245 / 255, green: 245 / 255, blue: 245 / 255))
    }
}
