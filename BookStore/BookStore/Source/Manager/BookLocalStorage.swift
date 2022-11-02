//
//  BookLocalStorage.swift
//  BookStore
//
//  Created by Jaeyong Lee on 2022/11/03.
//

import Foundation

protocol BookLocalStorage {
    func store(data: [Book]) -> Bool
    func read() -> [Book]?
    func remove(data: Book) -> Bool
}

final class BookLocalStorageImpl: BookLocalStorage {
    let localStorage: LocalStorage
    let key: UserDefaultsKey

    init(localStorage: LocalStorage = UserDefaults.standard) {
        self.localStorage = localStorage
        self.key = .books
    }

    func store(data: [Book]) -> Bool {
        print(data)
        return localStorage.store(data: data, key: key)
    }

    func read() -> [Book]? {
        localStorage.read(key: key, type: [Book].self)
    }

    func remove(data: Book) -> Bool {
        guard var stored = self.read() else { return false }

        if let firstIndex = stored.firstIndex(of: data) {
            stored.remove(at: firstIndex)
            return self.store(data: stored)
        }

        return false
    }
}
