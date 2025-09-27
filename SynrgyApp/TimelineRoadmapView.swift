//
//  TimelineRoadmapView 2.swift
//  SynrgyApp
//
//  Created by Obinna Nwaokoro on 9/27/25.
//


//
//  TimelineRoadmapView.swift
//  SynrgyApp
//
//  Created by Obinna Nwaokoro on 9/27/25.
//

import SwiftUI

struct TimelineRoadmapView: View {
    let milestones: [Milestone]
    @Binding var isLoading: Bool // Loading state binding

    // ————— Layout Constants —————
    private let titleTopPadding: CGFloat       = 24
    private let firstMilestoneOffset: CGFloat  = 40
    private let milestoneSpacing: CGFloat      = 40
    private let betweenTitleDesc: CGFloat      = 0
    private let bottomPromptOffset: CGFloat    = 40
    private let bottomPromptPadding: CGFloat   = 60
    private let horizontalPadding: CGFloat     = 16
    private let markerSize: CGFloat            = 28 + 8
    private let lineWidth: CGFloat             = 2
    
    init(milestones: [Milestone]? = nil, isLoading: Binding<Bool> = .constant(false)) {
        if let milestones = milestones {
            self.milestones = milestones
        } else {
            self.milestones = [
                .init(
                    id: 1,
                    title: "Choose Your Niche",
                    description: "Identify your unique voice and establish expertise in a targeted subject area",
                    isCompleted: true
                ),
                .init(
                    id: 2,
                    title: "Setup Platforms",
                    description: "Create branded profiles on 1-2 channels",
                    isCompleted: true
                ),
                .init(
                    id: 3,
                    title: "Content Calendar",
                    description: "Produce 2-3 posts per week with batches",
                    isCompleted: false
                ),
                .init(
                    id: 4,
                    title: "Engage Audience",
                    description: "Use SEO, cross-promote, and reply daily",
                    isCompleted: false
                ),
                .init(
                    id: 5,
                    title: "Monetize Growth",
                    description: "Test revenue streams and reinvest for growth",
                    isCompleted: false
                )
            ]
        }
        self._isLoading = isLoading
    }

    var body: some View {
        VStack(spacing: 0) {
            // Header
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
            
            // Content
            ZStack(alignment: .top) {
                Color(red: 245/255, green: 245/255, blue: 245/255)
                    .ignoresSafeArea(edges: .bottom)
                
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 0) {
                        // Title
                        Text("Career Roadmap")
                            .font(.system(size: 32, weight: .bold))
                            .foregroundColor(.black)
                            .padding(.top, titleTopPadding)
                            .padding(.horizontal, 24)
                            .padding(.bottom, 16)
                            
                        // Timeline + Milestones
                        VStack(alignment: .leading, spacing: milestoneSpacing) {
                            ForEach(milestones) { m in
                                HStack(alignment: .top, spacing: horizontalPadding) {
                                    ZStack(alignment: .center) {
                                        if m.id != milestones.count {
                                            Rectangle()
                                                .frame(width: 1)
                                                .foregroundStyle(Color(red: 200/255, green: 200/255, blue: 200/255))
                                                .padding(.top, markerSize/2)
                                                .padding(.bottom, -80)
                                        }
                                        VStack {
                                            TimelineMarker(number: m.id, size: markerSize, isCompleted: m.isCompleted)
                                            Spacer()
                                        }
                                    }
                                    VStack(alignment: .leading, spacing: betweenTitleDesc) {
                                        Text(m.title)
                                            .font(.system(size: 22, weight: .bold))
                                            .foregroundColor(.black)
                                            .padding(.top, 4)
                                        Text(m.description)
                                            .font(.system(size: 18, weight: .regular))
                                            .foregroundColor(.black)
                                            .lineLimit(2, reservesSpace: true)
                                            .padding(.bottom, 4)
                                    }
                                    Spacer()
                                }
                            }
                        }
                        .padding(.top, 8)
                        .padding(.horizontal, 24)
                        
                        // Bottom Prompt
                        HStack {
                            Spacer()
                            Text("What next?")
                                .font(.system(size: 24, weight: .semibold))
                                .foregroundColor(.black)
                        }
                        .padding(.trailing, 24)
                    }
                    .frame(maxWidth: 500)
                }
            }
        }
    }
}

private struct TimelineMarker: View {
    let number: Int
    let size: CGFloat
    let isCompleted: Bool

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.black, lineWidth: 1)
                .background(RoundedRectangle(cornerRadius: 8).fill(isCompleted ? Color.black : Color.white))
                .frame(width: size, height: size)
            Text("\(number)")
                .font(.system(size: 22, weight: .semibold))
                .foregroundColor(isCompleted ? .white : .black)
        }
        .frame(width: size, height: size)
    }
}

struct TimelineRoadmapView_Previews: PreviewProvider {
    static var previews: some View {
        TimelineRoadmapView()
    }
}

import Foundation

public struct Milestone: Identifiable, Codable, Equatable {
    public let id: Int
    public let title: String
    public let description: String
    public var isCompleted: Bool
    
    public init(id: Int, title: String, description: String, isCompleted: Bool = false) {
        self.id = id
        self.title = title
        self.description = description
        self.isCompleted = isCompleted
    }
}

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
