//
//  TimelineRoadmapView.swift
//  SynrgyApp
//
//  Created by Obinna Nwaokoro on 9/27/25.
//

// MARK: - Models
import Foundation
import SwiftUI

// MARK: - MilestoneResource
public struct MilestoneResource: Identifiable, Codable, Equatable, Hashable {
    public let id: UUID
    public let title: String
    public let link: String
    
    public init(title: String, link: String) {
        self.id = UUID()
        self.title = title
        self.link = link
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

// MARK: - Milestone
public struct Milestone: Identifiable, Codable, Equatable, Hashable {
    public let id: Int
    public let title: String
    public let description: String
    public var isCompleted: Bool
    public let resources: [MilestoneResource]

    public init(
        id: Int, title: String, description: String, isCompleted: Bool = false,
        resources: [MilestoneResource] = []
    ) {
        self.id = id
        self.title = title
        self.description = description
        self.isCompleted = isCompleted
        self.resources = resources
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

// MARK: - Main View
struct TimelineRoadmapView: View {
    let roadmap: Roadmap
    @Binding var isLoading: Bool
    @Environment(\.dismiss) private var dismiss
    let onBack: () -> Void
    @State private var showMessages = true  // Added back the messages sheet state
    @State private var currentDetent: PresentationDetent = .fraction(0.4)  // Added detent state

    private let titleTopPadding: CGFloat = 24
    private let milestoneSpacing: CGFloat = 40
    private let betweenTitleDesc: CGFloat = 0
    private let horizontalPadding: CGFloat = 16
    private let markerSize: CGFloat = 28 + 8
    private let base: CGFloat = 199  // Added base height for messages

    init(
        roadmap: Roadmap,
        isLoading: Binding<Bool> = .constant(false),
        onBack: @escaping () -> Void = {}
    ) {
        self.roadmap = roadmap
        self._isLoading = isLoading
        self.onBack = onBack
    }

    var body: some View {
        VStack(spacing: 0) {
            NavigationHeader(
                onBack: {
                    print("TimelineRoadmapView: Back button tapped")
                    onBack()
                },
                onDone: {
                    // Handle done action
                    print("TimelineRoadmapView: Done button tapped")
                    onBack()
                }, title: roadmap.title
            )

            ZStack(alignment: .top) {
                Color(red: 245 / 255, green: 245 / 255, blue: 245 / 255)
                    .ignoresSafeArea()

                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 0) {
                        //                        TimelineTitle(topPadding: titleTopPadding)

                        VStack(alignment: .leading, spacing: milestoneSpacing) {
                            ForEach(roadmap.milestones.indices, id: \.self) { index in
                                MilestoneRow(
                                    milestone: roadmap.milestones[index],
                                    index: index,
                                    totalCount: roadmap.milestones.count,
                                    milestoneSpacing: milestoneSpacing,
                                    horizontalPadding: horizontalPadding,
                                    markerSize: markerSize,
                                    betweenTitleDesc: betweenTitleDesc
                                ) {
                                    // TODO: Update milestone completion in UnifiedRoadmapData
                                    print("TimelineRoadmapView: Toggled milestone \(roadmap.milestones[index].id) completion")
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
            .sheet(isPresented: $showMessages) {
                MessagesView()
                    .presentationDetents([.height(base), .height(base+1)], selection: $currentDetent)
                    .presentationBackgroundInteraction(.enabled(upThrough: .height(200)))
                    .presentationDragIndicator(.visible)
                    .interactiveDismissDisabled(true)
            }
        }
    }
}
// MARK: - Navigation Header
private struct NavigationHeader: View {
    let onBack: () -> Void
    let onDone: () -> Void
    let title: String
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
            Text(title)
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
    @State var milestone: Milestone
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
                        isCompleted: $milestone.isCompleted,
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
    @Binding var isCompleted: Bool
    let onTap: () -> Void

    var body: some View {
        Button(action: {onTap(); isCompleted.toggle()}) {
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
    let resources: [MilestoneResource]

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 6) {
                ForEach(resources, id: \.id) { resource in
                    Button(action: {
                        if let url = URL(string: resource.link) {
                            UIApplication.shared.open(url)
                        }
                    }) {
                        Text(resource.title)
                            .font(.system(size: 11, weight: .medium))
                            .foregroundColor(.black)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(Color.gray.opacity(0.25))
                            .cornerRadius(6)
                            .lineLimit(1)
                            .fixedSize(horizontal: true, vertical: false)
                    }
                    .buttonStyle(PlainButtonStyle())
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
        TimelineRoadmapView(
            roadmap: UnifiedRoadmapData.shared.sharedRoadmaps[0],
            onBack: {
                print("Preview: Back button tapped")
            }
        )
    }
}
