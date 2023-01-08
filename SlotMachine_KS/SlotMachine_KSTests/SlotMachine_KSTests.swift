//
//  SlotMachine_KSTests.swift
//  SlotMachine_KSTests
//
//  Created by Константин Шмондрик on 09.01.2023.
//

import XCTest
import Combine
@testable import SlotMachine_KS

final class SlotMachine_KSTests: XCTestCase {
    var cancellable = Set<AnyCancellable>()
    var viewModel: SlotViewModel!
    
    override func setUpWithError() throws {
        viewModel = SlotViewModel()
    }
    
    override func tearDownWithError() throws {
        cancellable = []
    }
    
    // Тест изменения текста кнопки в зависимости от состояния вьюмодели
    func testButtonTextChange() {
        let expected = "Крутить!"
        let expectation = XCTestExpectation()
        
        viewModel
            .$buttonText
            .dropFirst()
            .sink { value in
                XCTAssertEqual(value, expected); expectation.fulfill()
            }
            .store(in: &cancellable)
        
        // when
        viewModel.running = false
        
        // Then
        wait(for: [expectation], timeout: 1)
    }
    
    // Тест логики победы, когда выпадает три одинаковых эмодзи подряд
    func testWin() {
        let expected = "Ты победил!"
        let expectation = XCTestExpectation()
        
        viewModel
            .$titleText
            .dropFirst()
            .sink { value in
                XCTAssertEqual(value, expected); expectation.fulfill()
            }
            .store(in: &cancellable)
        
        // when
        viewModel.slot1Emoji = "🍋"
        viewModel.slot2Emoji = "🍋"
        viewModel.slot3Emoji = "🍋"
        
        viewModel.running = false
        viewModel.gameStarted = true
        
        // Then
        wait(for: [expectation], timeout: 1)
    }
    
}
