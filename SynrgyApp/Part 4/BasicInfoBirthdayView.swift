//
//  BasicInfoBirthdayView.swift
//  SynrgyApp
//
//  Created by Obinna Nwaokoro on 9/27/25.
//

import SwiftUI

struct BasicInfoBirthdayView: View {
    @ObservedObject var synrgyVM: SynrgyViewModel
    @State private var month: String = ""
    @State private var day: String = ""
    @State private var year: String = ""
    @Binding var selectedTab: Int
    
    // Create date formatter once to avoid recreation
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        return formatter
    }()
    
    private var canContinue: Bool {
        guard !month.isEmpty && !day.isEmpty && !year.isEmpty else {
            print("BasicInfoBirthdayView: Cannot continue - missing fields")
            return false
        }
        
        // Validate the date is actually valid
        let dateString = "\(month)/\(day)/\(year)"
        if let _ = dateFormatter.date(from: dateString) {
            print("BasicInfoBirthdayView: Valid date entered: \(dateString)")
            return true
        } else {
            print("BasicInfoBirthdayView: Invalid date: \(dateString)")
            return false
        }
    }
    
    var body: some View {
        VStack(spacing: 32) {
            // Progress indicator - 3 dots
            HStack {
                ForEach(0..<3) { index in
                    Circle()
                        .fill(index == 1 ? Color.primary : Color.gray.opacity(0.3))
                        .frame(width: 8, height: 8)
                }
                Spacer()
            }
            .padding(.horizontal, 24)
            
            VStack(alignment: .leading, spacing: 32) {
                
                Spacer()
                
                // Question
                Text("When is your birthday?")
                    .font(.title2)
                    .fontWeight(.medium)
                
                // Date inputs
                HStack(spacing: 12) {
                    Menu {
                        ForEach(1...12, id: \.self) { monthNum in
                            Button(DateFormatter().monthSymbols[monthNum - 1]) {
                                month = String(format: "%02d", monthNum)
                                print("BasicInfoBirthdayView: Selected month: \(month)")
                            }
                        }
                    } label: {
                        HStack {
                            Text(month.isEmpty ? "Month" : DateFormatter().monthSymbols[Int(month) ?? 1 - 1])
                                .foregroundColor(month.isEmpty ? .gray : .primary)
                            Spacer()
                            Image(systemName: "chevron.down")
                                .font(.caption)
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 14)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(12)
                    }
                    .frame(width: 140)
                    
                    TextField("DD", text: $day)
                        .keyboardType(.numberPad)
                        .textFieldStyle(SynrgyTextFieldStyle())
                        .frame(maxWidth: 80)
                        .onChange(of: day) { _, newValue in
                            // Only allow digits and limit to 2 characters
                            let filtered = newValue.filter { $0.isNumber }
                            if filtered.count > 2 {
                                day = String(filtered.prefix(2))
                            } else {
                                day = filtered
                            }
                            print("BasicInfoBirthdayView: Day changed to: \(day)")
                        }
                    
                    TextField("YYYY", text: $year)
                        .keyboardType(.numberPad)
                        .textFieldStyle(SynrgyTextFieldStyle())
                        .onChange(of: year) { _, newValue in
                            // Only allow digits and limit to 4 characters
                            let filtered = newValue.filter { $0.isNumber }
                            if filtered.count > 4 {
                                year = String(filtered.prefix(4))
                            } else {
                                year = filtered
                            }
                            print("BasicInfoBirthdayView: Year changed to: \(year)")
                        }
                    
                    Spacer()
                }
                
                Spacer()
                
                // Navigation buttons
                HStack {
                    Button(action: {
                        print("BasicInfoBirthdayView: Back button tapped")
                        withAnimation {
                            selectedTab = 0
                        }
                    }) {
                        Text("Back")
                            .font(.headline)
                            .foregroundColor(.primary)
                            .frame(height: 50)
                            .frame(maxWidth: .infinity)
                            .background(Color.clear)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color.primary, lineWidth: 1)
                            )
                    }
                    
                    Button(action: {
                        print("BasicInfoBirthdayView: Continue button tapped")
                        let dateString = "\(month)/\(day)/\(year)"
                        print("BasicInfoBirthdayView: Attempting to create date from: \(dateString)")
                        
                        if let date = dateFormatter.date(from: dateString) {
                            synrgyVM.userBirthday = date
                            print("BasicInfoBirthdayView: Successfully set user birthday to: \(date)")
                            synrgyVM.printSelections() // Debug log current state
                        } else {
                            print("BasicInfoBirthdayView: ERROR - Failed to create valid date from: \(dateString)")
                        }
                        
                        withAnimation {
                            selectedTab = 2
                        }
                    }) {
                        Text("Continue")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(height: 50)
                            .frame(maxWidth: .infinity)
                            .background(canContinue ? Color.primary : Color.gray.opacity(0.4))
                            .cornerRadius(12)
                    }
                    .disabled(!canContinue)
                }
            }
            .padding(.horizontal, 24)
        }
        .navigationBarHidden(true)
        .onAppear {
            print("BasicInfoBirthdayView: View appeared")
        }
    }
}

#Preview {
    BasicInfoBirthdayView(synrgyVM: .init(), selectedTab: .constant(1))
}
