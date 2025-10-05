//
//  UnifiedRoadmapData.swift
//  SynrgyApp
//
//  Created by Obinna Nwaokoro on 9/28/25.
//

import Foundation
import SwiftUI

// MARK: - Unified Roadmap Data Source
class UnifiedRoadmapData: ObservableObject {
    @Published var sharedRoadmaps: [Roadmap] = [
        Roadmap(
            title: "Content Creator",
            milestones: [
                Milestone(
                    id: 1,
                    title: "Choose Your Niche",
                    description: "Identify your unique voice and establish expertise",
                    isCompleted: true,
                    resources: [
                        MilestoneResource(title: "Niche Research Guide", link: "https://example.com/niche-guide"),
                        MilestoneResource(title: "Voice Development Tips", link: "https://example.com/voice-tips")
                    ]
                ),
                Milestone(
                    id: 2,
                    title: "Setup Platforms",
                    description: "Create branded profiles on 1-2 channels",
                    isCompleted: true,
                    resources: [
                        MilestoneResource(title: "Platform Setup Checklist", link: "https://example.com/platform-checklist"),
                        MilestoneResource(title: "Branding Guidelines", link: "https://example.com/branding-guide")
                    ]
                ),
                Milestone(
                    id: 3,
                    title: "Content Calendar",
                    description: "Produce 2-3 posts per week with batches",
                    isCompleted: false,
                    resources: [
                        MilestoneResource(title: "Content Planning Template", link: "https://example.com/content-template"),
                        MilestoneResource(title: "Batch Creation Guide", link: "https://example.com/batch-guide")
                    ]
                ),
                Milestone(
                    id: 4,
                    title: "Engage Audience",
                    description: "Use SEO, cross-promote, and reply daily",
                    isCompleted: false,
                    resources: [
                        MilestoneResource(title: "SEO Best Practices", link: "https://example.com/seo-guide"),
                        MilestoneResource(title: "Community Building", link: "https://example.com/community-guide")
                    ]
                ),
                Milestone(
                    id: 5,
                    title: "Monetize Growth",
                    description: "Test revenue streams and reinvest for growth",
                    isCompleted: false,
                    resources: [
                        MilestoneResource(title: "Monetization Strategies", link: "https://example.com/monetization"),
                        MilestoneResource(title: "Revenue Tracking", link: "https://example.com/revenue-tracking")
                    ]
                )
            ]
        ),
        Roadmap(
            title: "Software Engineer",
            milestones: [
                Milestone(
                    id: 1,
                    title: "Learn Fundamentals",
                    description: "Master programming basics and data structures",
                    isCompleted: true,
                    resources: [
                        MilestoneResource(title: "Programming Fundamentals Course", link: "https://example.com/programming-basics"),
                        MilestoneResource(title: "Data Structures Guide", link: "https://example.com/data-structures")
                    ]
                ),
                Milestone(
                    id: 2,
                    title: "Build Projects",
                    description: "Create portfolio projects to showcase skills",
                    isCompleted: false,
                    resources: [
                        MilestoneResource(title: "Project Ideas List", link: "https://example.com/project-ideas"),
                        MilestoneResource(title: "Portfolio Building Guide", link: "https://example.com/portfolio-guide")
                    ]
                ),
                Milestone(
                    id: 3,
                    title: "Apply for Jobs",
                    description: "Network, apply, and prepare for interviews",
                    isCompleted: false,
                    resources: [
                        MilestoneResource(title: "Job Search Strategy", link: "https://example.com/job-search"),
                        MilestoneResource(title: "Interview Preparation", link: "https://example.com/interview-prep")
                    ]
                ),
                Milestone(
                    id: 4,
                    title: "First Role",
                    description: "Land your first software engineering position",
                    isCompleted: false,
                    resources: [
                        MilestoneResource(title: "Entry-Level Job Guide", link: "https://example.com/entry-jobs"),
                        MilestoneResource(title: "Career Growth Tips", link: "https://example.com/career-growth")
                    ]
                ),
                Milestone(
                    id: 5,
                    title: "Senior Role",
                    description: "Advance to senior engineering positions",
                    isCompleted: false,
                    resources: [
                        MilestoneResource(title: "Senior Skills Development", link: "https://example.com/senior-skills"),
                        MilestoneResource(title: "Leadership in Tech", link: "https://example.com/tech-leadership")
                    ]
                )
            ]
        ),
        Roadmap(
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
        )
    ]
    
    // Singleton instance
    static let shared = UnifiedRoadmapData()
    
    private init() {
        print("UnifiedRoadmapData: Initialized with \(sharedRoadmaps.count) roadmaps")
    }
    
    // Helper methods for mutations
    func updateMilestoneCompletion(roadmapId: UUID, milestoneId: Int, isCompleted: Bool) {
        if let roadmapIndex = sharedRoadmaps.firstIndex(where: { $0.id == roadmapId }),
           let milestoneIndex = sharedRoadmaps[roadmapIndex].milestones.firstIndex(where: { $0.id == milestoneId }) {
            sharedRoadmaps[roadmapIndex].milestones[milestoneIndex].isCompleted = isCompleted
            print("UnifiedRoadmapData: Updated milestone \(milestoneId) completion to \(isCompleted)")
        }
    }
    
    func addRoadmap(_ roadmap: Roadmap) {
        sharedRoadmaps.append(roadmap)
        print("UnifiedRoadmapData: Added new roadmap '\(roadmap.title)'")
    }
    
    func removeRoadmap(withId id: UUID) {
        sharedRoadmaps.removeAll { $0.id == id }
        print("UnifiedRoadmapData: Removed roadmap with id \(id)")
    }
    
    func getRoadmap(byTitle title: String) -> Roadmap? {
        return sharedRoadmaps.first { $0.title == title }
    }
}
