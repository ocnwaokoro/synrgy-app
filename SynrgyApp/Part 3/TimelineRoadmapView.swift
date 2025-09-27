//
//  TimelineRoadmapView.swift
//  SynrgyApp
//
//  Created by Obinna Nwaokoro on 9/27/25.
//

// MARK: - Models
import Foundation
import SwiftUI

// MARK: - Main View
struct TimelineRoadmapView: View {
    @State private var milestones: [Milestone]
    @Binding var isLoading: Bool
    @Environment(\.dismiss) private var dismiss

    private let titleTopPadding: CGFloat = 24
    private let milestoneSpacing: CGFloat = 40
    private let betweenTitleDesc: CGFloat = 0
    private let horizontalPadding: CGFloat = 16
    private let markerSize: CGFloat = 28 + 8

    init(
        milestones: [Milestone]? = nil,
        isLoading: Binding<Bool> = .constant(false)
    ) {
        if let milestones = milestones {
            self._milestones = State(initialValue: milestones)
        } else {
            self._milestones = State(initialValue: [
                .init(
                    id: 1, title: "Choose Your Niche",
                    description:
                        "Identify your unique voice and establish expertise in a targeted subject area",
                    isCompleted: true,
                    resources: ["YouTube", "TikTok", "Blog", "Course"]),
                .init(
                    id: 2, title: "Setup Platforms",
                    description: "Create branded profiles on 1-2 channels",
                    isCompleted: true,
                    resources: ["Instagram", "Twitter", "LinkedIn"]),
                .init(
                    id: 3, title: "Content Calendar",
                    description: "Produce 2-3 posts per week with batches",
                    isCompleted: false,
                    resources: ["Notion", "Canva", "Buffer", "Hootsuite"]),
                .init(
                    id: 4, title: "Engage Audience",
                    description: "Use SEO, cross-promote, and reply daily",
                    isCompleted: false,
                    resources: ["Google Analytics", "SEMrush", "BuzzSumo"]),
                .init(
                    id: 5, title: "Monetize Growth",
                    description: "Test revenue streams and reinvest for growth",
                    isCompleted: false,
                    resources: ["Stripe", "PayPal", "Patreon", "Gumroad"]),
            ])
        }
        self._isLoading = isLoading
    }

    var body: some View {
        VStack(spacing: 0) {
            NavigationHeader(
                onBack: { dismiss() },
                onDone: {
                    // Handle done action
                    print("Done button tapped")
                    dismiss()
                }
            )

            ZStack(alignment: .top) {
                Color(red: 245 / 255, green: 245 / 255, blue: 245 / 255)
                    .ignoresSafeArea()

                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 0) {
                        //                        TimelineTitle(topPadding: titleTopPadding)

                        VStack(alignment: .leading, spacing: milestoneSpacing) {
                            ForEach(milestones.indices, id: \.self) { index in
                                MilestoneRow(
                                    milestone: milestones[index],
                                    index: index,
                                    totalCount: milestones.count,
                                    milestoneSpacing: milestoneSpacing,
                                    horizontalPadding: horizontalPadding,
                                    markerSize: markerSize,
                                    betweenTitleDesc: betweenTitleDesc
                                ) {
                                    milestones[index].isCompleted.toggle()
                                }
                            }
                        }
                        .padding(.top, 8)
                        .padding(.horizontal, 24)

                        TimelineFooter()

                        // Long spacer
                        Spacer(minLength: 250)
                    }
                    .frame(maxWidth: 500)
                }
            }
        }
    }
}

// MARK: - Navigation Header
private struct NavigationHeader: View {
    let onBack: () -> Void
    let onDone: () -> Void

    var body: some View {
        HStack {
            // Back Button
            Button(action: onBack) {
                HStack(spacing: 4) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 16, weight: .medium))
                    Text("Back")
                        .font(.system(size: 16, weight: .medium))
                }
                .foregroundColor(.black)
            }

            Spacer()

            // Center Title
            Text("Career Roadmap")
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(.black)

            Spacer()

            // Done Button
            Button(action: onDone) {
                Text("Done")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.black)
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 16)
        .background(Color(red: 245 / 255, green: 245 / 255, blue: 245 / 255))
    }
}

// MARK: - Header Components
struct TimelineHeader: View {
    var body: some View {
        HStack(alignment: .center, spacing: 8) {
            LogoCircle()
            Text("Synrgy")
                .font(.system(size: 24, weight: .semibold, design: .default))
                .foregroundColor(.white)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.leading, 24)
        .padding(.vertical, 18)
        .background(Color.black)
    }
}

struct TimelineTitle: View {
    let topPadding: CGFloat

    var body: some View {
        Text("Career Roadmap")
            .font(.system(size: 32, weight: .bold))
            .foregroundColor(.black)
            .padding(.top, topPadding)
            .padding(.horizontal, 24)
            .padding(.bottom, 16)
    }
}

struct TimelineFooter: View {
    var body: some View {
        HStack {
            Spacer(minLength: 0)
            Text("Ready to personalize?")
                .font(.system(size: 24, weight: .semibold))
                .foregroundColor(.black)
                .padding(.top)
        }
        .padding(.trailing, 24)
    }
}

// MARK: - Milestone Components
struct MilestoneRow: View {
    let milestone: Milestone
    let index: Int
    let totalCount: Int
    let milestoneSpacing: CGFloat
    let horizontalPadding: CGFloat
    let markerSize: CGFloat
    let betweenTitleDesc: CGFloat
    let onToggle: () -> Void

    var body: some View {
        HStack(alignment: .top, spacing: horizontalPadding) {
            TimelineColumn(
                milestone: milestone,
                index: index,
                totalCount: totalCount,
                milestoneSpacing: milestoneSpacing,
                markerSize: markerSize,
                onToggle: onToggle
            )

            MilestoneContent(
                milestone: milestone,
                betweenTitleDesc: betweenTitleDesc
            )

            Spacer()
        }
    }
}

struct TimelineColumn: View {
    let milestone: Milestone
    let index: Int
    let totalCount: Int
    let milestoneSpacing: CGFloat
    let markerSize: CGFloat
    let onToggle: () -> Void

    var body: some View {
        ZStack(alignment: .center) {
            if index < totalCount - 1 {
                Rectangle()
                    .frame(width: 1)
                    .foregroundStyle(
                        Color(red: 200 / 255, green: 200 / 255, blue: 200 / 255)
                    )
                    .frame(height: milestoneSpacing + markerSize * 2)
                    .offset(x: 14, y: markerSize)
                    .padding(.bottom, -10)
            }

            VStack {
                HStack(spacing: 8) {
                    CheckboxView(
                        isCompleted: milestone.isCompleted,
                        onTap: onToggle
                    )

                    TimelineMarker(
                        number: milestone.id,
                        size: markerSize,
                        isCompleted: milestone.isCompleted
                    )
                }
                Spacer()
            }
        }
    }
}

struct MilestoneContent: View {
    let milestone: Milestone
    let betweenTitleDesc: CGFloat

    var body: some View {
        VStack(alignment: .leading, spacing: betweenTitleDesc) {
            Text(milestone.title)
                .font(.system(size: 22, weight: .bold))
                .foregroundColor(.black)
                .padding(.top, 4)

            Text(milestone.description)
                .font(.system(size: 18, weight: .regular))
                .foregroundColor(.black)
                .lineLimit(2, reservesSpace: true)
                .padding(.bottom, 4)

            ResourceTags(resources: milestone.resources)
        }
    }
}

// MARK: - Interactive Components
struct CheckboxView: View {
    let isCompleted: Bool
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            ZStack {
                RoundedRectangle(cornerRadius: 4)
                    .stroke(Color.black, lineWidth: 2)
                    .background(
                        RoundedRectangle(cornerRadius: 4)
                            .fill(isCompleted ? Color.black : Color.clear)
                    )
                    .frame(width: 20, height: 20)

                if isCompleted {
                    Image(systemName: "checkmark")
                        .font(.system(size: 12, weight: .bold))
                        .foregroundColor(.white)
                }
            }
        }
        .buttonStyle(PlainButtonStyle())
        .animation(.easeInOut(duration: 0.2), value: isCompleted)
    }
}

struct TimelineMarker: View {
    let number: Int
    let size: CGFloat
    let isCompleted: Bool

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.black, lineWidth: 1)
                .background(
                    RoundedRectangle(cornerRadius: 8).fill(
                        isCompleted ? Color.black : Color.white)
                )
                .frame(width: size, height: size)
            Text("\(number)")
                .font(.system(size: 22, weight: .semibold))
                .foregroundColor(isCompleted ? .white : .black)
        }
        .frame(width: size, height: size)
    }
}

// MARK: - Resource Components
struct ResourceTags: View {
    let resources: [String]

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 6) {
                ForEach(resources, id: \.self) { resource in
                    Text(resource)
                        .font(.system(size: 11, weight: .medium))
                        .foregroundColor(.black)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Color.gray.opacity(0.25))
                        .cornerRadius(6)
                        .lineLimit(1)
                        .fixedSize(horizontal: true, vertical: false)
                }
            }
            .padding(.horizontal, 2)
        }
    }
}

// MARK: - Logo Component
struct LogoCircle: View {
    var body: some View {
        ZStack {
            Circle()
                .fill(Color.white)
                .frame(width: 36, height: 36)
            Text("S")
                .font(.system(size: 24, weight: .bold, design: .default))
                .foregroundColor(.black)
        }
    }
}

// MARK: - Preview
struct TimelineRoadmapView_Previews: PreviewProvider {
    static var previews: some View {
        TimelineRoadmapView()
    }
}

public struct Milestone: Identifiable, Codable, Equatable {
    public let id: Int
    public let title: String
    public let description: String
    public var isCompleted: Bool
    public let resources: [String]

    public init(
        id: Int, title: String, description: String, isCompleted: Bool = false,
        resources: [String] = []
    ) {
        self.id = id
        self.title = title
        self.description = description
        self.isCompleted = isCompleted
        self.resources = resources
    }
}
