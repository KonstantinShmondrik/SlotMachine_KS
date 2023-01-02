//
//  SlotView.swift
//  SlotMachine_KS
//
//  Created by Константин Шмондрик on 02.01.2023.
//

import SwiftUI
import Combine

struct SlotView <Content: View>: View {
    var content: () -> Content
    
    init(@ViewBuilder content: @escaping () -> Content) { self.content = content }
    
    var body: some View {
            content()
            .font(.system(size: 64.0))
            .transition(.asymmetric(insertion: .move(edge: .top),
                                    removal: .move(edge: .bottom)))
            .animation(.easeInOut)
            .id(UUID())
    }
    
    
    
}
