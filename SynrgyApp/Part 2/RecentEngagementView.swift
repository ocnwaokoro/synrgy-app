//
//  RecentEngagementView.swift
//  SynrgyApp
//
//  Created by Obinna Nwaokoro on 9/27/25.
//

import SwiftUI

struct RecentEngagementView: View {
    let roadmaps: [Roadmap]

    var body: some View {
        VStack(spacing: 0) {
            // Header with "Recents" and "More" button
            HStack {
                Text("Recents")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .textCase(nil)
                    .foregroundStyle(.secondary)

                Spacer()

                Text("More")
                    .foregroundColor(.blue)
                    .font(.subheadline)
                    .textCase(nil)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 4)
            
            // First divider after header
            Divider()
                .padding(.leading, 16)
            
            // Roadmap items with dividers
            ForEach(Array(roadmaps.enumerated()), id: \.element.id) { index, roadmap in
                RoadmapItemView(roadmap: roadmap)
                
                // Add divider after each item (except the last one)
                if index < roadmaps.count - 1 {
                    Divider()
                        .padding(.leading, 16)
                }
            }
        }
    }
}

struct RoadmapItemView: View {
    let roadmap: Roadmap
    private let iconSize: CGFloat = 24

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: "briefcase.fill")
                .foregroundColor(.gray)
                .font(.system(size: 16))
                .frame(width: iconSize, height: iconSize)

            Text(roadmap.displayText)
                .font(.subheadline)
                .fontWeight(.medium)

            Spacer()
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
    }
}

extension Roadmap {
    var displayText: AttributedString {
        let currentStep = currentStepIndex + 1
        let totalSteps = milestones.count
        
        var result = AttributedString(title)
        
        var stepAttr = AttributedString(" ⋅ Step \(currentStep)/\(totalSteps)")
        stepAttr.foregroundColor = .secondary
        result.append(stepAttr)
        
        return result
    }
}

// Sample roadmaps for career guidance
private let sampleRoadmaps = [
    Roadmap(
        title: "Content Creator",
        milestones: [
            Milestone(id: 1, title: "Choose Niche", description: "Find your focus", isCompleted: true),
            Milestone(id: 2, title: "Setup Platforms", description: "Create profiles", isCompleted: true),
            Milestone(id: 3, title: "Content Calendar", description: "Plan posts", isCompleted: false),
            Milestone(id: 4, title: "Engage Audience", description: "Build community", isCompleted: false),
            Milestone(id: 5, title: "Monetize", description: "Generate revenue", isCompleted: false)
        ]
    ),
    Roadmap(
        title: "Software Engineer",
        milestones: [
            Milestone(id: 1, title: "Learn Basics", description: "Programming fundamentals", isCompleted: true),
            Milestone(id: 2, title: "Build Projects", description: "Portfolio development", isCompleted: false),
            Milestone(id: 3, title: "Apply Jobs", description: "Job search", isCompleted: false),
            Milestone(id: 4, title: "First Role", description: "Entry position", isCompleted: false),
            Milestone(id: 5, title: "Senior Role", description: "Career growth", isCompleted: false)
        ]
    ),
    Roadmap(
        title: "Entrepreneur",
        milestones: [
            Milestone(id: 1, title: "Idea Validation", description: "Test concept", isCompleted: true),
            Milestone(id: 2, title: "MVP", description: "Build prototype", isCompleted: true),
            Milestone(id: 3, title: "Launch", description: "Go to market", isCompleted: true),
            Milestone(id: 4, title: "Scale", description: "Grow business", isCompleted: false),
            Milestone(id: 5, title: "Exit", description: "Acquisition/IPO", isCompleted: false)
        ]
    )
]

#Preview {
    RecentEngagementView(roadmaps: sampleRoadmaps)
}

let MyRoadmaps = [
    Roadmap(
        title: "Content Creator",
        milestones: [
            Milestone(id: 1, title: "Choose Niche", description: "Find your focus", isCompleted: true),
            Milestone(id: 2, title: "Setup Platforms", description: "Create profiles", isCompleted: true),
            Milestone(id: 3, title: "Content Calendar", description: "Plan posts", isCompleted: false),
            Milestone(id: 4, title: "Engage Audience", description: "Build community", isCompleted: false),
            Milestone(id: 5, title: "Monetize", description: "Generate revenue", isCompleted: false)
        ]
    ),
    Roadmap(
        title: "Software Engineer",
        milestones: [
            Milestone(id: 1, title: "Learn Basics", description: "Programming fundamentals", isCompleted: true),
            Milestone(id: 2, title: "Build Projects", description: "Portfolio development", isCompleted: false),
            Milestone(id: 3, title: "Apply Jobs", description: "Job search", isCompleted: false),
            Milestone(id: 4, title: "First Role", description: "Entry position", isCompleted: false),
            Milestone(id: 5, title: "Senior Role", description: "Career growth", isCompleted: false)
        ]
    ),
    Roadmap(
        title: "Entrepreneur",
        milestones: [
            Milestone(id: 1, title: "Idea Validation", description: "Test concept", isCompleted: true),
            Milestone(id: 2, title: "MVP", description: "Build prototype", isCompleted: true),
            Milestone(id: 3, title: "Launch", description: "Go to market", isCompleted: true),
            Milestone(id: 4, title: "Scale", description: "Grow business", isCompleted: false),
            Milestone(id: 5, title: "Exit", description: "Acquisition/IPO", isCompleted: false)
        ]
    )
]
