//
//  PopularCareersView.swift
//  SynrgyApp
//
//  Created by Obinna Nwaokoro on 9/27/25.
//

import SwiftUI

struct PopularCareersView: View {
    let careers: [PopularCareer]

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
                            PopularCareerButton(career: career)
                        }
                    }
                    HStack(spacing: 12) {
                        ForEach(Array(careers.dropFirst(5))) { career in
                            PopularCareerButton(career: career)
                        }
                    }
                }
//                .padding(.horizontal, 16)
                .padding(.vertical, 8)
            }
            
            IDKButton(action: {})
                .padding(.horizontal)
        }
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

#Preview {
    PopularCareersView(careers: popularCareers)
}
