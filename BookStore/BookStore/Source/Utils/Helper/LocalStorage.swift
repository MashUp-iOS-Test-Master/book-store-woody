//
//  LocalStorage.swift
//  BookStore
//
//  Created by Jaeyong Lee on 2022/11/02.
//

import Foundation

enum UserDefaultsKey: String {
    case books = "bookstore_books"
}

protocol LocalStorage {
    func store<T: Encodable>(data: T, key: UserDefaultsKey) -> Bool
    func read<T: Decodable>(key: UserDefaultsKey, type: T.Type) -> T?
}

extension UserDefaults: LocalStorage {

    func store<T>(data: T, key: UserDefaultsKey) -> Bool where T : Encodable {
        do {
            let data = try JSONEncoder().encode(data)
            UserDefaults.standard.set(data, forKey: key.rawValue)
            return true
        } catch {
            return false
        }
    }

    func read<T>(key: UserDefaultsKey, type: T.Type) -> T? where T : Decodable {
        do {
            guard let data = UserDefaults.standard.data(forKey: key.rawValue) else {
                return nil
            }
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            return nil
        }
    }
}
