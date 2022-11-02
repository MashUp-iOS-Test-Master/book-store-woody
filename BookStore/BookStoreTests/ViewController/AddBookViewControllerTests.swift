//
//  AddBookViewControllerTests.swift
//  BookStoreTests
//
//  Created by Jaeyong Lee on 2022/11/03.
//

import XCTest
@testable import BookStore

final class AddBookViewControllerTests: XCTestCase {

    var sut: AddBookBusinessLogic!
    var mockLocalStorage: MockLocalStorage!

    override func setUp() {
        super.setUp()

        mockLocalStorage = MockLocalStorage()
        sut = AddBookViewController(localStorage: mockLocalStorage)
    }

    override func tearDown() {
        super.tearDown()

        sut = nil
    }

    func testAddBookViewController_책을_저장합니다() {
        sut.storeBook()

        mockLocalStorage.storage
    }
}
