//
//  BookLocalStorageTests.swift
//  BookStoreTests
//
//  Created by Jaeyong Lee on 2022/11/04.
//

import XCTest
@testable import BookStore

final class BookLocalStorageTests: XCTestCase {

    var spyLocalStorage: SpyLocalStorage!
    var sut: BookLocalStorage!

    override func setUp() {
        super.setUp()

        spyLocalStorage = SpyLocalStorage()
        sut = BookLocalStorageImpl(localStorage: spyLocalStorage)
    }

    override func tearDown() {
        spyLocalStorage = nil
        sut = nil
        super.tearDown()
    }

    func testBookLocalStorage_책을_저장합니다() {
        // given
        let newBook = BookFactory.createBook()
        
        // when
        let result = sut.store(newBook)

        // then
        XCTAssertTrue(result)
        XCTAssertEqual(spyLocalStorage.storeCallCount, 1)
    }

    func testBookLocalStorage_책목록을_불러옵니다() {
        // given
        let readExpectation = XCTestExpectation(description: "책 목록 불러오기")
        let bookList = BookFactory.createBookList()

        // when
        // then
        sut.read { books in
            readExpectation.fulfill()
            XCTAssertEqual(bookList, books)
        }
        spyLocalStorage.bookList = bookList

        wait(for: [readExpectation], timeout: 1.1)
    }

    func testBookLocalStorage_책을_목록에서_제거_성공합니다() {
        // given
        let book = BookFactory.createBook()
        let bookList = BookFactory.createBookList()
        spyLocalStorage.bookList = bookList + [book]

        // when
        let result = sut.remove(book)

        // then
        XCTAssertTrue(result)
        print(bookList)
        print(book)
        XCTAssertEqual(spyLocalStorage.bookList, bookList)
    }

    func testBookLocalStorage_책목록에서_제거할_책이_없어서_제거_실패합니다() {
        // given
        let book = BookFactory.createBook()
        spyLocalStorage.bookList = []

        // when
        let result = sut.remove(book)

        // then
        XCTAssertFalse(result)
        XCTAssertEqual(spyLocalStorage.bookList, [])
    }
}
