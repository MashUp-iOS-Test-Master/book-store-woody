//
//  MockLocalStorage.swift
//  BookStoreTests
//
//  Created by Jaeyong Lee on 2022/11/04.
//

import Foundation
@testable import BookStore

final class SpyLocalStorage: LocalStorage {

    var bookList: [Book] = []

    var storeCallCount: Int = 0
    func store<T>(data: T, key: BookStore.UserDefaultsKey) -> Bool where T : Encodable {
        storeCallCount += 1
        bookList = data as! [Book]
        return true
    }

    var readCallCount: Int = 0
    func read<T>(key: BookStore.UserDefaultsKey, type: T.Type) -> T? where T : Decodable {
        readCallCount += 1
        return bookList as! T?
    }
}
