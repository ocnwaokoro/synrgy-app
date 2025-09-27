//
//  RecentActionsView.swift
//  SynrgyApp
//
//  Created by Obinna Nwaokoro on 9/27/25.
//


import SwiftUI

struct RecentActionsView: View {
    @State private var achievements = Achievement.sampleAchievements
    
    var body: some View {
        Section {
            ForEach(achievements) { achievement in
                AchievementView(achievement: achievement)
            }
        } header: {
            HStack {
                Text("Recent Achievements")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .textCase(nil)

                Spacer()

                Text("More")
                    .foregroundColor(.blue)
                    .font(.subheadline)
                    .textCase(nil)
            }
            .listRowInsets(
                EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
        }
    }
}

struct AchievementView: View {
    let achievement: Achievement
    
    private var statusIcon: String {
        achievement.isPositive ? "plus" : "minus"
    }
    
    private var statusColor: Color {
        achievement.isPositive ? .green : .red
    }
    
    private var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter.string(from: achievement.date)
    }
    
    var body: some View {
        HStack(spacing: 12) {
            // Status Icon (Green + or Red -)
            Circle()
                .fill(statusColor.opacity(0.2))
                .frame(width: 40, height: 40)
                .overlay(
                    Image(systemName: statusIcon)
                        .foregroundColor(statusColor)
                        .font(.system(size: 16, weight: .bold))
                )

            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text(achievement.title)
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .foregroundColor(.primary)
                    
                    Spacer()
                    
                    Text(formattedDate)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                
                Text(achievement.description)
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .lineLimit(2)
                
                // Category tag
                Text(achievement.category.displayName)
                    .font(.caption2)
                    .foregroundColor(.blue)
                    .padding(.horizontal, 6)
                    .padding(.vertical, 2)
                    .background(Color.blue.opacity(0.1))
                    .cornerRadius(4)
            }

            Spacer()
        }
        .listRowInsets(
            EdgeInsets(top: 12, leading: 16, bottom: 12, trailing: 16)
        )
        .alignmentGuide(.listRowSeparatorLeading) { _ in 0 }
        .onTapGesture {
            print("Tapped on achievement: \(achievement.title)")
        }
    }
}

#Preview {
    List {
        RecentActionsView()
    }
    .listStyle(.insetGrouped)
    .scrollDisabled(true)
    .scrollContentBackground(.hidden)
    .background(.ultraThickMaterial)
}