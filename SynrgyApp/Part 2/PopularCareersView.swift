//
//  PopularCareersView.swift
//  SynrgyApp
//
//  Created by Obinna Nwaokoro on 9/27/25.
//

import SwiftUI

struct PopularCareersView: View {
    let careers: [PopularCareer] = popularCareers
    let onRoadmapSelected: (Roadmap) -> Void

    var body: some View {
        VStack(spacing: 0) {
            // Header with secondary color, left aligned
            HStack {
                Text("Popular")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(.secondary)

                Spacer()
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 4)

            // Divider under the title
            Divider()
                .padding(.leading, 16)

            // Horizontally scrollable grid with 2 rows
            ScrollView(.horizontal, showsIndicators: false) {
                VStack(spacing: 12) {
                    HStack(spacing: 12) {
                        ForEach(Array(careers.prefix(5))) { career in
                            PopularCareerButton(
                                career: career,
                                onTap: {
                                    if let roadmap = getRoadmapForCareer(career) {
                                        print("PopularCareersView: Tapped on career: \(career.title)")
                                        onRoadmapSelected(roadmap)
                                    }
                                }
                            )
                        }
                    }
                    HStack(spacing: 12) {
                        ForEach(Array(careers.dropFirst(5))) { career in
                            PopularCareerButton(
                                career: career,
                                onTap: {
                                    if let roadmap = getRoadmapForCareer(career) {
                                        print("PopularCareersView: Tapped on career: \(career.title)")
                                        onRoadmapSelected(roadmap)
                                    }
                                }
                            )
                        }
                    }
                }
//                .padding(.horizontal, 16)
                .padding(.vertical, 8)
            }
            
            IDKButton(action: {
                print("PopularCareersView: IDK button tapped")
                // TODO: Implement IDK functionality
            })
            .padding(.horizontal)
        }
    }
    
    private func getRoadmapForCareer(_ career: PopularCareer) -> Roadmap? {
        return popularCareerRoadmaps.first { $0.title == career.title }
    }
}

struct IDKButton: View {
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Spacer()
                Text("IDK")
                    .font(.system(size: 20, weight: .regular, design: .default))
                    .foregroundColor(.white)
                    .fontWeight(.semibold)
                    .padding(.vertical, 12)
                Spacer()
            }
            .background(
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(.black)
            )
        }
        .buttonStyle(PlainButtonStyle())
        .accessibilityLabel("I don't know")
    }
}

struct PopularCareerButton: View {
    let career: PopularCareer
    let onTap: () -> Void

    var body: some View {
        VStack(spacing: 8) {
            Circle()
                .fill(career.color)
                .frame(width: 40, height: 40)
                .overlay(
                    Image(systemName: career.icon)
                        .foregroundColor(.white)
                        .font(.system(size: 18))
                )

            VStack(spacing: 0) {
                Text(career.title)
                    .font(.caption)
                    .fontWeight(.medium)
                    .multilineTextAlignment(.center)
                    .lineLimit(nil)
                Spacer()
            }
            Spacer(minLength: 0)

        }
        .frame(width: 90, height: 80)
        .onTapGesture {
            print("PopularCareerButton: Tapped on career: \(career.title)")
            onTap()
        }
    }
}

struct PopularCareer: Identifiable {
    let id = UUID()
    let title: String
    let icon: String
    let color: Color
}

let popularCareers = [
    PopularCareer(title: "Engineer", icon: "laptopcomputer", color: .blue),
    PopularCareer(title: "Scientist", icon: "chart.bar.fill", color: .green),
    PopularCareer(title: "Manager", icon: "briefcase.fill", color: .purple),
    PopularCareer(title: "Designer", icon: "paintbrush.fill", color: .orange),
    PopularCareer(title: "Marketing", icon: "megaphone.fill", color: .red),
    PopularCareer(title: "Sales", icon: "person.2.fill", color: .cyan),
    PopularCareer(title: "Creator", icon: "camera.fill", color: .pink),
    PopularCareer(title: "Consultant", icon: "lightbulb.fill", color: .yellow),
    PopularCareer(title: "Analyst", icon: "chart.line.uptrend.xyaxis", color: .mint),
    PopularCareer(title: "Director", icon: "list.bullet.clipboard.fill", color: .indigo),
]

let popularCareerRoadmaps = [
    Roadmap(
        title: "Engineer",
        milestones: [
            Milestone(id: 1, title: "Learn Programming", description: "Master coding fundamentals", isCompleted: false, resources: []),
            Milestone(id: 2, title: "Build Portfolio", description: "Create projects to showcase skills", isCompleted: false, resources: []),
            Milestone(id: 3, title: "Apply for Jobs", description: "Start your job search", isCompleted: false, resources: []),
            Milestone(id: 4, title: "First Role", description: "Land your first engineering position", isCompleted: false, resources: []),
            Milestone(id: 5, title: "Senior Engineer", description: "Advance to senior level", isCompleted: false, resources: [])
        ]
    ),
    Roadmap(
        title: "Scientist",
        milestones: [
            Milestone(id: 1, title: "Choose Field", description: "Select your scientific discipline", isCompleted: false, resources: []),
            Milestone(id: 2, title: "Advanced Degree", description: "Pursue graduate studies", isCompleted: false, resources: []),
            Milestone(id: 3, title: "Research Experience", description: "Gain hands-on research experience", isCompleted: false, resources: []),
            Milestone(id: 4, title: "Publish Papers", description: "Contribute to scientific literature", isCompleted: false, resources: []),
            Milestone(id: 5, title: "Lead Research", description: "Lead your own research projects", isCompleted: false, resources: [])
        ]
    ),
    Roadmap(
        title: "Manager",
        milestones: [
            Milestone(id: 1, title: "Gain Experience", description: "Build expertise in your field", isCompleted: false, resources: []),
            Milestone(id: 2, title: "Lead Projects", description: "Take on leadership responsibilities", isCompleted: false, resources: []),
            Milestone(id: 3, title: "Develop Team", description: "Learn to manage and develop people", isCompleted: false, resources: []),
            Milestone(id: 4, title: "Strategic Thinking", description: "Develop business strategy skills", isCompleted: false, resources: []),
            Milestone(id: 5, title: "Executive Role", description: "Advance to executive positions", isCompleted: false, resources: [])
        ]
    ),
    Roadmap(
        title: "Designer",
        milestones: [
            Milestone(id: 1, title: "Learn Design Tools", description: "Master design software and principles", isCompleted: false, resources: []),
            Milestone(id: 2, title: "Build Portfolio", description: "Create a strong design portfolio", isCompleted: false, resources: []),
            Milestone(id: 3, title: "Client Work", description: "Take on freelance or agency projects", isCompleted: false, resources: []),
            Milestone(id: 4, title: "Specialize", description: "Focus on a design specialty", isCompleted: false, resources: []),
            Milestone(id: 5, title: "Design Lead", description: "Lead design teams and strategy", isCompleted: false, resources: [])
        ]
    ),
    Roadmap(
        title: "Marketing",
        milestones: [
            Milestone(id: 1, title: "Learn Fundamentals", description: "Understand marketing principles", isCompleted: false, resources: []),
            Milestone(id: 2, title: "Digital Skills", description: "Master digital marketing tools", isCompleted: false, resources: []),
            Milestone(id: 3, title: "Campaign Experience", description: "Run successful marketing campaigns", isCompleted: false, resources: []),
            Milestone(id: 4, title: "Analytics", description: "Learn to measure and optimize", isCompleted: false, resources: []),
            Milestone(id: 5, title: "Marketing Director", description: "Lead marketing strategy", isCompleted: false, resources: [])
        ]
    ),
    Roadmap(
        title: "Sales",
        milestones: [
            Milestone(id: 1, title: "Learn Sales Process", description: "Understand sales fundamentals", isCompleted: false, resources: []),
            Milestone(id: 2, title: "Build Network", description: "Develop professional relationships", isCompleted: false, resources: []),
            Milestone(id: 3, title: "Hit Targets", description: "Consistently meet sales goals", isCompleted: false, resources: []),
            Milestone(id: 4, title: "Team Leadership", description: "Lead sales teams", isCompleted: false, resources: []),
            Milestone(id: 5, title: "Sales Director", description: "Oversee sales strategy", isCompleted: false, resources: [])
        ]
    ),
    Roadmap(
        title: "Creator",
        milestones: [
            Milestone(id: 1, title: "Find Niche", description: "Identify your unique voice", isCompleted: false, resources: []),
            Milestone(id: 2, title: "Build Audience", description: "Grow your following", isCompleted: false, resources: []),
            Milestone(id: 3, title: "Consistent Content", description: "Create regular content", isCompleted: false, resources: []),
            Milestone(id: 4, title: "Monetize", description: "Turn passion into income", isCompleted: false, resources: []),
            Milestone(id: 5, title: "Scale Business", description: "Build a creator business", isCompleted: false, resources: [])
        ]
    ),
    Roadmap(
        title: "Consultant",
        milestones: [
            Milestone(id: 1, title: "Build Expertise", description: "Develop deep knowledge in your field", isCompleted: false, resources: []),
            Milestone(id: 2, title: "Network", description: "Build professional relationships", isCompleted: false, resources: []),
            Milestone(id: 3, title: "First Clients", description: "Land your first consulting projects", isCompleted: false, resources: []),
            Milestone(id: 4, title: "Build Reputation", description: "Establish credibility and referrals", isCompleted: false, resources: []),
            Milestone(id: 5, title: "Scale Practice", description: "Grow your consulting business", isCompleted: false, resources: [])
        ]
    ),
    Roadmap(
        title: "Analyst",
        milestones: [
            Milestone(id: 1, title: "Learn Analytics", description: "Master data analysis tools", isCompleted: false, resources: []),
            Milestone(id: 2, title: "Statistical Skills", description: "Develop statistical knowledge", isCompleted: false, resources: []),
            Milestone(id: 3, title: "Business Understanding", description: "Learn business context", isCompleted: false, resources: []),
            Milestone(id: 4, title: "Insights", description: "Generate actionable insights", isCompleted: false, resources: []),
            Milestone(id: 5, title: "Senior Analyst", description: "Lead analytical projects", isCompleted: false, resources: [])
        ]
    ),
    Roadmap(
        title: "Director",
        milestones: [
            Milestone(id: 1, title: "Proven Track Record", description: "Demonstrate consistent results", isCompleted: false, resources: []),
            Milestone(id: 2, title: "Leadership Skills", description: "Develop management capabilities", isCompleted: false, resources: []),
            Milestone(id: 3, title: "Strategic Vision", description: "Think strategically about business", isCompleted: false, resources: []),
            Milestone(id: 4, title: "Team Building", description: "Build and lead high-performing teams", isCompleted: false, resources: []),
            Milestone(id: 5, title: "Executive Leadership", description: "Lead at the executive level", isCompleted: false, resources: [])
        ]
    )
]

#Preview {
    PopularCareersView(onRoadmapSelected: { roadmap in
        print("Preview: Selected roadmap: \(roadmap.title)")
    })
}
