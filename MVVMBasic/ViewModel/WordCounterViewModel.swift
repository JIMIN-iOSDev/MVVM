//
//  WordCounterViewModel.swift
//  MVVMBasic
//
//  Created by Jimin on 8/9/25.
//

import Foundation

final class WordCounterViewModel {
    
    let inputText = Observable("")
    let outputText = Observable("")
    
    init() {
        inputText.bind { count in
            self.validateInput(count: count)
        }
    }
    
    private func validateInput(count: String) {
        if !inputText.value.isEmpty {
            outputText.value = "현재까지 \(count)글자 작성중"
        } else {
            outputText.value = "글자를 입력하세요"
        }
    }
}
