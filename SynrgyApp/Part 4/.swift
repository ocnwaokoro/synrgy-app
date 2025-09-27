//
//  ExperienceInfoView.swift
//  SynrgyApp
//
//  Created by Obinna Nwaokoro on 9/27/25.
//

import SwiftUI

struct ExperienceInfoView: View {
    @ObservedObject var synrgyVM: SynrgyViewModel
    @State private var schoolingEntries: [SchoolingEntry] = [SchoolingEntry()]
    @State private var workEntries: [WorkEntry] = [WorkEntry()]
    @State private var hobbyEntries: [HobbyEntry] = [HobbyEntry()]
    @Binding var selectedTab: Int
    
    private var canContinue: Bool {
        !schoolingEntries.isEmpty && !workEntries.isEmpty
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 32) {
                // Progress indicator
                HStack {
                    ForEach(0..<3) { index in
                        Circle()
                            .fill(index == 1 ? Color.primary : Color.gray.opacity(0.3))
                            .frame(width: 8, height: 8)
                    }
                    Spacer()
                }
                .padding(.horizontal, 24)
                
                VStack(spacing: 40) {
                    // Schooling Section
                    VStack(alignment: .leading, spacing: 20) {
                        HStack {
                            Text("Any Schooling?")
                                .font(.title2)
                                .fontWeight(.medium)
                            Spacer()
                            Button(action: {
                                schoolingEntries.append(SchoolingEntry())
                            }) {
                                Image(systemName: "plus.circle.fill")
                                    .font(.title2)
                                    .foregroundColor(.primary)
                            }
                        }
                        
                        ForEach(schoolingEntries.indices, id: \.self) { index in
                            SchoolingEntryView(entry: $schoolingEntries[index])
                        }
                    }
                    
                    // Work Section
                    VStack(alignment: .leading, spacing: 20) {
                        HStack {
                            Text("Any Work?")
                                .font(.title2)
                                .fontWeight(.medium)
                            Spacer()
                            Button(action: {
                                workEntries.append(WorkEntry())
                            }) {
                                Image(systemName: "plus.circle.fill")
                                    .font(.title2)
                                    .foregroundColor(.primary)
                            }
                        }
                        
                        ForEach(workEntries.indices, id: \.self) { index in
                            WorkEntryView(entry: $workEntries[index])
                        }
                    }
                    
                    // Hobbies Section
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Any Hobbies?")
                            .font(.title2)
                            .fontWeight(.medium)
                        
                        ForEach(hobbyEntries.indices, id: \.self) { index in
                            HobbyEntryView(entry: $hobbyEntries[index])
                        }
                        
                        Button(action: {
                            hobbyEntries.append(HobbyEntry())
                        }) {
                            HStack {
                                Image(systemName: "plus.circle.fill")
                                    .foregroundColor(.primary)
                                Text("Add Hobby")
                                    .foregroundColor(.primary)
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 12)
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(12)
                        }
                    }
                    
                    // Continue button
                    Button(action: {
                        synrgyVM.schoolingEntries = schoolingEntries
                        synrgyVM.workEntries = workEntries
                        synrgyVM.hobbies = hobbyEntries.compactMap { $0.hobby.isEmpty ? nil : $0.hobby }.joined(separator: ", ")
                        
                        withAnimation {
                            selectedTab = 2
                        }
                    }) {
                        Text("Continue")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(Color.primary)
                            .cornerRadius(12)
                    }
                }
                .padding(.horizontal, 24)
            }
        }
        .navigationBarHidden(true)
    }
}

struct SchoolingEntryView: View {
    @Binding var entry: SchoolingEntry
    
    var body: some View {
        VStack(spacing: 16) {
            HStack(spacing: 16) {
                Menu {
                    Button("High School") { entry.award = "High School" }
                    Button("Associate") { entry.award = "Associate" }
                    Button("Bachelor's") { entry.award = "Bachelor's" }
                    Button("Master's") { entry.award = "Master's" }
                    Button("PhD") { entry.award = "PhD" }
                    Button("Certificate") { entry.award = "Certificate" }
                } label: {
                    HStack {
                        Text(entry.award.isEmpty ? "Award" : entry.award)
                            .foregroundColor(entry.award.isEmpty ? .gray : .primary)
                        Spacer()
                        Image(systemName: "chevron.down")
                            .font(.caption)
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 14)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(12)
                }
                
                TextField("School", text: $entry.school)
                    .textFieldStyle(SynrgyTextFieldStyle())
            }
            
            if !entry.award.isEmpty {
                TextField("Subject(s)", text: $entry.subject)
                    .textFieldStyle(SynrgyTextFieldStyle())
            }
            
            HStack(spacing: 8) {
                TextField("MMM", text: $entry.startMonth)
                    .keyboardType(.numberPad)
                    .textFieldStyle(SynrgyTextFieldStyle())
                    .frame(maxWidth: 50)
                    .font(.caption)
                    .onChange(of: entry.startMonth) { newValue in
                        if newValue.count > 3 {
                            entry.startMonth = String(newValue.prefix(3))
                        }
                    }
                
                TextField("YYYY", text: $entry.startYear)
                    .keyboardType(.numberPad)
                    .textFieldStyle(SynrgyTextFieldStyle())
                    .frame(maxWidth: 60)
                    .font(.caption)
                    .onChange(of: entry.startYear) { newValue in
                        if newValue.count > 4 {
                            entry.startYear = String(newValue.prefix(4))
                        }
                    }
                
                Text("to")
                    .font(.caption)
                    .foregroundColor(.gray)
                
                TextField("MMM", text: $entry.endMonth)
                    .keyboardType(.numberPad)
                    .textFieldStyle(SynrgyTextFieldStyle())
                    .frame(maxWidth: 50)
                    .font(.caption)
                    .onChange(of: entry.endMonth) { newValue in
                        if newValue.count > 3 {
                            entry.endMonth = String(newValue.prefix(3))
                        }
                    }
                
                TextField("YYYY", text: $entry.endYear)
                    .keyboardType(.numberPad)
                    .textFieldStyle(SynrgyTextFieldStyle())
                    .frame(maxWidth: 60)
                    .font(.caption)
                    .onChange(of: entry.endYear) { newValue in
                        if newValue.count > 4 {
                            entry.endYear = String(newValue.prefix(4))
                        }
                    }
                
                Spacer()
            }
        }
        .padding(16)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.05), radius: 2, x: 0, y: 1)
    }
}

struct WorkEntryView: View {
    @Binding var entry: WorkEntry
    
    var body: some View {
        VStack(spacing: 16) {
            HStack(spacing: 16) {
                TextField("Role", text: $entry.role)
                    .textFieldStyle(SynrgyTextFieldStyle())
                
                TextField("Company", text: $entry.company)
                    .textFieldStyle(SynrgyTextFieldStyle())
            }
            
            HStack(spacing: 8) {
                TextField("MMM", text: $entry.startMonth)
                    .keyboardType(.numberPad)
                    .textFieldStyle(SynrgyTextFieldStyle())
                    .frame(maxWidth: 50)
                    .font(.caption)
                    .onChange(of: entry.startMonth) { newValue in
                        if newValue.count > 3 {
                            entry.startMonth = String(newValue.prefix(3))
                        }
                    }
                
                TextField("YYYY", text: $entry.startYear)
                    .keyboardType(.numberPad)
                    .textFieldStyle(SynrgyTextFieldStyle())
                    .frame(maxWidth: 60)
                    .font(.caption)
                    .onChange(of: entry.startYear) { newValue in
                        if newValue.count > 4 {
                            entry.startYear = String(newValue.prefix(4))
                        }
                    }
                
                Text("to")
                    .font(.caption)
                    .foregroundColor(.gray)
                
                TextField("MMM", text: $entry.endMonth)
                    .keyboardType(.numberPad)
                    .textFieldStyle(SynrgyTextFieldStyle())
                    .frame(maxWidth: 50)
                    .font(.caption)
                    .onChange(of: entry.endMonth) { newValue in
                        if newValue.count > 3 {
                            entry.endMonth = String(newValue.prefix(3))
                        }
                    }
                
                TextField("YYYY", text: $entry.endYear)
                    .keyboardType(.numberPad)
                    .textFieldStyle(SynrgyTextFieldStyle())
                    .frame(maxWidth: 60)
                    .font(.caption)
                    .onChange(of: entry.endYear) { newValue in
                        if newValue.count > 4 {
                            entry.endYear = String(newValue.prefix(4))
                        }
                    }
                
                Spacer()
            }
        }
        .padding(16)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.05), radius: 2, x: 0, y: 1)
    }
}

struct HobbyEntryView: View {
    @Binding var entry: HobbyEntry
    
    var body: some View {
        VStack(spacing: 16) {
            HStack(spacing: 16) {
                TextField("Hobby", text: $entry.hobby)
                    .textFieldStyle(SynrgyTextFieldStyle())
                
                Button(action: {
                    entry.hobby = ""
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                }
            }
        }
        .padding(16)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.05), radius: 2, x: 0, y: 1)
    }
}

// Data models
struct SchoolingEntry {
    var award: String = ""
    var school: String = ""
    var subject: String = ""
    var startMonth: String = ""
    var startYear: String = ""
    var endMonth: String = ""
    var endYear: String = ""
}

struct WorkEntry {
    var role: String = ""
    var company: String = ""
    var startMonth: String = ""
    var startYear: String = ""
    var endMonth: String = ""
    var endYear: String = ""
}

struct HobbyEntry {
    var hobby: String = ""
}

struct ExperienceInfoView_Previews: PreviewProvider {
    static var previews: some View {
        ExperienceInfoView(synrgyVM: SynrgyViewModel(), selectedTab: .constant(1))
    }
}
