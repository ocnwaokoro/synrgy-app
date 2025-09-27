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

    var body: some View {
        ZStack {
            // Map placeholder
//            LinearGradient(
//                colors: [Color.green.opacity(0.3), Color.blue.opacity(0.2)],
//                startPoint: .topLeading,
//                endPoint: .bottomTrailing
//            )
//            .ignoresSafeArea()
            
            Color.clear.ignoresSafeArea()
            
            MultiRoadmapNexusView(roadmaps: nexusRoadmaps)
                .background(.white)
        }
        .sheet(isPresented: $showSheet) {
            VStack {
                SearchBarView(
                    searchText: $searchText, isSearchFocused: $isSearchFocused
                )
                .padding(.top)
                if (selectedDetent != detent.small) {
                    List {
                        LibraryView()
                        RecentActionsView()
                    }
                    .listStyle(.insetGrouped)
                    .scrollContentBackground(.hidden)
                }
                Spacer(minLength: 0)
            }
            .background(.thinMaterial)
            .presentationDetents([detent.small, detent.medium, detent.large], selection: $selectedDetent)
            .presentationDragIndicator(.visible)
            .interactiveDismissDisabled(true)
            .presentationCompactAdaptation(.none)
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
    HomeView()
}
