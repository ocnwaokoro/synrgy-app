import SwiftUI

struct SearchBarView: View {
    // MARK: - Properties
    @Binding var searchText: String
    @Binding var isSearchFocused: Bool
    @FocusState private var internalFocusState: Bool
    
    // MARK: - Body
    var body: some View {
        HStack(spacing: 8) { // Use a defined spacing for consistency
            // MARK: Search Field
            HStack(spacing: 8) {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                
                TextField(internalFocusState ? "Pick a Route" : "Where do you want to go?", text: $searchText)
                    .textFieldStyle(PlainTextFieldStyle())
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.never)
                    .keyboardType(.webSearch)
                    .focused($internalFocusState)
                    .onSubmit {
                        print("Search submitted: '\(searchText)'")
                    }
                
                // Show the clear button only when there's text
                if !searchText.isEmpty {
                    Button(action: {
                        searchText = ""
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.gray)
                    }
                    // Animate the clear button's appearance
                    .transition(.opacity.animation(.easeInOut(duration: 0.2)))
                }
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 10)
            .background(Color(.systemGray5))
            .cornerRadius(10)
            
            // MARK: Action Button
            if internalFocusState || !searchText.isEmpty {
                Button("Cancel") {
                    withAnimation(.easeOut(duration: 0.2)) {
                        internalFocusState = false
                        searchText = ""
                        isSearchFocused = false
                    }
                }
                .foregroundColor(.blue)
                .transition(.move(edge: .trailing).combined(with: .opacity))
                .frame(height: 40)
            } else {
                Circle()
                    .fill(Color.blue)
                    .frame(width: 40, height: 40)
                    .overlay(
                        Text("ON")
                            .foregroundColor(.white)
                            .font(.caption)
                            .bold()
                    )
                .transition(.move(edge: .trailing).combined(with: .opacity))
            }
        }
        .padding(.horizontal)
        // Add padding around the search bar and control the overall animation
        .animation(.spring(response: 0.3, dampingFraction: 0.75), value: internalFocusState)
        .onChange(of: internalFocusState) { _, focused in
            isSearchFocused = focused
        }
        .onAppear {
            print("SearchBarView: Search bar appeared")
        }
    }
}

// MARK: - Preview
#Preview {
    struct PreviewWrapper: View {
        @State private var searchText = ""
        @State private var isSearchFocused = false
        
        var body: some View {
            SearchBarView(searchText: $searchText, isSearchFocused: $isSearchFocused)
                .padding(.top, 20)
        }
    }
    
    return PreviewWrapper()
}
