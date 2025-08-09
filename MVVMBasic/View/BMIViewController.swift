//
//  BMIViewController.swift
//  MVVMBasic
//
//  Created by Finn on 8/7/25.
//

import UIKit

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

enum BMICategory {
    case underweight
    case normal
    case overweight
    case obese
    
    var description: String {
        switch self {
        case .underweight:
            return "저체중"
        case .normal:
            return "정상체중"
        case .overweight:
            return "과체중"
        case .obese:
            return "비만"
        }
    }
}

final class BMIViewController: UIViewController {
    let heightTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "키를 입력해주세요"
        textField.borderStyle = .roundedRect
        return textField
    }()
    let weightTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "몸무게를 입력해주세요"
        textField.borderStyle = .roundedRect
        return textField
    }()
    let resultButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.setTitle("클릭", for: .normal)
        button.layer.cornerRadius = 8
        return button
    }()
    let resultLabel: UILabel = {
        let label = UILabel()
        label.text = "여기에 결과를 보여주세요"
        label.textAlignment = .center
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureLayout()
        
        resultButton.addTarget(self, action: #selector(resultButtonTapped), for: .touchUpInside)
    }
    
    func configureHierarchy() {
        view.addSubview(heightTextField)
        view.addSubview(weightTextField)
        view.addSubview(resultButton)
        view.addSubview(resultLabel)
    }
    
    func configureLayout() {
        heightTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(44)
        }
        
        weightTextField.snp.makeConstraints { make in
            make.top.equalTo(heightTextField.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(44)
        }
        
        resultButton.snp.makeConstraints { make in
            make.top.equalTo(weightTextField.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(44)
        }
        
        resultLabel.snp.makeConstraints { make in
            make.top.equalTo(resultButton.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(44)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    private func validateInputs() throws -> (height: Double, weight: Double) {
        guard let heightText = heightTextField.text, !heightText.isEmpty else {
            throw BMIInputError.emptyHeight
        }
        
        guard let weightText = weightTextField.text, !weightText.isEmpty else {
            throw BMIInputError.emptyWeight
        }
        
        guard let height = Double(heightText) else {
            throw BMIInputError.invalidHeightFormat
        }
        
        guard let weight = Double(weightText) else {
            throw BMIInputError.invalidWeightFormat
        }
        
        guard height >= 100 && height <= 250 else {
            throw BMIInputError.heightOutOfRange
        }
        
        guard weight >= 20 && weight <= 300 else {
            throw BMIInputError.weightOutOfRange
        }
        
        return (height, weight)
    }
    
    private func calculateBMI(height: Double, weight: Double) -> Double {
        let heightInMeters = height / 100.0
        let bmi = weight / (heightInMeters * heightInMeters)
        return bmi
    }
    
    private func showErrorAlert(error: BMIInputError) {
        let alert = UIAlertController(title: error.title, message: error.description, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default))
        present(alert, animated: true)
    }
    
    @objc func resultButtonTapped() {
        view.endEditing(true)
        
        do {
            let (height, weight) = try validateInputs()
            let bmi = calculateBMI(height: height, weight: weight)
            let bmiText = String(format: "%.1f", bmi)
            resultLabel.text = "BMI: \(bmiText)"
        } catch let error as BMIInputError {
            showErrorAlert(error: error)
            resultLabel.text = "입력값을 확인해주세요"
        } catch {
            resultLabel.text = "오류 발생"
        }
    }
}
