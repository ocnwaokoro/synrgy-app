//
//  ExperienceSchoolingView.swift
//  SynrgyApp
//
//  Created by Obinna Nwaokoro on 9/27/25.
//

import SwiftUI

struct SchoolingEntry {
    var award: String = ""
    var school: String = ""
    var subject: String = ""
    var startDate: String = ""
    var endDate: String = ""
    var isPresent: Bool = false
}

struct ExperienceSchoolingView: View {
    @ObservedObject var synrgyVM: SynrgyViewModel
    @State private var schoolingEntries: [SchoolingEntry] = [SchoolingEntry()]
    @State private var showStartMonthPicker: Bool = false
    @State private var showEndMonthPicker: Bool = false
    @State private var selectedEntryIndex: Int = 0
    @Binding var selectedTab: Int

    private var canContinue: Bool {
        schoolingEntries.allSatisfy {
            !$0.award.isEmpty && !$0.school.isEmpty && !$0.startDate.isEmpty
        }
    }

    var body: some View {
        VStack(spacing: 32) {
            // Progress indicator
            HStack {
                ForEach(0..<5) { index in
                    Circle()
                        .fill(
                            index == 3 ? Color.primary : Color.gray.opacity(0.3)
                        )
                        .frame(width: 8, height: 8)
                }
                Spacer()
            }
            .padding(.horizontal, 24)

            VStack(alignment: .leading, spacing: 16) {
                Spacer()

                // Question header
                Text("Any Schooling?")
                    .font(.title2)
                    .fontWeight(.bold)

                // Form containers
                ScrollView(.vertical) {
                    LazyVStack(spacing: 12) {
                        ForEach(schoolingEntries.indices, id: \.self) { index in
                            HStack(spacing: 8) {
                                // Form content for each entry
                                VStack(spacing: 8) {
                                    // Award and School
                                    HStack(spacing: 8) {
                                        VStack(alignment: .leading, spacing: 2)
                                        {
                                            //                                        Text("Award *")
                                            //                                            .font(.caption2)
                                            //                                            .fontWeight(.medium)

                                            Menu {
                                                Button("High School") {
                                                    schoolingEntries[index]
                                                        .award = "High School"
                                                }
                                                Button("Associate") {
                                                    schoolingEntries[index]
                                                        .award = "Associate"
                                                }
                                                Button("Bachelor's") {
                                                    schoolingEntries[index]
                                                        .award = "Bachelor's"
                                                }
                                                Button("Master's") {
                                                    schoolingEntries[index]
                                                        .award = "Master's"
                                                }
                                                Button("PhD") {
                                                    schoolingEntries[index]
                                                        .award = "PhD"
                                                }
                                                Button("Certificate") {
                                                    schoolingEntries[index]
                                                        .award = "Certificate"
                                                }
                                            } label: {
                                                
                                                
                                                HStack {
                                                    Text(
                                                        schoolingEntries[index]
                                                            .award.isEmpty
                                                            ? "Degree"
                                                            : schoolingEntries[
                                                                index
                                                            ].award
                                                    )
                                                    .foregroundColor(
                                                        schoolingEntries[index]
                                                            .award.isEmpty
                                                            ? .gray : .primary)
                                                    Spacer()
                                                    Image(
                                                        systemName:
                                                            "chevron.down"
                                                    )
                                                    .font(.caption2)
                                                    .foregroundStyle(.gray)
                                                }
                                                .padding(.horizontal, 16)
                                                .padding(.vertical, 14)
                                                .background(
                                                    Color.gray.opacity(0.1)
                                                )
                                                .cornerRadius(12)
                                            }
                                        }

                                        VStack(alignment: .leading, spacing: 2)
                                        {
                                            //                                        Text("School *")
                                            //                                            .font(.caption2)
                                            //                                            .fontWeight(.medium)

                                            TextField(
                                                "e.g., NYU",
                                                text: $schoolingEntries[index]
                                                    .school
                                            )
                                            .textFieldStyle(
                                                SynrgyTextFieldStyle())
                                        }
                                    }

                                    // Subject (conditional)
                                    if !schoolingEntries[index].award.isEmpty
                                        && schoolingEntries[index].award
                                            != "High School"
                                    {
                                        VStack(alignment: .leading, spacing: 2)
                                        {
                                            //                                        Text("Subject(s)")
                                            //                                            .font(.caption2)
                                            //                                            .fontWeight(.medium)

                                            TextField(
                                                "Subject",
                                                text: $schoolingEntries[index]
                                                    .subject
                                            )
                                            .textFieldStyle(
                                                SynrgyTextFieldStyle())
                                        }
                                    }

                                    // Date range
                                    HStack(spacing: 8) {
                                        VStack(alignment: .leading, spacing: 2)
                                        {
                                            //                                        Text("Start Date *")
                                            //                                            .font(.caption2)
                                            //                                            .fontWeight(.medium)

                                            TextField(
                                                "Start Date *",
                                                text: $schoolingEntries[index]
                                                    .startDate
                                            )
                                            .textFieldStyle(
                                                SynrgyTextFieldStyle()
                                            )
                                            .disabled(true)
                                            .onTapGesture {
                                                selectedEntryIndex = index
                                                showStartMonthPicker = true
                                            }
                                        }

                                        VStack(alignment: .leading, spacing: 2)
                                        {
                                            //                                        HStack {
                                            //                                            Text("End Date")
                                            //                                                .font(.caption2)
                                            //                                                .fontWeight(.medium)
                                            //
                                            //                                            Spacer()
                                            //                                            HStack {
                                            //                                                Button(action: {
                                            //                                                    schoolingEntries[index].isPresent.toggle()
                                            //                                                    if schoolingEntries[index].isPresent {
                                            //                                                        schoolingEntries[index].endDate = ""
                                            //                                                    }
                                            //                                                }) {
                                            //                                                    // Present checkbox
                                            //                                                    HStack(spacing: 0) {
                                            //                                                        Image(systemName: schoolingEntries[index].isPresent ? "checkmark.square.fill" : "square")
                                            //                                                            .foregroundColor(.primary)
                                            //                                                        Text("Present?")
                                            //                                                            .font(.caption2)
                                            //                                                            .foregroundColor(.primary)
                                            //                                                    }
                                            //                                                }
                                            //                                            }
                                            //                                        }

                                            TextField(
                                                schoolingEntries[index]
                                                    .isPresent
                                                    ? "Present" : "End Date",
                                                text: $schoolingEntries[index]
                                                    .endDate
                                            )
                                            .textFieldStyle(
                                                SynrgyTextFieldStyle()
                                            )
                                            .disabled(true)
                                            .onTapGesture {
                                                if !schoolingEntries[index]
                                                    .isPresent
                                                {
                                                    selectedEntryIndex = index
                                                    showEndMonthPicker = true
                                                }
                                            }
                                            .disabled(
                                                schoolingEntries[index]
                                                    .isPresent)
                                        }
                                    }

                                    HStack {
                                        Button(action: {
                                            schoolingEntries[index].isPresent
                                                .toggle()
                                            if schoolingEntries[index].isPresent
                                            {
                                                schoolingEntries[index]
                                                    .endDate = ""
                                            }
                                        }) {
                                            HStack(spacing: 4) {
                                                Image(
                                                    systemName:
                                                        schoolingEntries[index]
                                                        .isPresent
                                                        ? "checkmark.square.fill"
                                                        : "square"
                                                )
                                                .foregroundColor(.primary)
                                                Text("Present?")
                                                    .font(.caption2)
                                                    .foregroundColor(.primary)
                                            }
                                        }
                                    }
                                }
                                .padding(8)
                                .background(Color.white)
                                .cornerRadius(12)
                                .shadow(
                                    color: .black.opacity(0.1), radius: 4, x: 0,
                                    y: 2)

                                // Plus/Minus buttons
                                VStack(spacing: 8) {
                                    if schoolingEntries.count == 1 && index == 0
                                    {
                                        // Plus button for first entry
                                        Button(action: {
                                            schoolingEntries.append(
                                                SchoolingEntry())
                                        }) {
                                            Image(systemName: "plus")
                                                .foregroundColor(.white)
                                                .frame(width: 28, height: 28)
                                                .background(Color.black)
                                                .clipShape(Circle())
                                        }
                                    } else {
                                        // Plus button for all entries when multiple exist
                                        Button(action: {
                                            schoolingEntries.append(
                                                SchoolingEntry())
                                        }) {
                                            Image(systemName: "plus")
                                                .foregroundColor(.white)
                                                .frame(width: 28, height: 28)
                                                .background(Color.black)
                                                .clipShape(Circle())
                                        }

                                        // Minus button for removable entries
                                        Button(action: {
                                            schoolingEntries.remove(at: index)
                                        }) {
                                            Image(systemName: "minus")
                                                .foregroundColor(.white)
                                                .frame(width: 28, height: 28)
                                                .background(Color.red)
                                                .clipShape(Circle())
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                Spacer()

                // Navigation buttons
                HStack(spacing: 12) {
                    Button("Back") {
                        withAnimation { selectedTab = 2 }
                    }
                    .frame(maxWidth: .infinity, maxHeight: 50)
                    .foregroundColor(.primary)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12).stroke(
                            Color.primary, lineWidth: 2))

                    Button("Continue") {
                        withAnimation { selectedTab = 4 }
                    }
                    .frame(maxWidth: .infinity, maxHeight: 50)
                    .foregroundColor(.white)
                    .background(
                        canContinue ? Color.primary : Color.gray.opacity(0.4)
                    )
                    .cornerRadius(12)
                    .disabled(!canContinue)
                }
            }
            .padding(.horizontal, 24)
        }
        .sheet(isPresented: $showStartMonthPicker) {
            DatePickerSheet(
                selectedDate: $schoolingEntries[selectedEntryIndex].startDate,
                title: "Start Date")
        }
        .sheet(isPresented: $showEndMonthPicker) {
            DatePickerSheet(
                selectedDate: $schoolingEntries[selectedEntryIndex].endDate,
                title: "End Date")
        }
        .navigationBarHidden(true)
    }
}

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

        let currentMonth = Calendar.current.shortMonthSymbols[
            Calendar.current.component(.month, from: Date()) - 1]
        let currentYear = String(
            Calendar.current.component(.year, from: Date()))

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
    ExperienceSchoolingView(synrgyVM: .init(), selectedTab: .constant(1))
}
