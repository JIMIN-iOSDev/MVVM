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

final class BMIViewController: UIViewController {
    
    private let heightTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "키를 입력해주세요"
        textField.borderStyle = .roundedRect
        return textField
    }()
    private let weightTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "몸무게를 입력해주세요"
        textField.borderStyle = .roundedRect
        return textField
    }()
    private let resultButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.setTitle("클릭", for: .normal)
        button.layer.cornerRadius = 8
        return button
    }()
    private let resultLabel: UILabel = {
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
    
    private func configureHierarchy() {
        view.addSubview(heightTextField)
        view.addSubview(weightTextField)
        view.addSubview(resultButton)
        view.addSubview(resultLabel)
    }
    
    private func configureLayout() {
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
    
    private func validateInputs() throws(BMIInputError) -> (height: Double, weight: Double) {
        guard let heightText = heightTextField.text, !heightText.isEmpty else {
            throw .emptyHeight
        }
        
        guard let height = Double(heightText) else {
            throw .invalidHeightFormat
        }
        
        guard height >= 100 && height <= 250 else {
            throw .heightOutOfRange
        }
        
        guard let weightText = weightTextField.text, !weightText.isEmpty else {
            throw .emptyWeight
        }
        
        guard let weight = Double(weightText) else {
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
        } catch {
            showErrorAlert(error: error)
        }
    }
}
