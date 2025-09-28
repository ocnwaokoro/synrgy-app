////
////  interesting-library.swift
////  SynrgyApp
////
////  Created by Obinna Nwaokoro on 9/27/25.
////
//
////
////  LibraryView.swift
////  SynrgyApp
////
////  Created by Obinna Nwaokoro on 9/26/25.
////
//
//import SwiftUI
//
//struct LibraryView: View {
//    @State private var selectedCategory: ContentCategory = .career
//    @State private var libraryItems: [LibraryItem] = []
//    
//    var body: some View {
//        Section {
//            // Category Selector
//            ScrollView(.horizontal, showsIndicators: false) {
//                HStack(spacing: 12) {
//                    ForEach(ContentCategory.allCases) { category in
//                        CategoryButton(
//                            category: category,
//                            isSelected: selectedCategory == category
//                        ) {
//                            selectedCategory = category
//                            updateItemsForCategory()
//                        }
//                    }
//                }
//                .padding(.horizontal, 16)
//            }
//            .listRowInsets(EdgeInsets(top: 16, leading: 0, bottom: 8, trailing: 0))
//            
//            // Items for selected category
//            ScrollView(.horizontal, showsIndicators: false) {
//                HStack(spacing: 20) {
//                    ForEach(libraryItems) { item in
//                        LibraryItemCardView(item: item)
//                    }
//                }
//                .padding(.horizontal, 16)
//            }
//            .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
//            
//            // Progress Stats
//            HStack {
//                Text(ProgressStats.sample.displayText)
//                    .foregroundColor(.secondary)
//                    .font(.subheadline)
//                
//                Spacer()
//                
//                Image(systemName: "chevron.right")
//                    .foregroundColor(.secondary)
//                    .font(.caption)
//                    .fontWeight(.medium)
//            }
//            .listRowInsets(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
//            .alignmentGuide(.listRowSeparatorLeading) { _ in 0 }
//        } header: {
//            HStack {
//                Text("Library")
//                    .font(.subheadline)
//                    .fontWeight(.semibold)
//                    .textCase(nil)
//                Spacer()
//            }
//            .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
//        }
//        .onAppear {
//            updateItemsForCategory()
//        }
//    }
//    
//    private func updateItemsForCategory() {
//        switch selectedCategory {
//        case .career:
//            libraryItems = [LibraryItem.lawyer, LibraryItem.addNew]
//        case .gym:
//            libraryItems = [LibraryItem.weightLoss, LibraryItem.addNew]
//        case .trip:
//            libraryItems = [LibraryItem.europeTrip, LibraryItem.addNew]
//        case .goal:
//            libraryItems = [LibraryItem.learnSpanish, LibraryItem.addNew]
//        case .cooking:
//            libraryItems = [LibraryItem.addNew]
//        }
//    }
//}
//
//struct CategoryButton: View {
//    let category: ContentCategory
//    let isSelected: Bool
//    let action: () -> Void
//    
//    var body: some View {
//        Button(action: action) {
//            HStack(spacing: 6) {
//                Image(systemName: category.icon)
//                    .font(.caption)
//                Text(category.displayName)
//                    .font(.caption)
//                    .fontWeight(.medium)
//            }
//            .padding(.horizontal, 12)
//            .padding(.vertical, 6)
//            .background(
//                RoundedRectangle(cornerRadius: 16)
//                    .fill(isSelected ? category.color : Color(.systemGray6))
//            )
//            .foregroundColor(isSelected ? .white : .primary)
//        }
//    }
//}
//
//struct LibraryItemCardView: View {
//    let item: LibraryItem
//    
//    var body: some View {
//        VStack(spacing: 12) {
//            // Icon
//            Circle()
//                .fill(Color(.systemGray6))
//                .frame(width: 60, height: 60)
//                .overlay(
//                    Image(systemName: item.icon)
//                        .foregroundColor(item.color)
//                        .font(.title2)
//                        .fontWeight(.medium)
//                )
//            
//            // Title and Description
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
//            Spacer()
//        }
//        .frame(width: 80)
//        .onTapGesture {
//            print("Tapped on item: \(item.title) in category: \(item.category.displayName)")
//        }
//    }
//}
//
//// MARK: - Preview Provider
//#Preview {
//    ZStack {
//        Color.clear
//            .ignoresSafeArea()
//            .background(.ultraThickMaterial)
//
//        List {
//            LibraryView()
//        }
//        .listStyle(.insetGrouped)
//        .scrollDisabled(true)
//        .scrollContentBackground(.hidden)
//        .background(.ultraThickMaterial)
//    }
//}
