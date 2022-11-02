//
//  MockLocalStorage.swift
//  BookStoreTests
//
//  Created by Jaeyong Lee on 2022/11/03.
//

import Foundation
@testable import BookStore

final class MockLocalStorage: LocalStorage {

    var storage: [String: [Any]]

    init() {
        self.storage = [:]
    }

    func store<T>(data: T, key: BookStore.UserDefaultsKey) -> Bool where T : Encodable {
        storage[key.rawValue, default: []].append(data)
        return true
    }

    func read<T>(key: BookStore.UserDefaultsKey, type: T.Type) -> T? where T : Decodable {
        guard let data = storage[key.rawValue, default: []] as? T else { return nil }
        return data
    }
}
