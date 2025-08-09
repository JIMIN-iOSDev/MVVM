//
//  BirthDayViewModel.swift
//  MVVMBasic
//
//  Created by Jimin on 8/10/25.
//

import Foundation

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

class BirthDayViewModel {
    
    var yearText: String?
    var monthText: String?
    var dayText: String?
    
    private func validateDateInputs() throws(BirthDateError) -> Date {
        let currentYear = Calendar.current.component(.year, from: Date())
        
        guard let yearText, !yearText.isEmpty else {
            throw .emptyYear
        }
        
        guard let year = Int(yearText) else {
            throw .invalidYearFormat
        }
        
        guard year >= 1900 && year <= currentYear else {
            throw .yearOutOfRange
        }
        
        guard let monthText, !monthText.isEmpty else {
            throw .emptyMonth
        }
        
        guard let month = Int(monthText) else {
            throw .invalidMonthFormat
        }
        
        guard month >= 1 && month <= 12 else {
            throw .monthOutOfRange
        }
        
        guard let dayText, !dayText.isEmpty else {
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
    
    func resultText() -> Result<String, BirthDateError> {
        do {
            let result = try validateDateInputs()
            return .success("D + \(calculateDaysFromBirth(birthDate: result)) 일째 입니다")
        } catch {
            return .failure(error)
        }
    }
}
