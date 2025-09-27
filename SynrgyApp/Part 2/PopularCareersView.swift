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
                VStack(spacing: 8) {
                    HStack(spacing: 0) {
                        ForEach(Array(careers.prefix(4))) { career in
                            PopularCareerButton(career: career)
                        }
                    }
                    HStack(spacing: 0) {
                        ForEach(Array(careers.dropFirst(4))) { career in
                            PopularCareerButton(career: career)
                        }
                    }
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
            }
        }
    }
}

struct PopularCareerButton: View {
    let career: PopularCareer
    
    var body: some View {
        HStack(spacing: 8) {
            Circle()
                .fill(career.color)
                .frame(width: 40, height: 40)
                .overlay(
                    Image(systemName: career.icon)
                        .foregroundColor(.white)
                        .font(.system(size: 18))
                )
            Text(career.title)
                .font(.caption)
                .fontWeight(.medium)
                .multilineTextAlignment(.center)
                .lineLimit(1)
            Spacer()
        }
        .frame(width: 140)
    }
}

struct PopularCareer: Identifiable {
    let id = UUID()
    let title: String
    let icon: String
    let color: Color
}

let popularCareers = [
    PopularCareer(title: "Software Engineer", icon: "laptopcomputer", color: .blue),
    PopularCareer(title: "Data Scientist", icon: "chart.bar.fill", color: .green),
    PopularCareer(title: "Product Manager", icon: "briefcase.fill", color: .purple),
    PopularCareer(title: "UX Designer", icon: "paintbrush.fill", color: .orange),
    PopularCareer(title: "Marketing Manager", icon: "megaphone.fill", color: .red),
    PopularCareer(title: "Sales Rep", icon: "person.2.fill", color: .cyan),
    PopularCareer(title: "Content Creator", icon: "camera.fill", color: .pink),
    PopularCareer(title: "Consultant", icon: "lightbulb.fill", color: .yellow),
    PopularCareer(title: "Financial Analyst", icon: "chart.line.uptrend.xyaxis", color: .mint),
    PopularCareer(title: "Project Manager", icon: "list.bullet.clipboard.fill", color: .indigo)
]

#Preview {
    PopularCareersView(careers: popularCareers)
}