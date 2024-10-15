//
//  ProgressViewLoader.swift
//  Catology
//
//  Created by Emmanuel Albania on 10/10/24.
//

import SwiftUI

struct ProgressViewLoader: View {
    @State private var isAnimating: Bool = false
    
    var body: some View {
        ZStack {
            Circle()
                .trim(from: 0, to: 0.8)
                .stroke(
                    AngularGradient(colors: [.clear, .orange, .orange, .yellow, .yellow, .green, .green, .green], center: .center, startAngle: .zero, endAngle: .degrees(324)),
                    style: StrokeStyle(lineWidth: 5, lineCap: .round)
                )
                .rotationEffect(isAnimating ? .degrees(360): .zero)
                .animation(.linear(duration: 1).repeatForever(autoreverses: false), value: isAnimating)
        }
        .frame(width: 50, height: 50)
        .padding(12)
        .onAppear { isAnimating.toggle() }
    }
}
