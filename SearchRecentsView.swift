//
//  SearchRecentsView.swift
//  SynrgyApp
//
//  Created by Obinna Nwaokoro on 9/27/25.
//

import SwiftUI

struct SearchRecentsView: View {
    let recentSearches: [RecentSearch]
    
    var body: some View {
        List {
            Section {
                ForEach(recentSearches) { search in
                    SearchRecentItemView(search: search)
                }
            } header: {
                HStack {
                    Text("Recents")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .textCase(nil)
                    
                    Spacer()
                    
                    Text("More")
                        .foregroundColor(.blue)
                        .font(.subheadline)
                        .textCase(nil)
                }
                .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
            }
        }
        .listStyle(.insetGrouped)
        .scrollDisabled(true)
        .scrollContentBackground(.hidden)
        .background(.ultraThickMaterial)
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
        .listRowInsets(EdgeInsets(top: 12, leading: 16, bottom: 12, trailing: 16))
        .alignmentGuide(.listRowSeparatorLeading) { _ in 0 }
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
    RecentSearch(title: "545 Washington Blvd", subtitle: "Jersey City"),
    RecentSearch(title: "Crunch Fitness", subtitle: "Springfield"),
    RecentSearch(title: "1327-1339 Burnet Ave", subtitle: "Union")
]

#Preview {
    SearchRecentsView(recentSearches: sampleSearches)
}

