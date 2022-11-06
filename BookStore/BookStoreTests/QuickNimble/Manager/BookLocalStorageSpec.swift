//
//  BookLocalStorageSpec.swift
//  BookStoreTests
//
//  Created by Jaeyong Lee on 2022/11/06.
//

import Quick
import Nimble
@testable import BookStore
import Dispatch

final class BookLocalStorageSpec: QuickSpec {

    override func spec() {

        describe("책을") {
            var spyLocalStorage: SpyLocalStorage!
            var bookStorage: BookLocalStorage!
            beforeEach {
                spyLocalStorage = SpyLocalStorage()
                bookStorage = BookLocalStorageImpl(localStorage: spyLocalStorage)
            }
            describe("저장할 때,") {
                var newBook: Book!
                beforeEach {
                    newBook = BookFactory.createBook()
                }
                context("한 권 저장하면") {
                    it("저장됩니다") {
                        expect(bookStorage.store(newBook)).to(beTrue())
                        expect(spyLocalStorage.bookList).to(contain(newBook))
                        expect(spyLocalStorage.storeCallCount).to(equal(1))
                    }
                }
            }
            describe("불러올 때,") {
                var bookList: [Book]!
                beforeEach {
                    bookList = BookFactory.createBookList()
                }
                // MARK: 방법 1 : waitUntil
                context("여러 책을 저장한 상황 ") {
                    beforeEach {
                        spyLocalStorage.bookList = bookList
                    }
                    it("여러 책을 불러옵니다.") {

                        await waitUntil(timeout: .seconds(2)) { done in
                            bookStorage.read { books in
                                expect(books).to(equal(bookList))
                                done()
                            }
                        }
                    }
                }
                // MARK: 방법 2 : toEventually
                context("여러 책을 저장한 상황 ") {
                    beforeEach {
                        spyLocalStorage.bookList = bookList
                    }
                    it("여러 책을 불러옵니다.") {
                        var books: [Book] = []
                        bookStorage.read { booksParam in
                            books = booksParam!
                        }
                        expect(books).toEventually(equal(bookList), timeout: .seconds(2))
                    }
                }
            }
            describe("제거할 때,") {
                context("제거할 책이 저장되어 있다면") {
                    var bookList: [Book]!
                    var bookTarget: Book!
                    beforeEach {
                        bookTarget = BookFactory.createBook()
                        bookList = BookFactory.createBookList()
                        spyLocalStorage.bookList = bookList + [bookTarget]
                    }
                    it("책 제거를 성공합니다") {
                        expect(bookStorage.remove(bookTarget)).to(beTrue())
                        expect(spyLocalStorage.bookList).notTo(contain(bookTarget))
                    }
                }
                context("제거할 책이 저장되어 있지 않다면") {
                    var bookList: [Book]!
                    var bookTarget: Book!
                    beforeEach {
                        bookTarget = BookFactory.createBook()
                        bookList = BookFactory.createBookList()
                        spyLocalStorage.bookList = bookList
                    }
                    it("책 제거를 성공합니다") {
                        expect(bookStorage.remove(bookTarget)).to(beFalse())
                        expect(spyLocalStorage.bookList).to(equal(bookList))
                    }
                }
            }
        }
    }
}
