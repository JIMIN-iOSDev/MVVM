//
//  BirthDayViewController.swift
//  MVVMBasic
//
//  Created by Finn on 8/7/25.
//

import UIKit
import SnapKit

enum BirthDateError: Error {
    case emptyYear
    case emptyMonth
    case emptyDay
    case invalidYearFormat
    case invalidMonthFormat
    case invalidDayFormat
    case yearOutOfRange
    case monthOutOfRange
    case dayOutOfRange
    case invalidDate
    case futureDate
    
    var description: String {
        switch self {
        case .emptyYear:
            return "년도를 입력해주세요"
        case .emptyMonth:
            return "월을 입력해주세요"
        case .emptyDay:
            return "일을 입력해주세요"
        case .invalidYearFormat:
            return "올바른 년도를 입력해주세요"
        case .invalidMonthFormat:
            return "올바른 월을 입력해주세요"
        case .invalidDayFormat:
            return "올바른 일을 입력해주세요"
        case .yearOutOfRange:
            return "년도는 1900년 ~ 현재년도 사이로 입력해주세요"
        case .monthOutOfRange:
            return "월은 1월 ~ 12월 사이로 입력해주세요"
        case .dayOutOfRange:
            return "일은 1일 ~ 31일 사이로 입력해주세요"
        case .invalidDate:
            return "존재하지 않는 날짜입니다"
        case .futureDate:
            return "미래 날짜는 입력할 수 없습니다"
        }
    }
    
    var title: String {
        switch self {
        case .emptyYear, .emptyMonth, .emptyDay:
            return "입력 필요"
        case .invalidYearFormat, .invalidMonthFormat, .invalidDayFormat:
            return "형식 오류"
        case .yearOutOfRange, .monthOutOfRange, .dayOutOfRange:
            return "범위 오류"
        case .invalidDate:
            return "잘못된 날짜"
        case .futureDate:
            return "날짜 오류"
        }
    }
}

final class BirthDayViewController: UIViewController {
    private let yearTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "년도를 입력해주세요"
        textField.borderStyle = .roundedRect
        return textField
    }()
    private let yearLabel: UILabel = {
        let label = UILabel()
        label.text = "년"
        return label
    }()
    private let monthTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "월을 입력해주세요"
        textField.borderStyle = .roundedRect
        return textField
    }()
    private let monthLabel: UILabel = {
        let label = UILabel()
        label.text = "월"
        return label
    }()
    private let dayTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "일을 입력해주세요"
        textField.borderStyle = .roundedRect
        return textField
    }()
    private let dayLabel: UILabel = {
        let label = UILabel()
        label.text = "일"
        return label
    }()
    private let resultButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.setTitle( "클릭", for: .normal)
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
        view.addSubview(yearTextField)
        view.addSubview(yearLabel)
        view.addSubview(monthTextField)
        view.addSubview(monthLabel)
        view.addSubview(dayTextField)
        view.addSubview(dayLabel)
        view.addSubview(resultButton)
        view.addSubview(resultLabel)
    }
    
    private func configureLayout() {
        yearTextField.snp.makeConstraints { make in
            make.top.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.width.equalTo(200)
            make.height.equalTo(44)
        }
        
        yearLabel.snp.makeConstraints { make in
            make.centerY.equalTo(yearTextField)
            make.leading.equalTo(yearTextField.snp.trailing).offset(12)
        }
        
        monthTextField.snp.makeConstraints { make in
            make.top.equalTo(yearTextField.snp.bottom).offset(20)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.width.equalTo(200)
            make.height.equalTo(44)
        }
        
        monthLabel.snp.makeConstraints { make in
            make.centerY.equalTo(monthTextField)
            make.leading.equalTo(monthTextField.snp.trailing).offset(12)
        }
        
        dayTextField.snp.makeConstraints { make in
            make.top.equalTo(monthTextField.snp.bottom).offset(20)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.width.equalTo(200)
            make.height.equalTo(44)
        }
        
        dayLabel.snp.makeConstraints { make in
            make.centerY.equalTo(dayTextField)
            make.leading.equalTo(dayTextField.snp.trailing).offset(12)
        }
        
        resultButton.snp.makeConstraints { make in
            make.top.equalTo(dayTextField.snp.bottom).offset(20)
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
    
    private func validateDateInputs() throws(BirthDateError) -> Date {
        let currentYear = Calendar.current.component(.year, from: Date())
        
        guard let yearText = yearTextField.text, !yearText.isEmpty else {
            throw .emptyYear
        }
        
        guard let year = Int(yearText) else {
            throw .invalidYearFormat
        }
        
        guard year >= 1900 && year <= currentYear else {
            throw .yearOutOfRange
        }
        
        guard let monthText = monthTextField.text, !monthText.isEmpty else {
            throw .emptyMonth
        }
        
        guard let month = Int(monthText) else {
            throw .invalidMonthFormat
        }
        
        guard month >= 1 && month <= 12 else {
            throw .monthOutOfRange
        }
        
        guard let dayText = dayTextField.text, !dayText.isEmpty else {
            throw .emptyDay
        }
        
        guard let day = Int(dayText) else {
            throw .invalidDayFormat
        }
        
        guard day >= 1 && day <= 31 else {
            throw .dayOutOfRange
        }
        
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        
        guard let birthDate = Calendar.current.date(from: dateComponents) else {
            throw .invalidDate
        }
        
        let selectedYear = Calendar.current.component(.year, from: birthDate)
        let selectedMonth = Calendar.current.component(.month, from: birthDate)
        let selectedDay = Calendar.current.component(.day, from: birthDate)
        
        if selectedYear != year || selectedMonth != month || selectedDay != day {
            throw.invalidDate
        }

        guard birthDate <= Date() else {
            throw .futureDate
        }
        
        return birthDate
    }
    
    private func calculateDaysFromBirth(birthDate: Date) -> Int {
        let components = Calendar.current.dateComponents([.day], from: birthDate, to: Date())
        return components.day ?? 0
    }
    
    private func showErrorAlert(error: BirthDateError) {
        let alert = UIAlertController(title: error.title, message: error.description, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default))
        present(alert, animated: true)
    }
    
    @objc func resultButtonTapped() {
        view.endEditing(true)
        
        do {
            let result = try validateDateInputs()
            resultLabel.text = "D + \(calculateDaysFromBirth(birthDate: result))일째 입니다"
        } catch {
            showErrorAlert(error: error)
        }
    }
}
