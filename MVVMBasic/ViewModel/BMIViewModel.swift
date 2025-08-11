//
//  BMIViewModel.swift
//  MVVMBasic
//
//  Created by Jimin on 8/9/25.
//

import Foundation

enum BMIInputError: Error {
    case emptyHeight
    case emptyWeight
    case invalidHeightFormat
    case invalidWeightFormat
    case heightOutOfRange
    case weightOutOfRange
    
    var description: String {
        switch self {
        case .emptyHeight:
            return "키를 입력해주세요"
        case .emptyWeight:
            return "몸무게를 입력해주세요"
        case .invalidHeightFormat:
            return "올바른 키 형식을 입력해주세요"
        case .invalidWeightFormat:
            return "올바른 몸무게 형식을 입력해주세요"
        case .heightOutOfRange:
            return "키는 100cm ~ 250cm 사이로 입력해주세요"
        case .weightOutOfRange:
            return "몸무게는 20kg ~ 300kg 사이로 입력해주세요"
        }
    }
    
    var title: String {
        switch self {
        case .emptyHeight, .emptyWeight:
            return "입력 필요"
        case .invalidHeightFormat, .invalidWeightFormat:
            return "형식 오류"
        case .heightOutOfRange, .weightOutOfRange:
            return "범위 오류"
        }
    }
}

final class BMIViewModel {
    
    let heightText = Observable("")
    let weightText = Observable("")
    let outputText = Observable("")
    
    init() {
        heightText.bind { _ in
            self.validateInput()
        }
        
        weightText.bind { _ in
            self.validateInput()
        }
    }
    
    private func validateInput() {
        do {
            let (height, weight) = try validateInputs()
            let bmi = calculateBMI(height: height, weight: weight)
            let bmiText = String(format: "%.1f", bmi)
            outputText.value = "BMI: \(bmiText)"
        } catch {
            outputText.value = error.description
        }
    }
    
    private func validateInputs() throws(BMIInputError) -> (height: Double, weight: Double) {
        guard !heightText.value.isEmpty else {
            throw .emptyHeight
        }
        
        guard let height = Double(heightText.value) else {
            throw .invalidHeightFormat
        }
        
        guard height >= 100 && height <= 250 else {
            throw .heightOutOfRange
        }
        
        guard !weightText.value.isEmpty else {
            throw .emptyWeight
        }
        
        guard let weight = Double(weightText.value) else {
            throw .invalidWeightFormat
        }
        
        guard weight >= 20 && weight <= 300 else {
            throw .weightOutOfRange
        }
        return (height, weight)
    }
    
    private func calculateBMI(height: Double, weight: Double) -> Double {
        let heightInMeters = height / 100.0
        let bmi = weight / (heightInMeters * heightInMeters)
        return bmi
    }
}
