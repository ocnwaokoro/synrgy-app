//
//  RecentEngagementView.swift
//  SynrgyApp
//
//  Created by Obinna Nwaokoro on 9/27/25.
//

import SwiftUI

struct RecentEngagementView: View {
    let recentSearches: [RecentSearch]

    var body: some View {
        VStack(spacing: 0) {
            // Header with "Recents" and "More" button
            HStack {
                Text("Recents")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .textCase(nil)
                    .foregroundStyle(.secondary)

                Spacer()

                Text("More")
                    .foregroundColor(.blue)
                    .font(.subheadline)
                    .textCase(nil)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            
            // First divider after header
            Divider()
                .padding(.leading, 16)
            
            // Recent search items with dividers
            ForEach(Array(recentSearches.enumerated()), id: \.element.id) { index, search in
                SearchRecentItemView(search: search)
                
                // Add divider after each item (except the last one)
                if index < recentSearches.count - 1 {
                    Divider()
                        .padding(.leading, 16)
                }
            }
        }
    }
}

struct SearchRecentItemView: View {
    let search: RecentSearch
    private let iconSize: CGFloat = 24

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
                .font(.system(size: 16))
                .frame(width: iconSize, height: iconSize)

            VStack(alignment: .leading, spacing: 2) {
                Text(search.title)
                    .font(.subheadline)
                    .fontWeight(.medium)

                if let subtitle = search.subtitle {
                    Text(subtitle)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }

            Spacer()
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
    }
}

struct RecentSearch: Identifiable {
    let id = UUID()
    let title: String
    let subtitle: String?

    init(title: String, subtitle: String? = nil) {
        self.title = title
        self.subtitle = subtitle
    }
}

let sampleSearches = [
    RecentSearch(title: "545 Washington Blvd ⋅ Jersey City", subtitle: "Jersey City"),
    RecentSearch(title: "Crunch Fitness", subtitle: "Springfield"),
    RecentSearch(title: "1327-1339 Burnet Ave", subtitle: "Union"),
]

#Preview {
        RecentEngagementView(recentSearches: sampleSearches)
}
