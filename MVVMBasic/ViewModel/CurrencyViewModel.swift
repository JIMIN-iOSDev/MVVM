//
//  CurrencyViewModel.swift
//  MVVMBasic
//
//  Created by Jimin on 8/9/25.
//

import Foundation

final class CurrencyViewModel {
    var text: String?
    
    func amountText() -> String {
        guard let amountText = text, let amount = Double(amountText) else {
            return "올바른 금액을 입력해주세요"
        }
        
        let exchangeRate = 1350.0 // 실제 환율 데이터로 대체 필요
        let convertedAmount = amount / exchangeRate
        return String(format: "%.2f USD (약 $%.2f)", convertedAmount, convertedAmount)
    }
}
