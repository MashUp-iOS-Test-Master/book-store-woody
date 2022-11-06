//
//  AddBookViewModelSpec.swift
//  BookStoreTests
//
//  Created by Jaeyong Lee on 2022/11/06.
//

import Quick
import Nimble
@testable import BookStore

final class AddBookViewModelSpec: QuickSpec {

    override func spec() {

        describe("책을 저장하는 버튼을 눌렀을 때,") {
            var newBook: Book!
            var mockBookLocalStorage: MockBookLocalStorage!
            var addBookViewModel: AddBookViewModel!
            beforeEach {
                newBook = BookFactory.createBook()
                mockBookLocalStorage = MockBookLocalStorage(success: true)
                addBookViewModel = AddBookViewModel(
                    name: newBook.name,
                    category: newBook.category,
                    publishedAt: newBook.publishedAt,
                    price: newBook.price,
                    bookLocalStorage: mockBookLocalStorage
                )
            }

            context("책 정보가 잘 작성되어 있다면") {
                it("저장됩니다") {
                    let addBook = addBookViewModel.addBook()
                    expect(addBook).toNot(beNil())
                    expect(mockBookLocalStorage.storeCallCount).to(equal(1))
                }
            }

            context("책 정보가 빠져 있다면") {
                beforeEach {
                    newBook = BookFactory.createNoNameBook()
                    addBookViewModel = AddBookViewModel(
                        name: newBook.name,
                        category: newBook.category,
                        publishedAt: newBook.publishedAt,
                        price: newBook.price,
                        bookLocalStorage: mockBookLocalStorage
                    )
                }
                it("저장되지 않습니다") {
                    let addBook = addBookViewModel.addBook()
                    expect(addBook).to(beNil())
                    expect(mockBookLocalStorage.storeCallCount).to(equal(0))
                }
            }
        }
    }
}
