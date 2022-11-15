//
//  BookListViewModel.swift
//  BookStore
//
//  Created by Jaeyong Lee on 2022/11/04.
//

import Foundation
import Combine

protocol BookListBusinessLogic {
    var bookListPublisher: Published<[Book]>.Publisher { get }
    var totalPricePublisher: Published<Int>.Publisher { get }

    func requestBookList()
    func removeBook(book: Book) -> Bool
}

final class BookListViewModel: BaseViewModel, BookListBusinessLogic {
    let bookLocalStorage: BookLocalStorage

    @Published var bookList: [Book]
    @Published var totalPrice: Int

    var bookListPublisher: Published<[Book]>.Publisher { $bookList }
    var totalPricePublisher: Published<Int>.Publisher { $totalPrice }

    init(
        bookList: [Book] = [],
        totalPrice: Int = 0,
        bookLocalStorage: BookLocalStorage = BookLocalStorageImpl()
    ) {
        self.bookList = bookList
        self.totalPrice = totalPrice
        self.bookLocalStorage = bookLocalStorage
        super.init()

        $bookList
            .sink { [weak self] books in
                guard let self = self else { return }
                self.totalPrice = self.calculateTotalPrice(bookList: books)
            }
            .store(in: &cancellables)
    }

    func requestBookList() {
        bookLocalStorage.read { [weak self] bookList in
            self?.bookList = bookList ?? []
        }
    }

    func removeBook(book: Book) -> Bool {
        return bookLocalStorage.remove(book)
    }

    private func calculateTotalPrice(bookList: [Book]) -> Int {
        bookList.reduce(0) { partialResult, book in
            return partialResult + book.price
        }
    }
}
