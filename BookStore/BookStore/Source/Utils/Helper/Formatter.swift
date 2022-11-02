//
//  Formatter.swift
//  BookStore
//
//  Created by Jaeyong Lee on 2022/11/02.
//

import Foundation

struct Formatter {
    static let amountFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()

    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeZone = NSTimeZone.local
        formatter.dateFormat = "YYYY년 MM월 dd일"
        return formatter
    }()
}
