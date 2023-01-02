//
//  ContentView.swift
//  SlotMachine_KS
//
//  Created by Константин Шмондрик on 02.01.2023.
//

import SwiftUI

struct SlotMainView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SlotMainView()
    }
}
