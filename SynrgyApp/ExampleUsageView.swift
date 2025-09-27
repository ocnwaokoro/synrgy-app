////
////  ExampleUsageView.swift
////  SynrgyApp
////
////  Created by ocnwaokoro on 2024.
////
//
//import SwiftUI
//
///// Example view showing how to use the OnboardingPersonalInfoView
///// This demonstrates the proper integration with the main app flow
//struct ExampleUsageView: View {
//    @StateObject private var synrgyVM = SynrgyViewModel()
//    @State private var selectedTab: Int = 0
//    @State private var isLoading: Bool = false
//    
//    var body: some View {
//        TabView(selection: $selectedTab) {
//            // Tab 0: Onboarding Personal Info
//            OnboardingPersonalInfoView(
//                synrgyVM: synrgyVM,
//                selectedTab: $selectedTab,
//                isLoading: $isLoading
//            )
//            .tabItem {
//                Image(systemName: "person.circle")
//                Text("Personal Info")
//            }
//            .tag(0)
//            
//            // Tab 1: Loading State
//            if isLoading {
//                LoadingView()
//                    .tabItem {
//                        Image(systemName: "arrow.clockwise")
//                        Text("Loading")
//                    }
//                    .tag(1)
//            }
//            
//            // Tab 2: Next Step (Timeline/Milestones)
//            TimelineRoadmapView()
//                .tabItem {
//                    Image(systemName: "timeline.selection")
//                    Text("Timeline")
//                }
//                .tag(2)
//        }
//        .onChange(of: isLoading) { _, loading in
//            if loading {
//                // Simulate loading time
//                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
//                    withAnimation {
//                        isLoading = false
//                        selectedTab = 2
//                    }
//                }
//            }
//        }
//    }
//}
//
//// MARK: - Loading View
//struct LoadingView: View {
//    @State private var isAnimating = false
//    
//    var body: some View {
//        VStack(spacing: 24) {
//            // Animated loading indicator
//            Circle()
//                .trim(from: 0, to: 0.7)
//                .stroke(Color.blue, lineWidth: 4)
//                .frame(width: 60, height: 60)
//                .rotationEffect(.degrees(isAnimating ? 360 : 0))
//                .animation(.linear(duration: 1).repeatForever(autoreverses: false), value: isAnimating)
//            
//            Text("Creating your personalized roadmap...")
//                .font(.headline)
//                .foregroundColor(.primary)
//                .multilineTextAlignment(.center)
//            
//            Text("This may take a moment")
//                .font(.subheadline)
//                .foregroundColor(.secondary)
//        }
//        .padding()
//        .onAppear {
//            isAnimating = true
//            print("LoadingView: Loading animation started")
//        }
//    }
//}
//
//// MARK: - Preview
//struct ExampleUsageView_Previews: PreviewProvider {
//    static var previews: some View {
//        ExampleUsageView()
//    }
//}

