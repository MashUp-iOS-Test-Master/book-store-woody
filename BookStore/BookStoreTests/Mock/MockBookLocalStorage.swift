//
//  MockBookLocalStorage.swift
//  BookStoreTests
//
//  Created by Jaeyong Lee on 2022/11/03.
//

import Foundation
@testable import BookStore

final class MockBookLocalStorage: BookLocalStorage {

    var success: Bool
    var getReadCompletion: (([Book]?) -> Void)!

    init(success: Bool) {
        self.success = success
    }

    var storeCallCount: Int = 0
    func store(_ book: BookStore.Book) -> Bool {
        storeCallCount += 1
        return success
    }

    var readCallCount: Int = 0
    func read(completion: @escaping ([Book]?) -> Void) {
        readCallCount += 1
        getReadCompletion = completion
        return
    }

    var getRemoveCallCount: Int = 0
    func remove(_ book: BookStore.Book) -> Bool {
        getRemoveCallCount += 1
        return success
    }
}
