//
//  ContentView.swift
//  SlotMachine_KS
//
//  Created by Константин Шмондрик on 02.01.2023.
//

import SwiftUI
import Combine

struct SlotMachineView: View {
    @ObservedObject private var viewModel = SlotViewModel()
    
    var body: some View {
        VStack {
            Spacer()
            Text(viewModel.titleText)
            Spacer()
            
            HStack {
                SlotView { Text(viewModel.slot1Emoji) }
                SlotView { Text(viewModel.slot2Emoji) }
                SlotView { Text(viewModel.slot3Emoji) }
            }
            
            Spacer()
            Button(action: { viewModel.running.toggle(); viewModel.gameStarted = true },
                   label: { Text(viewModel.buttonText) })
            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SlotMachineView()
    }
}
