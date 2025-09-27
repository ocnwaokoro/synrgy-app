//
//  ExperienceWorkView.swift
//  SynrgyApp
//
//  Created by Obinna Nwaokoro on 9/27/25.
//

import SwiftUI

struct WorkEntry {
    var role: String = ""
    var company: String = ""
    var startDate: String = ""
    var endDate: String = ""
    var isPresent: Bool = false
}

struct ExperienceWorkView: View {
    @ObservedObject var synrgyVM: SynrgyViewModel
    @State private var workEntries: [WorkEntry] = [WorkEntry()]
    @State private var showStartMonthPicker: Bool = false
    @State private var showEndMonthPicker: Bool = false
    @State private var selectedEntryIndex: Int = 0
    @Binding var selectedTab: Int
    
    private var canContinue: Bool {
        workEntries.allSatisfy {
            !$0.role.isEmpty && !$0.company.isEmpty && !$0.startDate.isEmpty
        }
    }
    
    var body: some View {
        VStack(spacing: 32) {
            progressIndicator
            mainContent
        }
        .sheet(isPresented: $showStartMonthPicker) {
            DatePickerSheet(
                selectedDate: $workEntries[selectedEntryIndex].startDate,
                title: "Start Date"
            )
        }
        .sheet(isPresented: $showEndMonthPicker) {
            DatePickerSheet(
                selectedDate: $workEntries[selectedEntryIndex].endDate,
                title: "End Date"
            )
        }
        .navigationBarHidden(true)
    }
    
    private var progressIndicator: some View {
        HStack {
            ForEach(0..<5) { index in
                Circle()
                    .fill(index == 4 ? Color.primary : Color.gray.opacity(0.3))
                    .frame(width: 8, height: 8)
            }
            Spacer()
        }
        .padding(.horizontal, 24)
    }
    
    private var mainContent: some View {
        VStack(alignment: .leading, spacing: 16) {
            Spacer()
            
            Text("Any Work?")
                .font(.title2)
                .fontWeight(.bold)
            
            entriesList
            
            Spacer()
            
            navigationButtons
        }
        .padding(.horizontal, 24)
    }
    
    private var entriesList: some View {
        ScrollView {
            LazyVStack(spacing: 12) {
                ForEach(workEntries.indices, id: \.self) { index in
                    WorkEntryCard(
                        entry: $workEntries[index],
                        index: index,
                        isFirstEntry: workEntries.count == 1 && index == 0,
                        onAdd: addEntry,
                        onRemove: { removeEntry(at: index) },
                        onStartDateTap: {
                            selectedEntryIndex = index
                            showStartMonthPicker = true
                        },
                        onEndDateTap: {
                            selectedEntryIndex = index
                            showEndMonthPicker = true
                        }
                    )
                }
            }
        }
    }
    
    private var navigationButtons: some View {
        HStack(spacing: 12) {
            Button("Back") {
                withAnimation { selectedTab = 3 }
            }
            .frame(maxWidth: .infinity, maxHeight: 50)
            .foregroundColor(.primary)
            .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.primary, lineWidth: 2))
            
            Button("Continue") {
                withAnimation { selectedTab = 5 }
            }
            .frame(maxWidth: .infinity, maxHeight: 50)
            .foregroundColor(.white)
            .background(canContinue ? Color.primary : Color.gray.opacity(0.4))
            .cornerRadius(12)
            .disabled(!canContinue)
        }
    }
    
    // MARK: - Helper Functions
    private func addEntry() {
        withAnimation(.spring(response: 0.5, dampingFraction: 0.8)) {
            workEntries.append(WorkEntry())
        }
    }
    
    private func removeEntry(at index: Int) {
//        guard index < workEntries.count else { return }
        
        workEntries.remove(at: index)
    }
}

struct WorkEntryCard: View {
    @Binding var entry: WorkEntry
    let index: Int
    let isFirstEntry: Bool
    let onAdd: () -> Void
    let onRemove: () -> Void
    let onStartDateTap: () -> Void
    let onEndDateTap: () -> Void
    
    var body: some View {
        HStack(spacing: 8) {
            formContent
            actionButtons
        }
    }
    
    private var formContent: some View {
        VStack(spacing: 8) {
            roleAndCompanySection
            dateRangeSection
            presentCheckbox
        }
        .padding(8)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
        .transition(.asymmetric(
            insertion: .scale(scale: 0.8).combined(with: .opacity),
            removal: .scale(scale: 0.8).combined(with: .opacity)
        ))
    }
    
    private var roleAndCompanySection: some View {
        HStack(spacing: 8) {
            VStack(alignment: .leading, spacing: 2) {
                TextField("Role", text: $entry.role)
                    .textFieldStyle(SynrgyTextFieldStyle())
            }
            
            VStack(alignment: .leading, spacing: 2) {
                TextField("Company", text: $entry.company)
                    .textFieldStyle(SynrgyTextFieldStyle())
            }
        }
    }
    
    private var dateRangeSection: some View {
        HStack(spacing: 8) {
            VStack(alignment: .leading, spacing: 2) {
                TextField("Start Date *", text: $entry.startDate)
                    .textFieldStyle(SynrgyTextFieldStyle())
                    .disabled(true)
                    .onTapGesture {
                        onStartDateTap()
                    }
            }
            
            VStack(alignment: .leading, spacing: 2) {
                TextField(entry.isPresent ? "Present" : "End Date", text: $entry.endDate)
                    .textFieldStyle(SynrgyTextFieldStyle())
                    .disabled(true)
                    .onTapGesture {
                        if !entry.isPresent {
                            onEndDateTap()
                        }
                    }
                    .disabled(entry.isPresent)
            }
        }
    }
    
    private var presentCheckbox: some View {
        HStack {
            Button(action: {
                entry.isPresent.toggle()
                if entry.isPresent {
                    entry.endDate = ""
                }
            }) {
                HStack(spacing: 4) {
                    Image(systemName: entry.isPresent ? "checkmark.square.fill" : "square")
                        .foregroundColor(.primary)
                    Text("Present?")
                        .font(.caption2)
                        .foregroundColor(.primary)
                }
            }
        }
    }
    
    private var actionButtons: some View {
        VStack(spacing: 8) {
            if isFirstEntry {
                plusButton(size: 28)
            } else {
                plusButton(size: 28)
                minusButton
            }
        }
    }
    
    private func plusButton(size: CGFloat) -> some View {
        Button(action: onAdd) {
            Image(systemName: "plus")
                .foregroundColor(.white)
                .frame(width: size, height: size)
                .background(Color.black)
                .clipShape(Circle())
        }
    }
    
    private var minusButton: some View {
        Button(action: onRemove) {
            Image(systemName: "minus")
                .foregroundColor(.white)
                .frame(width: 28, height: 28)
                .background(Color.red)
                .clipShape(Circle())
        }
    }
}

#Preview {
    ExperienceWorkView(synrgyVM: .init(), selectedTab: .constant(4))
}
