//
//  ContentView.swift
//  SynrgyApp
//
//  Created by ocnwaokoro on 2024.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var roadmapData = UnifiedRoadmapData.shared
    @State private var selectedRoadmap: Roadmap?

    var body: some View {
        ZStack {
            if let roadmap = selectedRoadmap {
                // Show Roadmap View with scale animation
                PrototypeRoadmapView(
                    roadmap: roadmap,
                    onBack: {
                        print("ContentView: Back button tapped, returning to Home")
                        withAnimation(.spring(response: 0.7, dampingFraction: 0.8)) {
                            selectedRoadmap = nil
                        }
                    }, roadmapData: UnifiedRoadmapData.shared
                )
                .transition(.scale(scale: 0.8).combined(with: .opacity))
                .zIndex(1)
            } else {
                // Show Home View with scale animation
                HomeView(
                    roadmapData: roadmapData,
                    onRoadmapSelected: { roadmap in
                        withAnimation(.spring(response: 0.7, dampingFraction: 0.8)) {
                            selectedRoadmap = roadmap
                        }
                    }
                )
                .transition(.scale(scale: 1.2).combined(with: .opacity))
                .zIndex(0)
            }
        }
        .animation(.spring(response: 0.7, dampingFraction: 0.8), value: selectedRoadmap)
    }
}

#Preview {
    ContentView()
}
