//
//  BookFactory.swift
//  BookStoreTests
//
//  Created by Jaeyong Lee on 2022/11/04.
//

import Foundation
@testable import BookStore

struct AddBookNewBookModel {
    var name: String
    var category: Book.Category
    var publishedAt: String
    var price: String?
    var imageName: String
}

struct BookFactory {
    static func createNewBook() -> AddBookNewBookModel {
        let newBook = Book(
            name: "새로운 책",
            price: 10000,
            publishedAt: "2022년 10월 2일",
            category: .sosal,
            imageName: "ic_empty"
        )

        return .init(
            name: newBook.name,
            category: newBook.category,
            publishedAt: newBook.publishedAt,
            price: Formatter.amountFormatter.string(from: NSNumber(value: newBook.price)),
            imageName: newBook.imageName
        )
    }
}
