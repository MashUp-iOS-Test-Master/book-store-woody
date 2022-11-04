//
//  AddBookViewModel.swift
//  BookStore
//
//  Created by Jaeyong Lee on 2022/11/03.
//

import Foundation
import Combine

protocol AddBookBusinessLogic {
    var publishedAtPublisher: Published<String>.Publisher { get }
    var pricePublisher: Published<String?>.Publisher { get }

    func updateBookName(to name: String)
    func updateCategory(selectedIndex: Int)
    func updatePublishedAt(selectedDate: Date)
    func updatePrice(to price: String)
    func addBook() -> Book?
}

final class AddBookViewModel: BaseViewModel, AddBookBusinessLogic {
    static let categories: [Book.Category] = [.sosal, .tech, .economy, .poem]

    private var name: String
    private var category: Book.Category
    @Published var publishedAt: String
    @Published var price: String?

    var publishedAtPublisher: Published<String>.Publisher { $publishedAt }
    var pricePublisher: Published<String?>.Publisher { $price }

    let bookLocalStorage: BookLocalStorage

    init(
        name: String = .init(),
        category: Book.Category = .sosal,
        publishedAt: String = Formatter.dateFormatter.string(from: Date()),
        price: String? = .init(),
        bookLocalStorage: BookLocalStorage = BookLocalStorageImpl()
    ) {
        self.bookLocalStorage = bookLocalStorage
        self.name = name
        self.category = category
        self.publishedAt = publishedAt
        self.price = price
    }

    // MARK: - 비즈니스 로직

    func addBook() -> Book? {
        guard name.isEmpty == false,
              let price = price,
              let price = getPrice(price) else { return nil }

        let newBook = Book(
            name: name,
            price: price,
            publishedAt: publishedAt,
            category: category,
            imageName: "ic_empty"
        )

        if bookLocalStorage.store(newBook) {
            return newBook
        }
        return nil
    }

    private func getPrice(_ price: String) -> Int? {
        let convertedPrice = price.replacingOccurrences(of: ",", with: "")
        return Formatter.amountFormatter.number(from: convertedPrice) as? Int
    }

    func updateBookName(to name: String) {
        self.name = name
    }

    func updateCategory(selectedIndex: Int) {
        self.category = Self.categories[selectedIndex]
    }

    func updatePublishedAt(selectedDate: Date) {
        self.publishedAt = Formatter.dateFormatter.string(from: selectedDate)
    }

    func updatePrice(to price: String) {
        guard let price = getPrice(price) else {
            return
        }
        self.price = Formatter.amountFormatter.string(from: NSNumber(value: price))
    }
}

extension AddBookViewModel {

    func getBookName() -> String {
        name
    }

    func getBookPrice() -> String? {
        price
    }

    func getBookCategory() -> Book.Category {
        category
    }

    func getBookPublishedAt() -> String {
        publishedAt
    }
}
