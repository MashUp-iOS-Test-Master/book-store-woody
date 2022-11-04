//
//  AddBookViewModelTests.swift
//  BookStoreTests
//
//  Created by Jaeyong Lee on 2022/11/03.
//

import XCTest
@testable import BookStore

final class AddBookViewModelTests: XCTestCase {

    var sut: AddBookViewModel!
    var bookLocalStorageSpy: SpyBookLocalStorage!
    var newBook: AddBookNewBookModel!

    override func setUp() {
        super.setUp()
        sut = createAddBookViewModel(success: true)
    }

    override func tearDown() {
        newBook = nil
        bookLocalStorageSpy = nil
        sut = nil
        super.tearDown()
    }

    func testAddBookViewModel_책의_기본값들과함께_초기화합니다() {
        // given
        let newBook = BookFactory.createNewBook()

        // when
        sut = AddBookViewModel(
            name: newBook.name,
            category: newBook.category,
            publishedAt: newBook.publishedAt,
            price: newBook.price
        )

        // then
        XCTAssertEqual(sut.getBookName(), newBook.name)
        XCTAssertEqual(sut.getBookCategory(), newBook.category)
        XCTAssertEqual(sut.getBookPrice(), newBook.price)
        XCTAssertEqual(sut.getBookPublishedAt(), newBook.publishedAt)
    }

    func testAddBookViewModel_책생성을_성공합니다() {
        // when
        guard let newBook = sut.addBook() else { fatalError() }

        // then
        XCTAssertTrue(sut.bookLocalStorage.read()!.contains(newBook))
    }

    func testAddBookViewModel_책생성을_디비쪽문제로_실패합니다() {
        // given
        sut = createAddBookViewModel(success: false)

        // when
        let newBook = sut.addBook()

        // then
        XCTAssertNil(newBook)
    }

    func testAddBookViewModel_이름이_비어있다면_책생성을_실패합니다() {
        newBook = BookFactory.createNoNameBook()
        sut = AddBookViewModel(
            name: newBook.name,
            category: newBook.category,
            publishedAt: newBook.publishedAt,
            price: newBook.price,
            bookLocalStorage: bookLocalStorageSpy
        )
        let newBook = sut.addBook()
        XCTAssertNil(newBook)
    }

    func testAddBookViewModel_출판일을_수정합니다() {
        // given
        let dateString =  "2022년 11월 04일"
        guard let date = Formatter.dateFormatter.date(from: dateString) else { fatalError() }

        // when
        sut.updatePublishedAt(selectedDate: date)

        // then
        XCTAssertEqual(sut.getBookPublishedAt(), dateString)
    }

    func testAddBookViewModel_가격을_수정합니다() {
        // given
        let priceString = "12,000"

        // when
        sut.updatePrice(to: priceString)

        // then
        XCTAssertEqual(sut.getBookPrice(), priceString)
    }

    private func createAddBookViewModel(success: Bool) -> AddBookViewModel {
        newBook = BookFactory.createNewBook()
        bookLocalStorageSpy = SpyBookLocalStorage(success: success)
        return AddBookViewModel(
            name: newBook.name,
            category: newBook.category,
            publishedAt: newBook.publishedAt,
            price: newBook.price,
            bookLocalStorage: bookLocalStorageSpy
        )
    }
}
