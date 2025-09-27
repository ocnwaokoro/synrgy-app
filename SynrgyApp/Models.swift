//
//  Models.swift
//  SynrgyApp
//
//  Created by Obinna Nwaokoro on 9/26/25.
//

import SwiftUI

// MARK: - Content Category Enum
enum ContentCategory: String, CaseIterable, Identifiable {
    case career = "career"
    case gym = "gym"
    case trip = "trip"
    case goal = "goal"
    case cooking = "cooking"
    case add = "add"
    
    var id: String { rawValue }
    
    var displayName: String {
        switch self {
        case .career: return "Career"
        case .gym: return "Fitness"
        case .trip: return "Travel"
        case .goal: return "Goals"
        case .cooking: return "Cooking"
        case .add: return "Add"
        }
    }
    
    var icon: String {
        switch self {
        case .career: return "briefcase.fill"
        case .gym: return "figure.run"
        case .trip: return "airplane.departure"
        case .goal: return "target"
        case .cooking: return "fork.knife"
        case .add: return "plus"
        }
    }
    
    var color: Color {
        .blue
//        switch self {
//        case .career: return .blue
//        case .gym: return .blue
//        case .trip: return .blue
//        case .goal: return .blue
//        case .cooking: return .blue
//        case .add: return .blue
//        }
    }
}

// MARK: - Library Item Model
struct LibraryItem: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let color: Color
    let description: String
    let category: ContentCategory
    
    // 4 example items - all blue
    static let lawyer = LibraryItem(
        title: "Become a Lawyer",
        color: .blue,
        description: "",
        category: .career
    )
    
    static let weightLoss = LibraryItem(
        title: "Weight Loss",
        color: .blue,
        description: "",
        category: .gym
    )
    
    static let europeTrip = LibraryItem(
        title: "Europe Trip",
        color: .blue,
        description: "",
        category: .trip
    )
    
    static let learnSpanish = LibraryItem(
        title: "Learn Spanish",
        color: .blue,
        description: "",
        category: .goal
    )
    
    static let addNew = LibraryItem(
        title: "Add",
        color: .blue,
        description: "",
        category: .add
    )
}

// MARK: - Achievement Model
struct Achievement: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let description: String
    let date: Date
    let isPositive: Bool
    let category: ContentCategory
    let itemTitle: String
    
    static let sampleAchievements = [
        Achievement(
            title: "Completed LSAT Prep",
            description: "Finished 6-month study program",
            date: Date().addingTimeInterval(-86400 * 2),
            isPositive: true,
            category: .career,
            itemTitle: "Lawyer"
        ),
        Achievement(
            title: "Lost 5 lbs this week",
            description: "Reached weekly weight loss goal",
            date: Date().addingTimeInterval(-86400 * 1),
            isPositive: true,
            category: .gym,
            itemTitle: "Weight Loss"
        ),
        Achievement(
            title: "Booked flights to Paris",
            description: "Confirmed Europe trip flights",
            date: Date().addingTimeInterval(-86400 * 4),
            isPositive: true,
            category: .trip,
            itemTitle: "Europe Trip"
        )
    ]
}

// MARK: - Progress Model
struct ProgressStats {
    let completed: Int
    let pending: Int
    
    var displayText: String {
        "\(completed) Complete • \(pending) Pending"
    }
    
    static let sample = ProgressStats(completed: 16, pending: 7)
}
