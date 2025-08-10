//
//  ProfileViewModel.swift
//  MVVMBasic
//
//  Created by Jimin on 8/10/25.
//

import Foundation

enum NickNameError: Error {
    case emptyInput
    case outOfRange
    case useSpecialCharacter
    case useNumber
    
    var description: String {
        switch self {
        case .emptyInput:
            return "닉네임을 입력해주세요"
        case .outOfRange:
            return "2글자 이상 10글자 미만으로 설정해주세요"
        case .useSpecialCharacter:
            return "닉네임에 @,#,$,% 는 포함할 수 없어요"
        case .useNumber:
            return "닉네임에 숫자는 포함할 수 없어요"
        }
    }
}

final class ProfileViewModel {
    
    var text: String?
    
    private func validateUserInput(text: String) throws(NickNameError) -> String {
        guard !(text.isEmpty) else {
            throw .emptyInput
        }
        
        guard text.count >= 2 && text.count <= 10 else {
            throw .outOfRange
        }
        
        guard text.rangeOfCharacter(from: CharacterSet(charactersIn: "@#$%")) == nil else {
            throw .useSpecialCharacter
        }
        
        guard text.rangeOfCharacter(from: CharacterSet.decimalDigits) == nil else {
            throw .useNumber
        }
        
        return text
    }

    func returnText() -> (message: String, isValid: Bool) {
        guard let text = text else {
            return ("", false)
        }
        do {
            let _ = try validateUserInput(text: text)
            return ("사용할 수 있는 닉네임이에요", true)
        } catch {
            return (error.description, false)
        }
    }
}
