//
//  RoadmapView.swift
//  SynrgyApp
//
//  Created by Obinna Nwaokoro on 9/27/25.
//

import SwiftUI

struct RoadmapView: View {
    @State var boo = true
    @State var currentDetent: PresentationDetent = .fraction(0.4)
    let base: CGFloat = 199
    let roadmap: Roadmap
    
    var body: some View {
        TimelineRoadmapView(roadmap: roadmap)
            .contentShape(Rectangle())
            .onTapGesture {
                if currentDetent == .fraction(0.4) {
                    currentDetent = .height(base)
                }
            }
            .sheet(isPresented: $boo) {
                MessagesView()
                    .presentationDetents([.height(base), .height(base+1)], selection: $currentDetent)
                    .presentationBackgroundInteraction(.enabled(upThrough: .height(200)))
                    .presentationDragIndicator(.visible)
                    .interactiveDismissDisabled(true)
            }
    }
}

#Preview {
    RoadmapView(roadmap: Roadmap(
        title: "Entrepreneur",
        milestones: [
            Milestone(
                id: 1,
                title: "Idea Validation",
                description: "Test and validate your business concept",
                isCompleted: true,
                resources: [
                    MilestoneResource(title: "Validation Framework", link: "https://example.com/validation-framework"),
                    MilestoneResource(title: "Market Research Tools", link: "https://example.com/market-research")
                ]
            ),
            Milestone(
                id: 2,
                title: "Build MVP",
                description: "Create minimum viable product",
                isCompleted: true,
                resources: [
                    MilestoneResource(title: "MVP Development Guide", link: "https://example.com/mvp-guide"),
                    MilestoneResource(title: "Rapid Prototyping", link: "https://example.com/prototyping")
                ]
            ),
            Milestone(
                id: 3,
                title: "Launch Product",
                description: "Go to market with your solution",
                isCompleted: true,
                resources: [
                    MilestoneResource(title: "Launch Strategy", link: "https://example.com/launch-strategy"),
                    MilestoneResource(title: "Marketing Basics", link: "https://example.com/marketing-basics")
                ]
            ),
            Milestone(
                id: 4,
                title: "Scale Business",
                description: "Grow and expand your business operations",
                isCompleted: false,
                resources: [
                    MilestoneResource(title: "Scaling Strategies", link: "https://example.com/scaling"),
                    MilestoneResource(title: "Operations Management", link: "https://example.com/operations")
                ]
            ),
            Milestone(
                id: 5,
                title: "Exit Strategy",
                description: "Plan for acquisition or IPO",
                isCompleted: false,
                resources: [
                    MilestoneResource(title: "Exit Planning Guide", link: "https://example.com/exit-planning"),
                    MilestoneResource(title: "Valuation Methods", link: "https://example.com/valuation")
                ]
            )
        ]
    ))
}
