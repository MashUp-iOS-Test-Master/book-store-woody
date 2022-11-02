//
//  BookListDataSource.swift
//  BookStore
//
//  Created by Jaeyong Lee on 2022/11/02.
//

import UIKit

enum BookItem: Hashable {
    case book(Book)
    case empty
}

enum BookListSection: Hashable {
    typealias Item = BookItem
    case list([Item])
    case empty
}

final class BookListDiffableDataSource: UITableViewDiffableDataSource<BookListSection, BookListSection.Item> {

    init(tableView: UITableView) {

        super.init(tableView: tableView) { tableView, indexPath, itemIdentifier in
            switch itemIdentifier {
            case .empty:
                let cell = tableView.dequeueReusableCell(EmptyBookTableViewCell.self, for: indexPath)
                return cell
            case .book(let model):
                let cell = tableView.dequeueReusableCell(BookTableViewCell.self, for: indexPath)
                cell.configure(with: model)
                return cell
            }

        }
    }
}
