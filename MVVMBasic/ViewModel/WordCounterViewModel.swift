//
//  WordCounterViewModel.swift
//  MVVMBasic
//
//  Created by Jimin on 8/9/25.
//

import Foundation

final class WordCounterViewModel {
    var count: Int?
    
    func updateCount() -> String {
        guard let count else { return "글자를 입력하세요" }
        return "현재까지 \(count)글자 작성중"
    }
}
