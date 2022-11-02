//
//  Book.swift
//  BookStore
//
//  Created by Jaeyong Lee on 2022/11/02.
//

import UIKit

struct Book: Hashable, Codable {
    let name: String
    let price: Int
    let publishedAt: String
    let category: Category
    let imageName: String?

    enum Category: String, Codable {
        case sosal = "소설"
        case tech = "기술"
        case economy = "경제"
        case poem = "시집"
    }
}

extension Book {
    static let dummies: [Book] = [
        .init(name: "해리포터1", price: 32000, publishedAt: "2021년 2월 1일", category: .sosal, imageName: "img_hp1"),
        .init(name: "난중일기", price: 23000, publishedAt: "2022년 10월 21일", category: .sosal, imageName: "img_hp2"),
        .init(name: "테스트 코드 작성법", price: 78000, publishedAt: "2022년 11월 2일", category: .tech, imageName: "img_hp3")
    ]
}
