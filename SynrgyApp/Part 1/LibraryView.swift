//
//  LibraryView.swift
//  SynrgyApp
//
//  Created by Obinna Nwaokoro on 9/26/25.
//

import SwiftUI

struct LibraryView: View {
    @Binding var roadmaps: [Roadmap]
    let onRoadmapSelected: (Roadmap) -> Void
    
    var body: some View {
        Section {
            // Library Items - Simple Horizontal Row
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    ForEach(roadmaps) { roadmap in
                        LibraryItemCardView(
                            roadmap: roadmap,
                            onTap: {
                                print("LibraryView: Tapped on roadmap: \(roadmap.title)")
                                onRoadmapSelected(roadmap)
                            }
                        )
                    }
                    
                    // Add new item
                    LibraryAddCardView()
                }
                .padding(.horizontal, 16)
            }
            .listRowInsets(EdgeInsets(top: 16, leading: 0, bottom: 0, trailing: 0))
            
            // Progress Stats
            HStack {
                let completedMilestones = roadmaps.flatMap { $0.milestones }.filter { $0.isCompleted }.count
                let totalMilestones = roadmaps.flatMap { $0.milestones }.count
                let pendingMilestones = totalMilestones - completedMilestones
                
                Text("\(completedMilestones) Complete • \(pendingMilestones) Pending")
                    .foregroundColor(.secondary)
                    .font(.subheadline)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .foregroundColor(.secondary)
                    .font(.caption)
                    .fontWeight(.medium)
            }
            .listRowInsets(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
            .alignmentGuide(.listRowSeparatorLeading) { _ in 0 }
        } header: {
            HStack {
                Text("Library")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .textCase(nil)
                Spacer()
            }
            .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
        }
    }
}

struct LibraryItemCardView: View {
    let roadmap: Roadmap
    let onTap: () -> Void
    
    var body: some View {
        VStack(spacing: 12) {
            // Icon
            Circle()
                .fill(Color(.systemGray6))
                .frame(width: 60, height: 60)
                .overlay(
                    Image(systemName: getIconForRoadmap(roadmap.title))
                        .foregroundColor(.blue)
                        .font(.title2)
                        .fontWeight(.medium)
                )
            
            // Title
            Text(roadmap.title)
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundColor(.primary)
                .multilineTextAlignment(.center)
            Spacer()
        }
        .frame(width: 80)
        .onTapGesture {
            print("LibraryItemCardView: Tapped on roadmap: \(roadmap.title)")
            onTap()
        }
    }
    
    private func getIconForRoadmap(_ title: String) -> String {
        switch title {
        case "Content Creator":
            return "camera.fill"
        case "Software Engineer":
            return "laptopcomputer"
        case "Entrepreneur":
            return "lightbulb.fill"
        default:
            return "briefcase.fill"
        }
    }
}

struct LibraryAddCardView: View {
    var body: some View {
        VStack(spacing: 12) {
            // Icon
            Circle()
                .fill(Color(.systemGray6))
                .frame(width: 60, height: 60)
                .overlay(
                    Image(systemName: "plus")
                        .foregroundColor(.blue)
                        .font(.title2)
                        .fontWeight(.medium)
                )
            
            // Title
            Text("Add")
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundColor(.primary)
                .multilineTextAlignment(.center)
            Spacer()
        }
        .frame(width: 80)
        .onTapGesture {
            print("LibraryAddCardView: Tapped on add new roadmap")
            // TODO: Implement add new roadmap functionality
        }
    }
}

// MARK: - Preview Provider
#Preview {
    ZStack {
        Color.clear
            .ignoresSafeArea()
            .background(.ultraThickMaterial)

        List {
            LibraryView(
                roadmaps: .constant(UnifiedRoadmapData.shared.sharedRoadmaps),
                onRoadmapSelected: { roadmap in
                    print("Preview: Selected roadmap: \(roadmap.title)")
                }
            )
        }
        .listStyle(.insetGrouped)
        .scrollDisabled(true)
        .scrollContentBackground(.hidden)
        .background(.ultraThickMaterial)
    }
}
