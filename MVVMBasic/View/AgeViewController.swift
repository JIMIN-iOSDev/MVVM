//
//  AgeViewController.swift
//  MVVMBasic
//
//  Created by Finn on 8/7/25.
//

import UIKit

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

class AgeViewController: UIViewController {
    let textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "나이를 입력해주세요"
        textField.borderStyle = .roundedRect
        textField.keyboardType = .numberPad
        return textField
    }()
    let resultButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.setTitle( "클릭", for: .normal)
        button.layer.cornerRadius = 8
        return button
    }()
    let label: UILabel = {
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
        view.addSubview(textField)
        view.addSubview(resultButton)
        view.addSubview(label)
    }
    
    func configureLayout() {
        textField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(44)
        }
        
        resultButton.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(44)
        }
        
        label.snp.makeConstraints { make in
            make.top.equalTo(resultButton.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(44)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    private func validateUserInPut(text: String) throws -> Int {
        guard !(text.isEmpty) else {
            throw AgeInputError.emptyInput
        }
        
        guard let age = Int(text) else {
            throw AgeInputError.invalidFormat
        }
        
        guard age >= 1 && age <= 100 else {
            throw AgeInputError.outOfRange
        }
        return age
    }
    
    @objc func resultButtonTapped() {
        view.endEditing(true)
        
        guard let inputText = textField.text else { return }
        
        do {
            let validAge = try  validateUserInPut(text: inputText)
            label.text = "\(validAge)세가 입력되었습니다"
        } catch let error as AgeInputError {
            label.text = error.description
        } catch {
            label.text = "오류 발생"
        }
    }
}
