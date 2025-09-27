//
//  RoadmapView.swift
//  SynrgyApp
//
//  Created by Obinna Nwaokoro on 9/27/25.
//

import SwiftUI

struct RoadmapView: View {
    @State var boo = true
    @State var currentDetent: PresentationDetent = .fraction(0.4)
    let base: CGFloat = 199
    
    var body: some View {
        TimelineRoadmapView()
            .contentShape(Rectangle())
            .onTapGesture {
                if currentDetent == .fraction(0.4) {
                    currentDetent = .height(base)
                }
            }
            .sheet(isPresented: $boo) {
                MessagesView()
                    .presentationDetents([.height(base), .height(base+1)], selection: $currentDetent)
                    .presentationBackgroundInteraction(.enabled(upThrough: .height(200)))
                    .presentationDragIndicator(.visible)
                    .interactiveDismissDisabled(true)
            }
    }
}

#Preview {
    RoadmapView()
}
