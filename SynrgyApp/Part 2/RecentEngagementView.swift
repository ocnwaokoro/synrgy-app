//
//  RecentEngagementView.swift
//  SynrgyApp
//
//  Created by Obinna Nwaokoro on 9/27/25.
//

import SwiftUI

struct RecentEngagementView: View {
    let roadmaps: [Roadmap]
    let onRoadmapSelected: (Roadmap) -> Void

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
                RoadmapItemView(
                    roadmap: roadmap,
                    onTap: {
                        print("RecentEngagementView: Tapped on roadmap: \(roadmap.title)")
                        onRoadmapSelected(roadmap)
                    }
                )
                
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
    let onTap: () -> Void
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
        .onTapGesture {
            print("RoadmapItemView: Tapped on roadmap: \(roadmap.title)")
            onTap()
        }
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

#Preview {
    RecentEngagementView(
        roadmaps: UnifiedRoadmapData.shared.sharedRoadmaps,
        onRoadmapSelected: { roadmap in
            print("Preview: Selected roadmap: \(roadmap.title)")
        }
    )
}
