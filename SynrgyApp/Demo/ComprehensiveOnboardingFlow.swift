//
//  ComprehensiveOnboardingFlow.swift
//  SynrgyApp
//
//  Created by AI Assistant on 9/28/25.
//

import SwiftUI

// MARK: - Data Models
//struct SchoolingEntry {
//    var award: String = ""
//    var school: String = ""
//    var subject: String = ""
//    var startDate: String = ""
//    var endDate: String = ""
//    var isPresent: Bool = false
//}
//
//struct WorkEntry {
//    var role: String = ""
//    var company: String = ""
//    var startDate: String = ""
//    var endDate: String = ""
//    var isPresent: Bool = false
//}
//
//struct HobbyEntry {
//    var hobby: String = ""
//}

// MARK: - Simple View Model
@MainActor
class OnboardingViewModel: ObservableObject {
    // Personal Information
    @Published var name: String = ""
    @Published var month: String = ""
    @Published var day: String = ""
    @Published var year: String = ""
    @Published var hometown: String = ""
    
    // Experience Information
    @Published var schoolingEntries: [SchoolingEntry] = [SchoolingEntry()]
    @Published var workEntries: [WorkEntry] = [WorkEntry()]
    @Published var hobbyEntries: [HobbyEntry] = [HobbyEntry()]
    
    // Date formatter
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        return formatter
    }()
    
    // Computed properties for validation
    var canContinueFromName: Bool {
        !name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    var canContinueFromBirthday: Bool {
        guard !month.isEmpty && !day.isEmpty && !year.isEmpty else { return false }
        let dateString = "\(month)/\(day)/\(year)"
        return dateFormatter.date(from: dateString) != nil
    }
    
    var canContinueFromHometown: Bool {
        !hometown.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    var hasSchoolingData: Bool {
        schoolingEntries.contains { !$0.award.isEmpty && !$0.school.isEmpty && !$0.startDate.isEmpty }
    }
    
    var hasWorkData: Bool {
        workEntries.contains { !$0.role.isEmpty && !$0.company.isEmpty && !$0.startDate.isEmpty }
    }
    
    var hasHobbiesData: Bool {
        hobbyEntries.contains { !$0.hobby.isEmpty }
    }
    
    // Print all collected data
    func printAllData() {
        print("=== ONBOARDING DATA COLLECTION ===")
        print("Name: '\(name)'")
        
        if let birthday = dateFormatter.date(from: "\(month)/\(day)/\(year)") {
            print("Birthday: \(birthday)")
        } else {
            print("Birthday: Invalid date - \(month)/\(day)/\(year)")
        }
        
        print("Hometown: '\(hometown)'")
        
        print("\nSchooling Entries (\(schoolingEntries.count)):")
        for (index, entry) in schoolingEntries.enumerated() {
            if !entry.award.isEmpty || !entry.school.isEmpty {
                print("  \(index + 1). Award: '\(entry.award)', School: '\(entry.school)', Subject: '\(entry.subject)'")
                print("     Start: '\(entry.startDate)', End: '\(entry.endDate)', Present: \(entry.isPresent)")
            }
        }
        
        print("\nWork Entries (\(workEntries.count)):")
        for (index, entry) in workEntries.enumerated() {
            if !entry.role.isEmpty || !entry.company.isEmpty {
                print("  \(index + 1). Role: '\(entry.role)', Company: '\(entry.company)'")
                print("     Start: '\(entry.startDate)', End: '\(entry.endDate)', Present: \(entry.isPresent)")
            }
        }
        
        print("\nHobbies (\(hobbyEntries.count)):")
        for (index, entry) in hobbyEntries.enumerated() {
            if !entry.hobby.isEmpty {
                print("  \(index + 1). '\(entry.hobby)'")
            }
        }
        
        print("=== END DATA COLLECTION ===")
    }
}

// MARK: - Main Comprehensive Onboarding Flow
struct ComprehensiveOnboardingFlow: View {
    @StateObject private var viewModel = OnboardingViewModel()
    @State private var currentStep = 0
    @State private var showStartMonthPicker = false
    @State private var showEndMonthPicker = false
    @State private var selectedEntryIndex = 0
    @State private var isSchoolingEntry = true
    
    // Callback functions
    let onBack: () -> Void
    let onComplete: () -> Void
    
    private let totalSteps = 6
    private let stepTitles = ["Name", "Birthday", "Hometown", "Schooling", "Work", "Hobbies"]
    
    var body: some View {
        VStack(spacing: 32) {
            // Navigation dots - 6 dots
            HStack {
                ForEach(0..<totalSteps, id: \.self) { index in
                    Circle()
                        .fill(index == currentStep ? Color.primary : Color.gray.opacity(0.3))
                        .frame(width: 8, height: 8)
                }
                Spacer()
            }
            .padding(.horizontal, 24)
            
            // Main content based on current step
            Group {
                switch currentStep {
                case 0:
                    nameView
                case 1:
                    birthdayView
                case 2:
                    hometownView
                case 3:
                    schoolingView
                case 4:
                    workView
                case 5:
                    hobbiesView
                default:
                    EmptyView()
                }
            }
        }
        .navigationBarHidden(true)
        .sheet(isPresented: $showStartMonthPicker) {
            if isSchoolingEntry {
                DatePickerSheet(
                    selectedDate: $viewModel.schoolingEntries[selectedEntryIndex].startDate,
                    title: "Start Date"
                )
            } else {
                DatePickerSheet(
                    selectedDate: $viewModel.workEntries[selectedEntryIndex].startDate,
                    title: "Start Date"
                )
            }
        }
        .sheet(isPresented: $showEndMonthPicker) {
            if isSchoolingEntry {
                DatePickerSheet(
                    selectedDate: $viewModel.schoolingEntries[selectedEntryIndex].endDate,
                    title: "End Date"
                )
            } else {
                DatePickerSheet(
                    selectedDate: $viewModel.workEntries[selectedEntryIndex].endDate,
                    title: "End Date"
                )
            }
        }
    }
    
    // MARK: - Name View
    private var nameView: some View {
        VStack(alignment: .leading, spacing: 32) {
            Spacer()
            
            Text("What should we call you?")
                .font(.title2)
                .fontWeight(.medium)
            
            TextField("Your name", text: $viewModel.name)
                .textFieldStyle(SynrgyTextFieldStyle())
            
            Spacer()
            
            HStack {
                // Back button on first page
                Button(action: {
                    print("ComprehensiveOnboarding: Back button tapped from name view")
                    onBack()
                }) {
                    Text("Back")
                        .font(.headline)
                        .foregroundColor(.primary)
                        .frame(height: 50)
                        .frame(maxWidth: .infinity)
                        .background(Color.clear)
                        .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.primary, lineWidth: 1))
                }
                
                Button(action: {
                    print("ComprehensiveOnboarding: Name entered: '\(viewModel.name)'")
                    withAnimation { currentStep = 1 }
                }) {
                    Text("Continue")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(height: 50)
                        .frame(maxWidth: .infinity)
                        .background(viewModel.canContinueFromName ? Color.primary : Color.gray.opacity(0.4))
                        .cornerRadius(12)
                }
                .disabled(!viewModel.canContinueFromName)
            }
        }
        .padding(.horizontal, 24)
    }
    
    // MARK: - Birthday View
    private var birthdayView: some View {
        VStack(alignment: .leading, spacing: 32) {
            Spacer()
            
            Text("When is your birthday?")
                .font(.title2)
                .fontWeight(.medium)
            
            HStack(spacing: 12) {
                Menu {
                    ForEach(1...12, id: \.self) { monthNum in
                        Button(DateFormatter().monthSymbols[monthNum - 1]) {
                            viewModel.month = String(format: "%02d", monthNum)
                            print("ComprehensiveOnboarding: Selected month: \(viewModel.month)")
                        }
                    }
                } label: {
                    HStack {
                        Text(viewModel.month.isEmpty ? "Month" : DateFormatter().monthSymbols[Int(viewModel.month) ?? 1 - 1])
                            .foregroundColor(viewModel.month.isEmpty ? .gray : .primary)
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
                
                TextField("DD", text: $viewModel.day)
                    .keyboardType(.numberPad)
                    .textFieldStyle(SynrgyTextFieldStyle())
                    .frame(maxWidth: 80)
                    .onChange(of: viewModel.day) { _, newValue in
                        let filtered = newValue.filter { $0.isNumber }
                        if filtered.count > 2 {
                            viewModel.day = String(filtered.prefix(2))
                        } else {
                            viewModel.day = filtered
                        }
                        print("ComprehensiveOnboarding: Day changed to: \(viewModel.day)")
                    }
                
                TextField("YYYY", text: $viewModel.year)
                    .keyboardType(.numberPad)
                    .textFieldStyle(SynrgyTextFieldStyle())
                    .onChange(of: viewModel.year) { _, newValue in
                        let filtered = newValue.filter { $0.isNumber }
                        if filtered.count > 4 {
                            viewModel.year = String(filtered.prefix(4))
                        } else {
                            viewModel.year = filtered
                        }
                        print("ComprehensiveOnboarding: Year changed to: \(viewModel.year)")
                    }
                
                Spacer()
            }
            
            Spacer()
            
            HStack {
                Button(action: {
                    print("ComprehensiveOnboarding: Back from birthday")
                    withAnimation { currentStep = 0 }
                }) {
                    Text("Back")
                        .font(.headline)
                        .foregroundColor(.primary)
                        .frame(height: 50)
                        .frame(maxWidth: .infinity)
                        .background(Color.clear)
                        .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.primary, lineWidth: 1))
                }
                
                Button(action: {
                    print("ComprehensiveOnboarding: Birthday entered: \(viewModel.month)/\(viewModel.day)/\(viewModel.year)")
                    withAnimation { currentStep = 2 }
                }) {
                    Text("Continue")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(height: 50)
                        .frame(maxWidth: .infinity)
                        .background(viewModel.canContinueFromBirthday ? Color.primary : Color.gray.opacity(0.4))
                        .cornerRadius(12)
                }
                .disabled(!viewModel.canContinueFromBirthday)
            }
        }
        .padding(.horizontal, 24)
    }
    
    // MARK: - Hometown View
    private var hometownView: some View {
        VStack(alignment: .leading, spacing: 32) {
            Spacer()
            
            Text("What is your hometown?")
                .font(.title2)
                .fontWeight(.medium)
            
            VStack(alignment: .leading, spacing: 0) {
                TextField("City, State", text: $viewModel.hometown)
                    .textFieldStyle(SynrgyTextFieldStyle())
            }
            
            Spacer()
            
            HStack {
                Button(action: {
                    print("ComprehensiveOnboarding: Back from hometown")
                    withAnimation { currentStep = 1 }
                }) {
                    Text("Back")
                        .font(.headline)
                        .foregroundColor(.primary)
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(Color.clear)
                        .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.primary, lineWidth: 1))
                }
                
                Button(action: {
                    print("ComprehensiveOnboarding: Hometown entered: '\(viewModel.hometown)'")
                    withAnimation { currentStep = 3 }
                }) {
                    Text("Continue")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(viewModel.canContinueFromHometown ? Color.primary : Color.gray.opacity(0.4))
                        .cornerRadius(12)
                }
                .disabled(!viewModel.canContinueFromHometown)
            }
        }
        .padding(.horizontal, 24)
    }
    
    // MARK: - Schooling View
    private var schoolingView: some View {
        VStack(alignment: .leading, spacing: 16) {
            Spacer()
            
            Text("Any Schooling?")
                .font(.title2)
                .fontWeight(.bold)
            
            ScrollView(.vertical) {
                LazyVStack(spacing: 12) {
                    ForEach(viewModel.schoolingEntries.indices, id: \.self) { index in
                        HStack(spacing: 8) {
                            VStack(spacing: 8) {
                                // Award and School
                                HStack(spacing: 8) {
                                    VStack(alignment: .leading, spacing: 2) {
                                        Menu {
                                            Button("High School") { viewModel.schoolingEntries[index].award = "High School" }
                                            Button("Associate") { viewModel.schoolingEntries[index].award = "Associate" }
                                            Button("Bachelor's") { viewModel.schoolingEntries[index].award = "Bachelor's" }
                                            Button("Master's") { viewModel.schoolingEntries[index].award = "Master's" }
                                            Button("PhD") { viewModel.schoolingEntries[index].award = "PhD" }
                                            Button("Certificate") { viewModel.schoolingEntries[index].award = "Certificate" }
                                        } label: {
                                            HStack {
                                                Text(viewModel.schoolingEntries[index].award.isEmpty ? "Degree" : viewModel.schoolingEntries[index].award)
                                                    .foregroundColor(viewModel.schoolingEntries[index].award.isEmpty ? .gray : .primary)
                                                Spacer()
                                                Image(systemName: "chevron.down")
                                                    .font(.caption2)
                                                    .foregroundStyle(.gray)
                                            }
                                            .padding(.horizontal, 16)
                                            .padding(.vertical, 14)
                                            .background(Color.gray.opacity(0.1))
                                            .cornerRadius(12)
                                        }
                                    }
                                    
                                    VStack(alignment: .leading, spacing: 2) {
                                        TextField("e.g., NYU", text: $viewModel.schoolingEntries[index].school)
                                            .textFieldStyle(SynrgyTextFieldStyle())
                                    }
                                }
                                
                                // Subject (conditional)
                                if !viewModel.schoolingEntries[index].award.isEmpty && viewModel.schoolingEntries[index].award != "High School" {
                                    VStack(alignment: .leading, spacing: 2) {
                                        TextField("Subject", text: $viewModel.schoolingEntries[index].subject)
                                            .textFieldStyle(SynrgyTextFieldStyle())
                                    }
                                }
                                
                                // Date range
                                HStack(spacing: 8) {
                                    VStack(alignment: .leading, spacing: 2) {
                                        TextField("Start Date *", text: $viewModel.schoolingEntries[index].startDate)
                                            .textFieldStyle(SynrgyTextFieldStyle())
                                            .disabled(true)
                                            .onTapGesture {
                                                selectedEntryIndex = index
                                                isSchoolingEntry = true
                                                showStartMonthPicker = true
                                            }
                                    }
                                    
                                    VStack(alignment: .leading, spacing: 2) {
                                        TextField(viewModel.schoolingEntries[index].isPresent ? "Present" : "End Date", text: $viewModel.schoolingEntries[index].endDate)
                                            .textFieldStyle(SynrgyTextFieldStyle())
                                            .disabled(true)
                                            .onTapGesture {
                                                if !viewModel.schoolingEntries[index].isPresent {
                                                    selectedEntryIndex = index
                                                    isSchoolingEntry = true
                                                    showEndMonthPicker = true
                                                }
                                            }
                                            .disabled(viewModel.schoolingEntries[index].isPresent)
                                    }
                                }
                                
                                HStack {
                                    Button(action: {
                                        viewModel.schoolingEntries[index].isPresent.toggle()
                                        if viewModel.schoolingEntries[index].isPresent {
                                            viewModel.schoolingEntries[index].endDate = ""
                                        }
                                    }) {
                                        HStack(spacing: 4) {
                                            Image(systemName: viewModel.schoolingEntries[index].isPresent ? "checkmark.square.fill" : "square")
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
                            .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
                            
                            // Plus/Minus buttons
                            VStack(spacing: 8) {
                                if viewModel.schoolingEntries.count == 1 && index == 0 {
                                    Button(action: { viewModel.schoolingEntries.append(SchoolingEntry()) }) {
                                        Image(systemName: "plus")
                                            .foregroundColor(.white)
                                            .frame(width: 28, height: 28)
                                            .background(Color.black)
                                            .clipShape(Circle())
                                    }
                                } else {
                                    Button(action: { viewModel.schoolingEntries.append(SchoolingEntry()) }) {
                                        Image(systemName: "plus")
                                            .foregroundColor(.white)
                                            .frame(width: 28, height: 28)
                                            .background(Color.black)
                                            .clipShape(Circle())
                                    }
                                    
                                    Button(action: { viewModel.schoolingEntries.remove(at: index) }) {
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
            
            HStack(spacing: 12) {
                Button("Back") {
                    print("ComprehensiveOnboarding: Back from schooling")
                    withAnimation { currentStep = 2 }
                }
                .frame(maxWidth: .infinity, maxHeight: 50)
                .foregroundColor(.primary)
                .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.primary, lineWidth: 2))
                
                Button(viewModel.hasSchoolingData ? "Continue" : "Skip") {
                    print("ComprehensiveOnboarding: Schooling - \(viewModel.hasSchoolingData ? "Continue" : "Skip")")
                    withAnimation { currentStep = 4 }
                }
                .frame(maxWidth: .infinity, maxHeight: 50)
                .foregroundColor(.white)
                .background(Color.primary)
                .cornerRadius(12)
            }
        }
        .padding(.horizontal, 24)
    }
    
    // MARK: - Work View
    private var workView: some View {
        VStack(alignment: .leading, spacing: 16) {
            Spacer()
            
            Text("Any Work?")
                .font(.title2)
                .fontWeight(.bold)
            
            ScrollView {
                LazyVStack(spacing: 12) {
                    ForEach(viewModel.workEntries.indices, id: \.self) { index in
                        HStack(spacing: 8) {
                            VStack(spacing: 8) {
                                HStack(spacing: 8) {
                                    VStack(alignment: .leading, spacing: 2) {
                                        TextField("Role", text: $viewModel.workEntries[index].role)
                                            .textFieldStyle(SynrgyTextFieldStyle())
                                    }
                                    
                                    VStack(alignment: .leading, spacing: 2) {
                                        TextField("Company", text: $viewModel.workEntries[index].company)
                                            .textFieldStyle(SynrgyTextFieldStyle())
                                    }
                                }
                                
                                HStack(spacing: 8) {
                                    VStack(alignment: .leading, spacing: 2) {
                                        TextField("Start Date *", text: $viewModel.workEntries[index].startDate)
                                            .textFieldStyle(SynrgyTextFieldStyle())
                                            .disabled(true)
                                            .onTapGesture {
                                                selectedEntryIndex = index
                                                isSchoolingEntry = false
                                                showStartMonthPicker = true
                                            }
                                    }
                                    
                                    VStack(alignment: .leading, spacing: 2) {
                                        TextField(viewModel.workEntries[index].isPresent ? "Present" : "End Date", text: $viewModel.workEntries[index].endDate)
                                            .textFieldStyle(SynrgyTextFieldStyle())
                                            .disabled(true)
                                            .onTapGesture {
                                                if !viewModel.workEntries[index].isPresent {
                                                    selectedEntryIndex = index
                                                    isSchoolingEntry = false
                                                    showEndMonthPicker = true
                                                }
                                            }
                                            .disabled(viewModel.workEntries[index].isPresent)
                                    }
                                }
                                
                                HStack {
                                    Button(action: {
                                        viewModel.workEntries[index].isPresent.toggle()
                                        if viewModel.workEntries[index].isPresent {
                                            viewModel.workEntries[index].endDate = ""
                                        }
                                    }) {
                                        HStack(spacing: 4) {
                                            Image(systemName: viewModel.workEntries[index].isPresent ? "checkmark.square.fill" : "square")
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
                            .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
                            
                            VStack(spacing: 8) {
                                if viewModel.workEntries.count == 1 && index == 0 {
                                    Button(action: {
                                        withAnimation(.spring(response: 0.5, dampingFraction: 0.8)) {
                                            viewModel.workEntries.append(WorkEntry())
                                        }
                                    }) {
                                        Image(systemName: "plus")
                                            .foregroundColor(.white)
                                            .frame(width: 28, height: 28)
                                            .background(Color.black)
                                            .clipShape(Circle())
                                    }
                                } else {
                                    Button(action: {
                                        withAnimation(.spring(response: 0.5, dampingFraction: 0.8)) {
                                            viewModel.workEntries.append(WorkEntry())
                                        }
                                    }) {
                                        Image(systemName: "plus")
                                            .foregroundColor(.white)
                                            .frame(width: 28, height: 28)
                                            .background(Color.black)
                                            .clipShape(Circle())
                                    }
                                    
                                    Button(action: { viewModel.workEntries.remove(at: index) }) {
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
            
            HStack(spacing: 12) {
                Button("Back") {
                    print("ComprehensiveOnboarding: Back from work")
                    withAnimation { currentStep = 3 }
                }
                .frame(maxWidth: .infinity, maxHeight: 50)
                .foregroundColor(.primary)
                .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.primary, lineWidth: 2))
                
                Button(viewModel.hasWorkData ? "Continue" : "Skip") {
                    print("ComprehensiveOnboarding: Work - \(viewModel.hasWorkData ? "Continue" : "Skip")")
                    withAnimation { currentStep = 5 }
                }
                .frame(maxWidth: .infinity, maxHeight: 50)
                .foregroundColor(.white)
                .background(Color.primary)
                .cornerRadius(12)
            }
        }
        .padding(.horizontal, 24)
    }
    
    // MARK: - Hobbies View
    private var hobbiesView: some View {
        VStack(alignment: .leading, spacing: 16) {
            Spacer()
            
            Text("Any Hobbies?")
                .font(.title2)
                .fontWeight(.bold)
                .padding()
            
            ScrollView(.vertical) {
                LazyVStack(spacing: 12) {
                    ForEach(viewModel.hobbyEntries.indices, id: \.self) { index in
                        HStack(spacing: 8) {
                            TextField(
                                index == 0 ? "e.g., Reading, Basketball, Cooking" : "Another hobby...",
                                text: $viewModel.hobbyEntries[index].hobby
                            )
                            .textFieldStyle(SynrgyTextFieldStyle())
                            
                            HStack(spacing: 4) {
                                Button(action: {
                                    viewModel.hobbyEntries.append(HobbyEntry())
                                }) {
                                    Image(systemName: "plus")
                                        .foregroundColor(.white)
                                        .frame(width: 28, height: 28)
                                        .background(Color.black)
                                        .clipShape(Circle())
                                }
                                
                                if viewModel.hobbyEntries.count > 1 {
                                    Button(action: {
                                        viewModel.hobbyEntries.remove(at: index)
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
            .padding(.horizontal, 24)
            
            Spacer()
            
            HStack(spacing: 12) {
                Button("Back") {
                    print("ComprehensiveOnboarding: Back from hobbies")
                    withAnimation { currentStep = 4 }
                }
                .frame(maxWidth: .infinity, maxHeight: 50)
                .foregroundColor(.primary)
                .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.primary, lineWidth: 2))
                
                Button(viewModel.hasHobbiesData ? "Complete" : "Complete") {
                    print("ComprehensiveOnboarding: Hobbies - \(viewModel.hasHobbiesData ? "Complete" : "Skip")")
                    // Print all collected data
                    viewModel.printAllData()
                    // Call completion callback
                    onComplete()
                }
                .frame(maxWidth: .infinity, maxHeight: 50)
                .foregroundColor(.white)
                .background(Color.primary)
                .cornerRadius(12)
            }
            .padding(.horizontal, 24)
        }
    }
}

#Preview {
    ComprehensiveOnboardingFlow(
        onBack: { print("Preview: Back callback triggered") },
        onComplete: { print("Preview: Complete callback triggered") }
    )
}
