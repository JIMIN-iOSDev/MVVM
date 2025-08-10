//
//  ProfileViewController.swift
//  MVVMBasic
//
//  Created by Jimin on 8/10/25.
//

import UIKit
import SnapKit

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

final class ProfileViewController: UIViewController {

    private let image = {
        let image = UIImageView()
        image.image = UIImage(systemName: "person")
        image.layer.cornerRadius = 60
        image.clipsToBounds = true
        image.layer.borderColor = UIColor.systemBlue.cgColor
        image.layer.borderWidth = 5
        return image
    }()
    
    private let textField = {
        let tf = UITextField()
        tf.placeholder = "닉네임을 입력해주세요"
        tf.textColor = .black
        return tf
    }()
    
    private let line = {
        let view = UIView()
        view.backgroundColor = .systemGray5
        return view
    }()
    
    private let status = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    private let label = {
        let label = UILabel()
        label.text = "MBTI"
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()
    
    private let eButton = {
        let button = Button(title: "E")
        return button
    }()
    
    private let sButton = {
        let button = Button(title: "S")
        return button
    }()
    
    private let tButton = {
        let button = Button(title: "T")
        return button
    }()
    
    private let jButton = {
        let button = Button(title: "J")
        return button
    }()
    
    private let iButton = {
        let button = Button(title: "I")
        return button
    }()
    
    private let nButton = {
        let button = Button(title: "N")
        return button
    }()
    
    private let fButton = {
        let button = Button(title: "F")
        return button
    }()
    
    private let pButton = {
        let button = Button(title: "P")
        return button
    }()
    
    private let endButton = {
        let button = UIButton()
        button.setTitle("완료", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .gray
        button.layer.cornerRadius = 20
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "PROFILE SETTING"
        navigationController?.navigationBar.tintColor = .black
        configureHierarchy()
        configureLayout()
        
        textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    
    @objc private func textFieldDidChange() {
        guard let text = textField.text else {
            return
        }
        
        do {
            let _ = try validateUserInput(text: text)
            status.text = "사용할 수 있는 닉네임이에요"
            status.textColor = UIColor(hex: "#186FF2")
        } catch {
            status.text = error.description
            status.textColor = UIColor(hex: "#F04452")
        }
    }
}

extension ProfileViewController {
    private func configureHierarchy() {
        view.addSubview(image)
        view.addSubview(textField)
        view.addSubview(line)
        view.addSubview(status)
        view.addSubview(label)
        view.addSubview(eButton)
        view.addSubview(sButton)
        view.addSubview(tButton)
        view.addSubview(jButton)
        view.addSubview(iButton)
        view.addSubview(nButton)
        view.addSubview(fButton)
        view.addSubview(pButton)
        view.addSubview(endButton)
    }
    
    private func configureLayout() {
        image.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.centerX.equalToSuperview()
            make.size.equalTo(120)
        }
        textField.snp.makeConstraints { make in
            make.top.equalTo(image.snp.bottom).offset(40)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(44)
        }
        line.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.bottom)
            make.horizontalEdges.equalToSuperview().inset(15)
            make.height.equalTo(1)
        }
        status.snp.makeConstraints { make in
            make.top.equalTo(line.snp.bottom).offset(15)
            make.leading.equalToSuperview().offset(20)
        }
        label.snp.makeConstraints { make in
            make.top.equalTo(line.snp.bottom).offset(80)
            make.leading.equalToSuperview().offset(20)
        }
        eButton.snp.makeConstraints { make in
            make.top.equalTo(label.snp.top)
            make.leading.equalTo(label.snp.trailing).offset(55)
            make.size.equalTo(55)
        }
        sButton.snp.makeConstraints { make in
            make.top.equalTo(eButton.snp.top)
            make.leading.equalTo(eButton.snp.trailing).offset(10)
            make.size.equalTo(55)
        }
        tButton.snp.makeConstraints { make in
            make.top.equalTo(eButton.snp.top)
            make.leading.equalTo(sButton.snp.trailing).offset(10)
            make.size.equalTo(55)
        }
        jButton.snp.makeConstraints { make in
            make.top.equalTo(eButton.snp.top)
            make.leading.equalTo(tButton.snp.trailing).offset(10)
            make.size.equalTo(55)
        }
        iButton.snp.makeConstraints { make in
            make.top.equalTo(eButton.snp.bottom).offset(10)
            make.leading.equalTo(eButton.snp.leading)
            make.size.equalTo(55)
        }
        nButton.snp.makeConstraints { make in
            make.top.equalTo(iButton.snp.top)
            make.leading.equalTo(iButton.snp.trailing).offset(10)
            make.size.equalTo(55)
        }
        fButton.snp.makeConstraints { make in
            make.top.equalTo(iButton.snp.top)
            make.leading.equalTo(nButton.snp.trailing).offset(10)
            make.size.equalTo(55)
        }
        pButton.snp.makeConstraints { make in
            make.top.equalTo(iButton.snp.top)
            make.leading.equalTo(fButton.snp.trailing).offset(10)
            make.size.equalTo(55)
        }
        endButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-35)
            make.horizontalEdges.equalToSuperview().inset(15)
            make.height.equalTo(44)
        }
    }
    
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
}
