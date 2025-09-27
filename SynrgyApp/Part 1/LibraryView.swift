//
//  LibraryView.swift
//  SynrgyApp
//
//  Created by Obinna Nwaokoro on 9/26/25.
//

import SwiftUI

struct LibraryView: View {
    @State private var libraryItems = [
        LibraryItem.lawyer,
        LibraryItem.weightLoss,
        LibraryItem.europeTrip,
        LibraryItem.addNew
    ]
    
    var body: some View {
        Section {
            // Library Items - Simple Horizontal Row
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    ForEach(libraryItems) { item in
                        LibraryItemCardView(item: item)
                    }
                }
                .padding(.horizontal, 16)
            }
            .listRowInsets(EdgeInsets(top: 16, leading: 0, bottom: 0, trailing: 0))
            
            // Progress Stats
            HStack {
                Text(ProgressStats.sample.displayText)
                    .foregroundColor(.secondary)
                    .font(.subheadline)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .foregroundColor(.secondary)
                    .font(.caption)
                    .fontWeight(.medium)
            }
            .listRowInsets(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
            .alignmentGuide(.listRowSeparatorLeading) { _ in 0 }
        } header: {
            HStack {
                Text("Library")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .textCase(nil)
                Spacer()
            }
            .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
        }
    }
}

struct LibraryItemCardView: View {
    let item: LibraryItem
    
    var body: some View {
        VStack(spacing: 12) {
            // Icon
            Circle()
                .fill(Color(.systemGray6))
                .frame(width: 60, height: 60)
                .overlay(
                    Image(systemName: item.category.icon)
                        .foregroundColor(item.color)
                        .font(.title2)
                        .fontWeight(.medium)
                )
            
            // Title and Description
//            VStack(spacing: 4) {
//                Text(item.title)
//                    .font(.subheadline)
//                    .fontWeight(.semibold)
//                    .foregroundColor(.primary)
//                    .multilineTextAlignment(.center)
//                
//                if item.title != "Add" {
//                    Text(item.description)
//                        .font(.caption)
//                        .foregroundColor(.secondary)
//                        .multilineTextAlignment(.center)
//                }
//            }
            Text(item.title)
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundColor(.primary)
                .multilineTextAlignment(.center)
            Spacer()
        }
        .frame(width: 80)
        .onTapGesture {
            print("Tapped on item: \(item.title) in category: \(item.category.displayName)")
        }
    }
}

// MARK: - Preview Provider
#Preview {
    ZStack {
        Color.clear
            .ignoresSafeArea()
            .background(.ultraThickMaterial)

        List {
            LibraryView()
        }
        .listStyle(.insetGrouped)
        .scrollDisabled(true)
        .scrollContentBackground(.hidden)
        .background(.ultraThickMaterial)
    }
}
