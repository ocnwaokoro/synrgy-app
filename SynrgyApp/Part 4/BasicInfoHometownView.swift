//
//  BasicInfoHometownView.swift
//  SynrgyApp
//
//  Created by Obinna Nwaokoro on 9/27/25.
//

import SwiftUI

struct BasicInfoHometownView: View {
    @ObservedObject var synrgyVM: SynrgyViewModel
    @State private var hometown: String = ""
    @State private var showingSuggestions = false
    @State private var filteredCities: [String] = []
    @Binding var selectedTab: Int
    
    private let cities = [
        "New York, NY", "Los Angeles, CA", "Chicago, IL", "Houston, TX", "Phoenix, AZ",
        "Philadelphia, PA", "San Antonio, TX", "San Diego, CA", "Dallas, TX", "San Jose, CA",
        "Austin, TX", "Jacksonville, FL", "Fort Worth, TX", "Columbus, OH", "Charlotte, NC",
        "San Francisco, CA", "Indianapolis, IN", "Seattle, WA", "Denver, CO", "Boston, MA",
        "Nashville, TN", "Newark, NJ", "Miami, FL", "Atlanta, GA", "Detroit, MI"
        // Add more cities as needed
    ]
    
    private var canContinue: Bool {
        !hometown.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    var body: some View {
        VStack(spacing: 32) {
            // Progress indicator - 3 dots
            HStack {
                ForEach(0..<3) { index in
                    Circle()
                        .fill(index == 2 ? Color.primary : Color.gray.opacity(0.3))
                        .frame(width: 8, height: 8)
                }
                Spacer()
            }
            .padding(.horizontal, 24)
            
            VStack(alignment: .leading, spacing: 32) {
                Spacer()
                
                // Question
                Text("What is your hometown?")
                    .font(.title2)
                    .fontWeight(.medium)
                
                // Input with suggestions
                VStack(alignment: .leading, spacing: 0) {
                    TextField("City, State", text: $hometown)
                        .textFieldStyle(SynrgyTextFieldStyle())
                        .onChange(of: hometown) { _, newValue in
                            if newValue.isEmpty {
                                showingSuggestions = false
                            } else {
                                filteredCities = cities.filter { $0.lowercased().contains(newValue.lowercased()) }
                                showingSuggestions = !filteredCities.isEmpty
                            }
                        }
                    
                    if showingSuggestions {
                        VStack(alignment: .leading, spacing: 0) {
                            ForEach(Array(filteredCities.prefix(5)), id: \.self) { city in
                                Button(action: {
                                    hometown = city
                                    showingSuggestions = false
                                }) {
                                    Text(city)
                                        .foregroundColor(.primary)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .padding(.horizontal, 16)
                                        .padding(.vertical, 12)
                                }
                            }
                        }
                        .background(Color.white)
                        .cornerRadius(12)
                        .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
                    }
                }
                
                Spacer()
                
                // Navigation buttons
                HStack {
                    Button(action: {
                        withAnimation {
                            selectedTab = 1
                        }
                    }) {
                        Text("Back")
                            .font(.headline)
                            .foregroundColor(.primary)
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(Color.clear)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color.primary, lineWidth: 1)
                            )
                    }
                    
                    Button(action: {
                        synrgyVM.userHometown = hometown
                        withAnimation {
                            selectedTab = 3
                        }
                    }) {
                        Text("Continue")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(canContinue ? Color.primary : Color.gray.opacity(0.4))
                            .cornerRadius(12)
                    }
                    .disabled(!canContinue)
                }
            }
            .padding(.horizontal, 24)
        }
        .navigationBarHidden(true)
    }
}

#Preview {
    BasicInfoHometownView(synrgyVM: .init(), selectedTab: .constant(1))
}
