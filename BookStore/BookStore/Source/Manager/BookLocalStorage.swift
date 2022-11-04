//
//  BookLocalStorage.swift
//  BookStore
//
//  Created by Jaeyong Lee on 2022/11/03.
//

import Foundation

protocol BookLocalStorage {
    func store(_ book: Book) -> Bool
    func read(completion: @escaping ([Book]?) -> Void)
    func remove(_ book: Book) -> Bool
}

final class BookLocalStorageImpl: BookLocalStorage {
    let localStorage: LocalStorage
    let key: UserDefaultsKey

    init(localStorage: LocalStorage = UserDefaults.standard) {
        self.localStorage = localStorage
        self.key = .books
    }

    func store(_ book: Book) -> Bool {
        let currentBooks = localStorage.read(key: key, type: [Book].self) ?? []
        return localStorage.store(data: currentBooks + [book], key: key)
    }

    func read(completion: @escaping ([Book]?) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
            guard let self = self else { return }
            completion(self.localStorage.read(key: self.key, type: [Book].self))
        }
    }

    func remove(_ book: Book) -> Bool {
        guard var current = self.localStorage.read(key: key, type: [Book].self) else { return false }
        
        if let firstIndex = current.firstIndex(of: book) {
            current.remove(at: firstIndex)
            return self.storeBooks(current)
        }
        return false
    }

    private func storeBooks(_ books: [Book]) -> Bool {
        localStorage.store(data: books, key: key)
    }
}
