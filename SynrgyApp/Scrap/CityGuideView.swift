//
//  CityGuideView.swift
//  SynrgyApp
//
//  Created by Obinna Nwaokoro on 9/27/25.
//

import SwiftUI

struct CityGuidesView: View {
    let guides: [CityGuide]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("City Guides")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                Spacer()
                Text("More")
                    .foregroundColor(.blue)
                    .font(.subheadline)
            }
            .padding(.horizontal, 16)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(guides) { guide in
                        CityGuideCard(guide: guide)
                    }
                }
                .padding(.horizontal, 16)
            }
        }
    }
}

struct CityGuideCard: View {
    let guide: CityGuide
    
    var body: some View {
        RoundedRectangle(cornerRadius: 12)
            .fill(guide.backgroundColor)
            .frame(width: 180, height: 120)
            .overlay(
                VStack {
                    Spacer()
                    HStack {
                        VStack(alignment: .leading, spacing: 2) {
                            Text(guide.city)
                                .font(.headline)
                                .foregroundColor(.white)
                                .fontWeight(.bold)
                            Text(guide.country)
                                .font(.subheadline)
                                .foregroundColor(.white.opacity(0.8))
                        }
                        Spacer()
                    }
                    .padding()
                }
            )
    }
}

struct CityGuide: Identifiable {
    let id = UUID()
    let city: String
    let country: String
    let backgroundColor: Color
}

let cityGuides = [
    CityGuide(city: "New York", country: "United States", backgroundColor: .brown),
    CityGuide(city: "Philadelphia", country: "United States", backgroundColor: .green),
    CityGuide(city: "Washington", country: "United States", backgroundColor: .blue)
]

#Preview {
    CityGuidesView(guides: cityGuides)
}
