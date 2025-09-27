//
//  DatePickerSheet.swift
//  SynrgyApp
//
//  Created by Obinna Nwaokoro on 9/27/25.
//

import SwiftUI

struct DatePickerSheet: View {
    @Binding var selectedDate: String
    @State private var selectedMonth: String
    @State private var selectedYear: String
    @Environment(\.dismiss) private var dismiss
    let title: String
    
    private let shortMonths = Calendar.current.shortMonthSymbols
    private let fullMonths = Calendar.current.monthSymbols
    private let years = Array(1990...2030).map(String.init)
    
    init(selectedDate: Binding<String>, title: String) {
        self._selectedDate = selectedDate
        self.title = title
        
        let currentMonth = Calendar.current.shortMonthSymbols[Calendar.current.component(.month, from: Date()) - 1]
        let currentYear = String(Calendar.current.component(.year, from: Date()))
        
        self._selectedMonth = State(initialValue: currentMonth)
        self._selectedYear = State(initialValue: currentYear)
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 24) {
                HStack(spacing: 0) {
                    Picker("Month", selection: $selectedMonth) {
                        ForEach(0...11, id: \.self) { idx in
                            Text(fullMonths[idx]).tag(shortMonths[idx])
                        }
                    }
                    .pickerStyle(.wheel)
                    
                    Picker("Year", selection: $selectedYear) {
                        ForEach(years, id: \.self) { year in
                            Text(year).tag(year)
                        }
                    }
                    .pickerStyle(.wheel)
                }
                
                Button("Done") {
                    selectedDate = "\(selectedMonth)/\(selectedYear)"
                    dismiss()
                }
                .frame(maxWidth: .infinity, maxHeight: 50)
                .foregroundColor(.white)
                .background(Color.primary)
                .cornerRadius(12)
                .padding(.horizontal, 24)
            }
            .navigationTitle(title)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing: Button("Cancel") { dismiss() })
        }
    }
}

#Preview {
    DatePickerSheet(selectedDate: .constant(""), title: "Start Date")
}
