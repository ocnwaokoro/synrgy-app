//
//  HomeView.swift
//  SynrgyApp
//
//  Created by Obinna Nwaokoro on 9/26/25.
//

import SwiftUI

private enum detent {
    static let small: PresentationDetent = .fraction(0.09)
    static let medium: PresentationDetent = .fraction(0.55)
    static let large: PresentationDetent = .fraction(0.99)
}

struct HomeView: View {
    @State private var searchText = ""
    @State private var showSheet = true
    @State private var isSearchFocused = false
    @State private var selectedDetent: PresentationDetent = detent.small
    @State private var showW = true
    @ObservedObject var roadmapData: UnifiedRoadmapData
    let onRoadmapSelected: (Roadmap) -> Void

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Map placeholder
                Color.clear.ignoresSafeArea()
                
                // MultiRoadmapNexusView - centered when medium detent
                MultiRoadmapNexusView(roadmaps: roadmapData.sharedRoadmaps)
                    .background(.white)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .position(
                        x: geometry.size.width / 2,
                        y: selectedDetent == detent.medium ?
                            (geometry.size.height * 0.225) : // Center in top 45% when medium
                            geometry.size.height / 2 // Center normally for other detents
                    )
                    .animation(.easeInOut(duration: 0.4), value: selectedDetent)
            }
        }
        .sheet(isPresented: $showSheet) {
            VStack {
                SearchBarView(
                    searchText: $searchText, isSearchFocused: $isSearchFocused
                )
                .padding(.top)
                if (selectedDetent != detent.small) {
                    if isSearchFocused {
                        ScrollView(.vertical) {
                            RecentEngagementView(
                                roadmaps: roadmapData.sharedRoadmaps,
                                onRoadmapSelected: { roadmap in
                                    print("HomeView: Roadmap selected, dismissing sheet")
                                    showSheet = false  // Dismiss sheet first
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                        onRoadmapSelected(roadmap)  // Then navigate
                                    }
                                }
                            )
                            PopularCareersView(
                                onRoadmapSelected: { roadmap in
                                    print("HomeView: Roadmap selected, dismissing sheet")
                                    showSheet = false  // Dismiss sheet first
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                        onRoadmapSelected(roadmap)  // Then navigate
                                    }
                                }
                            )
                        }
                        
                    } else {
                        List {
                            LibraryView(
                                roadmaps: $roadmapData.sharedRoadmaps,
                                onRoadmapSelected: { roadmap in
                                    print("HomeView: Roadmap selected, dismissing sheet")
                                    showSheet = false  // Dismiss sheet first
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                        onRoadmapSelected(roadmap)  // Then navigate
                                    }
                                }
                            )
                            RecentActionsView()
                        }
                        .listStyle(.insetGrouped)
                        .scrollContentBackground(.hidden)
                    }
                }
                Spacer(minLength: 0)
            }
            .background(.thinMaterial)
            .presentationDetents([detent.small, detent.medium, detent.large], selection: $selectedDetent)
            .presentationDragIndicator(.visible)
            .interactiveDismissDisabled(true)
            .presentationCompactAdaptation(.none)
            .presentationBackgroundInteraction(.enabled)
        }
        .onAppear {
            print("HomeView: Maps interface loaded")
            showSheet = true
        }
        .onChange(of: isSearchFocused) { _, focused in
            print("HomeView: Search focus changed to: \(focused)")
            if (focused) {
                selectedDetent = detent.large
            }
            
            if (!focused && selectedDetent == detent.large) {
                selectedDetent = detent.medium
            }
        }
        .onChange(of: searchText) { _, newValue in
            print("HomeView: Search text changed to: '\(newValue)'")
        }
    }
}

#Preview {
    HomeView(
        roadmapData: UnifiedRoadmapData.shared,
        onRoadmapSelected: { roadmap in
            print("Preview: Selected roadmap: \(roadmap.title)")
        }
    )
}
