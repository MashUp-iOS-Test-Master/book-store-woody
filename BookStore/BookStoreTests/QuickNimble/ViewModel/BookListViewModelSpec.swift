//
//  BookListViewModelSpec.swift
//  BookStoreTests
//
//  Created by Jaeyong Lee on 2022/11/06.
//

import Quick
import Nimble
@testable import BookStore

final class BookListViewModelSpec: QuickSpec {

    override func spec() {

        describe("책 목록을 불러오는 상황에서") {
            var bookList: [Book]!
            var mockBookLocalStorage: MockBookLocalStorage!
            var bookListViewModel: BookListViewModel!

            beforeEach {
                bookList = BookFactory.createBookList()
                mockBookLocalStorage = MockBookLocalStorage(success: true)
                bookListViewModel = BookListViewModel(bookLocalStorage: mockBookLocalStorage)
            }

            it("책 목록을 불러옵니다") {
                bookListViewModel.requestBookList()
                mockBookLocalStorage.getReadCompletion(bookList)

                expect(bookListViewModel.bookList).to(equal(bookList))
            }

            it("책 목록이 불러와지면 가격을 계산합니다") {
                let price = 20000
                bookListViewModel.bookList = bookList
                expect(bookListViewModel.totalPrice).to(equal(price))
            }
        }
    }
}
