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
    var mockBookLocalStorage: MockBookLocalStorage!
    var newBook: Book!

    override func setUp() {
        super.setUp()
        sut = createAddBookViewModel(success: true)
    }

    override func tearDown() {
        newBook = nil
        mockBookLocalStorage = nil
        sut = nil
        super.tearDown()
    }

    func testAddBookViewModel_책의_기본값들과함께_초기화합니다() {
        // when
        let newBook = BookFactory.createBook()
        sut = AddBookViewModel(
            name: newBook.name,
            category: newBook.category,
            publishedAt: newBook.publishedAt,
            price: newBook.price
        )

        // then
        XCTAssertEqual(sut.getBookName(), newBook.name) // 책 이름 기본값이 맞는지
        XCTAssertEqual(sut.getBookCategory(), newBook.category) // 책 카테고리 기본값이 맞는지
        XCTAssertEqual(sut.getBookPrice(), newBook.price) // 책 가격 기본값이 맞는지
        XCTAssertEqual(sut.getBookPublishedAt(), newBook.publishedAt) // 책 출판일이 맞는지
    }

    func testAddBookViewModel_책생성을_성공합니다() {
        // when
        let result = sut.addBook()

        // then
        XCTAssertEqual(mockBookLocalStorage.storeCallCount, 1) // 책추가를 할 때 store 메소드가 불립니다.
        XCTAssertNotNil(result) // 책추가를 성공했다면 Nil이면 안됩니다.
    }

    func testAddBookViewModel_책생성을_디비쪽문제로_실패합니다() {
        // given
        sut = createAddBookViewModel(success: false)

        // when
        let result = sut.addBook()

        // then
        XCTAssertEqual(mockBookLocalStorage.storeCallCount, 1) // 책추가를 할 때 store 메소드가 불립니다.
        XCTAssertNil(result) // 책추가를 실패했다면 Nil이 반환됩니다.
    }

    func testAddBookViewModel_이름이_비어있다면_책생성을_실패합니다() {
        // given
        newBook = BookFactory.createNoNameBook()
        sut = AddBookViewModel(
            name: newBook.name,
            category: newBook.category,
            publishedAt: newBook.publishedAt,
            price: newBook.price,
            bookLocalStorage: mockBookLocalStorage
        )

        // when
        let newBook = sut.addBook()

        // then
        XCTAssertEqual(mockBookLocalStorage.storeCallCount, 0) // 로컬 디비 매니저 메소드를 불리기도 전에 반환됩니다.
        XCTAssertNil(newBook) // 책 추가를 실패했으니 Nil이 반환됩니다
    }

    func testAddBookViewModel_출판일을_수정합니다() {
        // given
        let dateString =  "2022년 11월 04일"
        guard let date = Formatter.dateFormatter.date(from: dateString) else {
            fatalError()
        }

        // when
        sut.updatePublishedAt(selectedDate: date)

        // then
        XCTAssertEqual(sut.getBookPublishedAt(), dateString) // datePicker에서 값을 수정할 경우 DateFormatter가 작동합니다.
    }

    func testAddBookViewModel_가격을_수정합니다() {
        // given
        let priceString = "12,000"
        let price: Int = 12000
        // when
        sut.updatePrice(to: priceString)

        // then
        XCTAssertEqual(sut.getBookPrice(), price) // 가격을 수정할 경우 , 형태의 NumberFormatter가 작동합니다.
    }

    private func createAddBookViewModel(success: Bool) -> AddBookViewModel {
        newBook = BookFactory.createBook()
        mockBookLocalStorage = MockBookLocalStorage(success: success)
        return AddBookViewModel(
            name: newBook.name,
            category: newBook.category,
            publishedAt: newBook.publishedAt,
            price: newBook.price,
            bookLocalStorage: mockBookLocalStorage
        )
    }
}
