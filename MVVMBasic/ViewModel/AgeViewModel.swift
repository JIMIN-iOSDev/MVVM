//
//  AgeViewModel.swift
//  MVVMBasic
//
//  Created by Jimin on 8/9/25.
//

import Foundation

enum AgeInputError: Error {
    case emptyInput
    case invalidFormat
    case outOfRange
    
    var description: String {
        switch self {
        case .emptyInput:
            return "나이를 입력해주세요"
        case .invalidFormat:
            return "올바른 숫자를 입력해주세요"
        case .outOfRange:
            return "1세 ~ 100세 사이의 나이를 입력해주세요"
        }
    }
}

final class AgeViewModel {
    
    // VC -> VM
    let inputText = Observable("")
    
    // VM -> VC
    let outputText = Observable("나이를 입력해주세요")
    
    init() {
        inputText.bind { text in
            self.validateInput(text: text)
        }
    }
    
    private func validateInput(text: String) {
        do {
            let validAge = try validateUserInPut(text: text)
            outputText.value = "\(validAge)세가 입력되었습니다"
        } catch {
            outputText.value = error.description
        }
    }
    
    private func validateUserInPut(text: String) throws(AgeInputError) -> Int {
        guard !(text.isEmpty) else {
            throw .emptyInput
        }
        
        guard let age = Int(text) else {
            throw .invalidFormat
        }
        
        guard age >= 1 && age <= 100 else {
            throw .outOfRange
        }
        return age
    }
}
