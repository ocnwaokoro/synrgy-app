//
//  ContentView.swift
//  SynrgyApp
//
//  Created by ocnwaokoro on 2024.
//

import SwiftUI

struct ContentView: View {
    @State private var welcomeMessage = "Welcome to Synrgy!"
    
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "star.fill")
                .font(.system(size: 60))
                .foregroundColor(.blue)
            
            Text(welcomeMessage)
                .font(.largeTitle)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
            
            Text("Your iOS app is ready to go!")
                .font(.title2)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
            
            Button("Get Started") {
                // Add your app logic here
                print("Get Started button tapped")
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
