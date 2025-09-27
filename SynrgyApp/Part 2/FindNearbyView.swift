//
//  FindNearbyView.swift
//  SynrgyApp
//
//  Created by Obinna Nwaokoro on 9/27/25.
//

import SwiftUI

struct FindNearbyView: View {
    let categories: [NearbyCategory]
    
    var body: some View {
        VStack(spacing: 0) {
            // Header with secondary color, left aligned
            HStack {
                Text("Find Nearby")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(.secondary)
                
                Spacer()
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            
            // Divider under the title
            Divider()
                .padding(.leading, 16)
            
            // Horizontally scrollable grid (not 2 columns, but 2 rows)
            ScrollView(.horizontal, showsIndicators: false) {
                VStack(spacing: 0) {
                    HStack(spacing: 0) {
                        ForEach(Array(categories.prefix(3))) { category in
                            NearbyCategoryButton(category: category)
                        }
                    }
                    HStack(spacing: 0) {
                        ForEach(Array(categories.dropFirst(3))) { category in
                            NearbyCategoryButton(category: category)
                        }
                    }
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
            }
        }
    }
}

struct NearbyCategoryButton: View {
    let category: NearbyCategory
    
    var body: some View {
        VStack(spacing: 8) {
            Circle()
                .fill(category.color)
                .frame(width: 40, height: 40)
                .overlay(
                    Image(systemName: category.icon)
                        .foregroundColor(.white)
                        .font(.system(size: 18))
                )
            
            Text(category.title)
                .font(.caption)
                .fontWeight(.medium)
                .multilineTextAlignment(.center)
                .lineLimit(2)
        }
        .frame(width: 80) // Fixed width for consistent layout
    }
}

struct NearbyCategory: Identifiable {
    let id = UUID()
    let title: String
    let icon: String
    let color: Color
}

let nearbyCategories = [
    NearbyCategory(title: "Gas Stations", icon: "fuelpump.fill", color: .blue),
    NearbyCategory(title: "Restaurants", icon: "fork.knife", color: .orange),
    NearbyCategory(title: "Fast Food", icon: "takeoutbag.and.cup.and.straw.fill", color: .orange),
    NearbyCategory(title: "Coffee Shops", icon: "cup.and.saucer.fill", color: .orange),
    NearbyCategory(title: "Hotels", icon: "bed.double.fill", color: .purple),
    NearbyCategory(title: "Shopping", icon: "bag.fill", color: .yellow)
]

#Preview {
    FindNearbyView(categories: nearbyCategories)
}
