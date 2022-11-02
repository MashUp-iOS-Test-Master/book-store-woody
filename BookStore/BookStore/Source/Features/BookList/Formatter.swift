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
}
