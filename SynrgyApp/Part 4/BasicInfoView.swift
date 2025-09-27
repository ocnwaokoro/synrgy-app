//
//  BasicInfoView.swift
//  SynrgyApp
//
//  Created by Obinna Nwaokoro on 9/27/25.
//

import SwiftUI

struct BasicInfoView: View {
    @ObservedObject var synrgyVM: SynrgyViewModel
    @State private var name: String = ""
    @State private var selectedMonth: Int = 1
    @State private var selectedDay: Int = 1
    @State private var selectedYear: Int = 2000
    @State private var hometown: String = ""
    @Binding var selectedTab: Int
    
    private var canContinue: Bool {
        !name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
        !hometown.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    var body: some View {
        VStack(spacing: 32) {
            // Progress indicator
            HStack {
                ForEach(0..<3) { index in
                    Circle()
                        .fill(index == 0 ? Color.primary : Color.gray.opacity(0.3))
                        .frame(width: 8, height: 8)
                }
                Spacer()
            }
            .padding(.horizontal, 24)
            
            VStack(alignment: .leading, spacing: 32) {
                // Name section
                VStack(alignment: .leading, spacing: 12) {
                    Text("What should we call you?")
                        .font(.title2)
                        .fontWeight(.medium)
                    
                    TextField("Your name", text: $name)
                        .textFieldStyle(SynrgyTextFieldStyle())
                }
                
                // Birthday section
                VStack(alignment: .leading, spacing: 12) {
                    Text("When is your birthday?")
                        .font(.title2)
                        .fontWeight(.medium)
                    
                    HStack(spacing: 16) {
                        // Month Dropdown
                        Picker("Month", selection: $selectedMonth) {
                            ForEach(1...12, id: \.self) { month in
                                Text(String(format: "%02d", month)).tag(month)
                            }
                        }
                        .pickerStyle(.menu)
                        .frame(maxWidth: 100)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 12)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(8)
                        
                        // Day Dropdown
                        Picker("Day", selection: $selectedDay) {
                            ForEach(1...31, id: \.self) { day in
                                Text(String(format: "%02d", day)).tag(day)
                            }
                        }
                        .pickerStyle(.menu)
                        .frame(maxWidth: 100)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 12)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(8)
                        
                        // Year Dropdown
                        Picker("Year", selection: $selectedYear) {
                            ForEach(1990...2010, id: \.self) { year in
                                Text("\(year)").tag(year)
                            }
                        }
                        .pickerStyle(.menu)
                        .frame(maxWidth: 120)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 12)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(8)
                        
                        Spacer()
                    }
                }
                
                // Hometown section
                VStack(alignment: .leading, spacing: 12) {
                    Text("What is your hometown?")
                        .font(.title2)
                        .fontWeight(.medium)
                    
                    TextField("City, State", text: $hometown)
                        .textFieldStyle(SynrgyTextFieldStyle())
                }
                
                Spacer()
                
                // Continue button
                Button(action: {
                    // Save to view model
                    synrgyVM.userName = name
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "MM/dd/yyyy"
                    let dateString = String(format: "%02d/%02d/%d", selectedMonth, selectedDay, selectedYear)
                    if let date = dateFormatter.date(from: dateString) {
                        synrgyVM.userBirthday = date
                    }
                    synrgyVM.userHometown = hometown
                    
                    // Move to onboarding flow
                    withAnimation {
                        selectedTab = 1
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
            .padding(.horizontal, 24)
        }
        .navigationBarHidden(true)
    }
}


struct BasicInfoView_Previews: PreviewProvider {
    static var previews: some View {
        BasicInfoView(synrgyVM: SynrgyViewModel(), selectedTab: .constant(0))
    }
}
