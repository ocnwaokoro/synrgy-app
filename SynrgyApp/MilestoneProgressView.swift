//
//  MilestoneProgressView.swift
//  SynrgyApp
//
//  Created by Obinna Nwaokoro on 9/27/25.
//

import SwiftUI

struct Roadmap: Identifiable, Codable {
    let id: UUID
    let title: String
    let milestones: [Milestone]
    
    var currentStepIndex: Int {
        // Find the first incomplete milestone, or return last index if all complete
        return milestones.firstIndex { !$0.isCompleted } ?? (milestones.count - 1)
    }
    
    init(title: String, milestones: [Milestone]) {
        self.id = UUID()
        self.title = title
        self.milestones = milestones
    }
}

struct MilestoneProgressView: View {
    let roadmap: Roadmap
    private let dotSize: CGFloat = 12
    private let dotRadius: CGFloat = 6
    private let positions: [CGPoint]
    
    init(roadmap: Roadmap) {
        self.roadmap = roadmap
        
        var calculatedPositions: [CGPoint] = []
        
        for index in 0..<roadmap.milestones.count {
            let baseX: CGFloat = 60 + (CGFloat(index) * 70)
            let baseY: CGFloat = 60
            
            if index == 0 {
                calculatedPositions.append(CGPoint(x: baseX, y: baseY))
            } else {
                let angles: [CGFloat] = [-45, 45]
                let randomAngle = angles.randomElement() ?? 0
                let offsetDistance: CGFloat = 25
                let radians = randomAngle * .pi / 180
                
                calculatedPositions.append(CGPoint(
                    x: baseX + (cos(radians) * offsetDistance),
                    y: baseY + (sin(radians) * offsetDistance)
                ))
            }
        }
        
        self.positions = calculatedPositions
    }
    
    var body: some View {
        ZStack {
            // Draw all lines first
            ForEach(0..<positions.count-1, id: \.self) { index in
                let start = positions[index]
                let end = positions[index + 1]
                
                LineShape(from: start, to: end)
                    .stroke(Color.gray.opacity(0.3), lineWidth: 2)
            }
            
            // Draw all dots on top
            ForEach(Array(roadmap.milestones.enumerated()), id: \.element.id) { index, milestone in
                Circle()
                    .fill(getDotColor(for: index, milestone: milestone))
                    .frame(width: dotSize, height: dotSize)
                    .position(positions[index])
            }
        }
        .frame(height: 120)
    }
    
    private func getDotColor(for index: Int, milestone: Milestone) -> Color {
        if index == roadmap.currentStepIndex - 1 {
            return .blue
        } else if milestone.isCompleted {
            return .black
        } else {
            return Color.gray.opacity(0.3)
        }
    }
}
struct LineShape: Shape {
    let from: CGPoint
    let to: CGPoint
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: from)
        path.addLine(to: to)
        return path
    }
}

#Preview {
    MilestoneProgressView(roadmap: sampleRoadmap)
}

let sampleRoadmap = Roadmap(
    title: "Content Creator Journey",
    milestones: [
        Milestone(id: 1, title: "Choose Your Niche", description: "Identify your unique voice and establish expertise", isCompleted: true),
        Milestone(id: 2, title: "Setup Platforms", description: "Create branded profiles on 1-2 channels", isCompleted: true),
        Milestone(id: 3, title: "Content Calendar", description: "Produce 2-3 posts per week with batches", isCompleted: false),
        Milestone(id: 4, title: "Engage Audience", description: "Use SEO, cross-promote, and reply daily", isCompleted: false),
        Milestone(id: 5, title: "Monetize Growth", description: "Test revenue streams and reinvest for growth", isCompleted: false)
    ]
)


struct MultiRoadmapProgressView: View {
    let roadmaps: [Roadmap]
    private let dotSize: CGFloat = 12
    private let roadmapSpacing: CGFloat = 30
    private let stepSpacing: CGFloat = 35
    
    var body: some View {
        VStack(spacing: roadmapSpacing) {
            ForEach(roadmaps) { roadmap in
                HStack(spacing: 16) {
                    // Title
                    Text(roadmap.title)
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .frame(width: 140, alignment: .leading)
                        .lineLimit(2)
                    
                    // Progress dots
                    HStack(spacing: 0) {
                        ForEach(0..<5, id: \.self) { stepIndex in
                            HStack(spacing: 0) {
                                Circle()
                                    .fill(getDotColor(roadmap: roadmap, stepIndex: stepIndex))
                                    .frame(width: dotSize, height: dotSize)
                                
                                if stepIndex < 4 {
                                    Rectangle()
                                        .fill(Color.gray.opacity(0.3))
                                        .frame(width: stepSpacing, height: 2)
                                }
                            }
                        }
                    }
                    
                    Spacer()
                }
            }
        }
        .padding()
    }
    
    private func getDotColor(roadmap: Roadmap, stepIndex: Int) -> Color {
        if stepIndex < roadmap.milestones.count {
            let milestone = roadmap.milestones[stepIndex]
            if stepIndex == roadmap.currentStepIndex {
                return .blue
            } else if milestone.isCompleted {
                return .black
            }
        }
        return Color.gray.opacity(0.3)
    }
}

// Sample data
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

//#Preview {
//    MultiRoadmapProgressView(roadmaps: sampleRoadmaps)
//}

struct CenteredMilestoneProgressView: View {
    let roadmap: Roadmap
    let roadmapIndex: Int
    let totalRoadmaps: Int
    private let dotSize: CGFloat = 12
    private let dotRadius: CGFloat = 6
    private let positions: [CGPoint]
    private let rotationAngle: Double
    
    init(roadmap: Roadmap, roadmapIndex: Int = 0, totalRoadmaps: Int = 1) {
        self.roadmap = roadmap
        self.roadmapIndex = roadmapIndex
        self.totalRoadmaps = totalRoadmaps
        
        if totalRoadmaps == 1 {
            self.rotationAngle = 270
        } else {
            let angleStep = 180.0 / Double(totalRoadmaps + 1)
            self.rotationAngle = 180 + (Double(roadmapIndex + 1) * angleStep)
        }
        
        var calculatedPositions: [CGPoint] = []
        let centerX: CGFloat = 150
        let baseY: CGFloat = 60
        let stepDistance: CGFloat = 50
        
        for index in 0..<roadmap.milestones.count {
            if index == roadmap.currentStepIndex {
                calculatedPositions.append(CGPoint(x: centerX, y: baseY))
            } else {
                let baseX: CGFloat = centerX + (CGFloat(index - roadmap.currentStepIndex) * stepDistance)
                
                if abs(index - roadmap.currentStepIndex) == 1 {
                    calculatedPositions.append(CGPoint(x: baseX, y: baseY))
                } else {
                    let angles: [CGFloat] = [-45, 45]
                    let randomAngle = angles.randomElement() ?? 0
                    let offsetDistance: CGFloat = 25
                    let radians = randomAngle * .pi / 180
                    
                    calculatedPositions.append(CGPoint(
                        x: baseX + (cos(radians) * offsetDistance),
                        y: baseY + (sin(radians) * offsetDistance)
                    ))
                }
            }
        }
        
        self.positions = calculatedPositions
    }
    
    var body: some View {
        ZStack {
            ForEach(0..<positions.count-1, id: \.self) { index in
                let start = positions[index]
                let end = positions[index + 1]
                
                LineShape(from: start, to: end)
                    .stroke(Color.gray.opacity(0.3), lineWidth: 2)
            }
            
            ForEach(Array(roadmap.milestones.enumerated()), id: \.element.id) { index, milestone in
                Circle()
                    .fill(getDotColor(for: index, milestone: milestone))
                    .frame(width: dotSize, height: dotSize)
                    .position(positions[index])
            }
        }
        .frame(width: 300, height: 120)
        .rotationEffect(.degrees(rotationAngle))
    }
    
    private func getDotColor(for index: Int, milestone: Milestone) -> Color {
        if index == roadmap.currentStepIndex {
            return .blue
        } else if milestone.isCompleted {
            return .black
        } else {
            return Color.gray.opacity(0.3)
        }
    }
}

struct MultiRoadmapNexusView: View {
    let roadmaps: [Roadmap]
    
    var body: some View {
        ZStack {
            ForEach(Array(roadmaps.enumerated()), id: \.element.id) { index, roadmap in
                CenteredMilestoneProgressView(
                    roadmap: roadmap,
                    roadmapIndex: index,
                    totalRoadmaps: roadmaps.count
                )
                .opacity(0.8)
            }
        }
    }
}

//struct LineShape: Shape {
//    let from: CGPoint
//    let to: CGPoint
//    
//    func path(in rect: CGRect) -> Path {
//        var path = Path()
//        path.move(to: from)
//        path.addLine(to: to)
//        return path
//    }
//}

// Sample roadmaps with different progress states
let nexusRoadmaps = [
    Roadmap(
        title: "Content Creator",
        milestones: [
            Milestone(id: 1, title: "Choose Niche", description: "Find focus", isCompleted: true),
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
    MultiRoadmapNexusView(roadmaps: nexusRoadmaps)
}
