//
//  MockBookLocalStorage.swift
//  BookStoreTests
//
//  Created by Jaeyong Lee on 2022/11/03.
//

import Foundation
@testable import BookStore

final class SpyBookLocalStorage: BookLocalStorage {

    var storage: [Book] = []
    var success: Bool

    init(success: Bool) {
        self.success = success
    }

    func store(_ book: BookStore.Book) -> Bool {
        if success {
            storage.append(book)
            return true
        } else {
            return false
        }
    }

    func read() -> [BookStore.Book]? {
        return storage
    }

    func remove(_ book: BookStore.Book) -> Bool {
        if success {
            if let firstIndex = storage.firstIndex(of: book) {
                storage.remove(at: firstIndex)
                return true
            }
            return false
        } else {
            return false
        }
    }
}
