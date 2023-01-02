//
//  SlotViewModel.swift
//  SlotMachine_KS
//
//  Created by Константин Шмондрик on 02.01.2023.
//

import SwiftUI
import Combine

class SlotViewModel: ObservableObject {
    private var cancellables = Set<AnyCancellable>()
    
    private let emojiSourceArray = ["🍋", "🍒", "🍓"]
    private let timer = Timer.publish(every: 0.05, on: .main, in: .common).autoconnect()
    
    // MARK: - Init
    init() {
        self.setUpBindings()
    }
    
    // MARK: - Private functions
    private func setUpBindings() {
        timer
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                guard let self = self else { return }
                
                self.randomize()
            }
            .store(in: &cancellables)
        
        $running
            .receive(on: RunLoop.main)
            .map {
                guard !$0 && self.gameStarted else { return "Крути барабан!" }
                
                return self.slot1Emoji == self.slot2Emoji && self.slot2Emoji == self.slot3Emoji ? "Ты победил!" : "Не повезло, крути еще!"
            }
            .assign(to: \.titleText, on: self)
            .store(in: &cancellables)
        
        $running
            .receive(on: RunLoop.main)
            .map { $0 ? "Стоп!" : "Крутить!" }
            .assign(to: \.buttonText, on: self)
            .store(in: &cancellables)
    }
    
    private func randomize() {
        guard running else { return }
        
        slot1Emoji = emojiSourceArray[Int.random(in: 0...emojiSourceArray.count - 1)]
        slot2Emoji = emojiSourceArray[Int.random(in: 0...emojiSourceArray.count - 1)]
        slot3Emoji = emojiSourceArray[Int.random(in: 0...emojiSourceArray.count - 1)]
    }
    
    // MARK: - Input
    @Published var running = false
    @Published var gameStarted = false
    
    // MARK: - Output
    @Published var slot1Emoji = "🍒"
    @Published var slot2Emoji = "🍓"
    @Published var slot3Emoji = "🍋"
    @Published var titleText = ""
    @Published var buttonText = ""
}
