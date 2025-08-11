//
//  CurrencyViewModel.swift
//  MVVMBasic
//
//  Created by Jimin on 8/9/25.
//

import Foundation

final class CurrencyViewModel {
    
    let inputText = Observable("")
    let outputText = Observable("")
    
    init() {
        inputText.bind { _ in
            self.validateInput()
        }
    }
    
    private func validateInput() {
        guard let amount = Double(inputText.value) else {
            outputText.value = "올바른 금액을 입력해주세요"
            return
        }
        
        let exchangeRate = 1350.0 // 실제 환율 데이터로 대체 필요
        let convertedAmount = amount / exchangeRate
        outputText.value = String(format: "%.2f USD (약 $%.2f)", convertedAmount, convertedAmount)
    }
}
