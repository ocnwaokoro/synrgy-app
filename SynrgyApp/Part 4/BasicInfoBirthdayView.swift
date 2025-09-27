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
    
    private var canContinue: Bool {
        !month.isEmpty && !day.isEmpty && !year.isEmpty
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
                        ForEach(0...11, id: \.self) { monthNum in
                            Button(DateFormatter().monthSymbols[monthNum]) {
                                month = String(format: "%02d", monthNum)
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
                            if newValue.count > 2 {
                                day = String(newValue.prefix(2))
                            }
                        }
                    
                    TextField("YYYY", text: $year)
                        .keyboardType(.numberPad)
                        .textFieldStyle(SynrgyTextFieldStyle())
                        .onChange(of: year) { _, newValue in
                            if newValue.count > 4 {
                                year = String(newValue.prefix(4))
                            }
                        }
                    
                    Spacer()
                }
                
                Spacer()
                
                // Navigation buttons
                HStack {
                    Button(action: {
                        withAnimation {
                            selectedTab = 0
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
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "MM/dd/yyyy"
                        if let date = dateFormatter.date(from: "\(month)/\(day)/\(year)") {
                            synrgyVM.userBirthday = date
                        }
                        withAnimation {
                            selectedTab = 2
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
    BasicInfoBirthdayView(synrgyVM: .init(), selectedTab: .constant(1))
}
