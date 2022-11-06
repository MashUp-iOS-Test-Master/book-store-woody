//
//  BookListViewModel.swift
//  BookStore
//
//  Created by Jaeyong Lee on 2022/11/04.
//

import Foundation
import Combine

protocol BookListBusinessLogic {
    typealias Category = Book.Category

    var bookListPublisher: Published<[Book]>.Publisher { get }
    var totalPricePublisher: Published<Int>.Publisher { get }
    var selectedCategoryPublisher: Published<Category?>.Publisher { get }

    func requestBookList()
    func removeBook(book: Book) -> Bool
    func selectCell(category: Category)
}

final class BookListViewModel: BaseViewModel, BookListBusinessLogic {

    typealias Category = Book.Category

    let bookLocalStorage: BookLocalStorage

    @Published var bookList: [Book]
    @Published var totalPrice: Int
    @Published var selectedCategory: Category?

    var bookListPublisher: Published<[Book]>.Publisher { $bookList }
    var totalPricePublisher: Published<Int>.Publisher { $totalPrice }
    var selectedCategoryPublisher: Published<Category?>.Publisher { $selectedCategory }

    init(
        bookList: [Book] = [],
        totalPrice: Int = 0,
        selectedCategory: Category? = nil,
        bookLocalStorage: BookLocalStorage = BookLocalStorageImpl()
    ) {
        self.bookList = bookList
        self.totalPrice = totalPrice
        self.selectedCategory = selectedCategory
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

    func selectCell(category: Category) {
        self.selectedCategory = category
    }
}
