//
//  BookListViewModelTests.swift
//  BookStoreTests
//
//  Created by Jaeyong Lee on 2022/11/04.
//

import XCTest
import Combine
@testable import BookStore

final class BookListViewModelTests: XCTestCase {

    private var cancellables: Set<AnyCancellable>!

    var sut: BookListViewModel!
    var mockBookLocalStorage: MockBookLocalStorage!

    override func setUp() {
        super.setUp()
        cancellables = []
    }

    func testBookListViewModel_초기화합니다() {
        // when
        sut = BookListViewModel()

        // then
        XCTAssertEqual(sut.bookList, [])
        XCTAssertEqual(sut.totalPrice, 0)
    }

    func testBookListViewModel_책목록을_불러옵니다() {
        // given
        mockBookLocalStorage = MockBookLocalStorage(success: true)
        sut = BookListViewModel(bookLocalStorage: mockBookLocalStorage)
        let bookList = BookFactory.createBookList()

        // when
        sut.requestBookList()
        mockBookLocalStorage.getReadCompletion(bookList)

        // then
        XCTAssertEqual(mockBookLocalStorage.readCallCount, 1) // 클로저가 실행이 되는지에 대한 테스트
        XCTAssertEqual(bookList, self.sut.bookList) // 파라미터를 클로저에 잘 전달하는지에 대한 테스트

    }


    func testBookListViewModel_책목록을_불러와_가격을_계산합니다() {
        // given
        mockBookLocalStorage = MockBookLocalStorage(success: true)
        sut = BookListViewModel(bookLocalStorage: mockBookLocalStorage)
        let bookList = BookFactory.createBookList()
        let totalPrice = 20000

        // when
        sut.bookList = bookList

        // then
        XCTAssertEqual(totalPrice, sut.totalPrice) // 책목록에 따라 책 가격의 총 합계을 계산하는 로직에 대한 테스트
    }

    func testBookListViewModel_책목록중_책하나를_선택합니다() {
        // given
        sut = BookListViewModel()
        let category: Book.Category = .tech
        let selectCategoryExpectation = XCTestExpectation(description: "책 하나 선택하기")

        // when
        // then
        sut.selectedCategoryPublisher
            .compactMap { $0 }
            .sink { cat in
                selectCategoryExpectation.fulfill()
                XCTAssertEqual(category, cat)
            }
            .store(in: &cancellables)

        sut.selectCell(category: category)
    }
}
