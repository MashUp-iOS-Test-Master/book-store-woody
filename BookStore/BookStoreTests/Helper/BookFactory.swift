//
//  BookFactory.swift
//  BookStoreTests
//
//  Created by Jaeyong Lee on 2022/11/04.
//

import Foundation
@testable import BookStore

struct BookFactory {
    static func createEmptyBookList() -> [Book] {
        return []
    }

    static func createBookList() -> [Book] {
        return [
            Book(name: "새로운 책", price: 10000, publishedAt: "2022년 10월 2일", category: .sosal, imageName: "ic_empty"),
            Book(name: "새로운 책", price: 10000, publishedAt: "2022년 10월 2일", category: .sosal, imageName: "ic_empty")
        ]
    }

    static func createBook() -> Book {
        return Book(
            name: "새로운 책",
            price: 10000,
            publishedAt: "2022년 10월 2일",
            category: .sosal,
            imageName: "ic_empty"
        )
    }

    static func createNoNameBook() -> Book {
        return Book(
            name: "",
            price: 10000,
            publishedAt: "2022년 10월 2일",
            category: .sosal,
            imageName: "ic_empty"
        )
    }
}
