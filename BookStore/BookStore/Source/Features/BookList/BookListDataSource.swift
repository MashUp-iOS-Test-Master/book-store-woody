//
//  BookListDataSource.swift
//  BookStore
//
//  Created by Jaeyong Lee on 2022/11/02.
//

import UIKit

enum BookListSection: Hashable {
    case list([Book])
}

final class BookListDiffableDataSource: UITableViewDiffableDataSource<BookListSection, Book> {

    init(tableView: UITableView) {

        super.init(tableView: tableView) { tableView, indexPath, itemIdentifier in
            let cell = tableView.dequeueReusableCell(BookTableViewCell.self, for: indexPath)
            cell.configure(with: itemIdentifier)
            return cell
        }
    }
}
