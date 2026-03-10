//
//  PulseEffect.swift
//  DailyCelebration
//
//  Created by Victor Emanuel Ribeiro Silva on 09/03/26.
//

import SwiftUI
import Foundation

struct PulseOpacityEffect : ViewModifier {
    @State private var animate: Bool = false
    
    func body(content: Content) -> some View {
        content
            .opacity(animate ? 0.4 : 1.0)
            .onAppear {
                withAnimation(
                    .easeInOut(duration: 1).repeatForever(autoreverses: true)
                ) {
                    self.animate.toggle()
                }
            }
    }
}

extension View {
    func pulseOpacityEffect() -> some View {
        self.modifier(PulseOpacityEffect())
    }
}


#Preview {
    Image(systemName: "sparkles")
        .foregroundStyle(Color.gray)
        .scaleEffect(5)
        .pulseOpacityEffect()
}
