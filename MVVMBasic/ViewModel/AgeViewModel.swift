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
    
    var text: String?
    
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
    
    func returnText() -> String {
        guard let text else { return "나이를 입력해주세요" }
        
        do {
            let validAge = try validateUserInPut(text: text)
            return "\(validAge)세가 입력되었습니다"
        } catch {
            return error.description
        }
    }
}
