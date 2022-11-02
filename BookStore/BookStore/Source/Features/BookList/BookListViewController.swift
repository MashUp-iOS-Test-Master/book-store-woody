//
//  BookListViewController.swift
//  BookStore
//
//  Created by Jaeyong Lee on 2022/11/02.
//

import UIKit
import SnapKit

final class BookListViewController: BaseViewController {

    lazy var bookListDataSource = BookListDiffableDataSource(tableView: bookListTableView)
    lazy var bookListTableView = UITableView()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        applySnapShot(section: [.list(Book.dummies)])
    }

    override func setAttribute() {
        super.setAttribute()

        setNavigationBar()
        setBookListTableView()
    }

    override func setLayout() {
        super.setLayout()

        view.addSubview(bookListTableView)

        bookListTableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }

    func applySnapShot(section: [BookListSection]) {
        var snapshot = NSDiffableDataSourceSnapshot<BookListSection, Book>()
        snapshot.appendSections(section)
        section.forEach { section in
            switch section {
            case .list(let models):
                snapshot.appendItems(models)
            }
        }
        self.bookListDataSource.apply(snapshot, animatingDifferences: true)
    }

    private func setNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .blue
        appearance.titleTextAttributes = [
            NSAttributedString.Key.font: UIFont.gmarksans(weight: .bold, size: 17),
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
        appearance.shadowColor = .clear
        self.navigationController?.navigationBar.standardAppearance = appearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationItem.backButtonTitle = ""
        navigationItem.title = "책 목록"
        navigationController?.navigationBar.tintColor = .white
    }

    private func setBookListTableView() {
        bookListTableView.allowsSelection = true
        bookListTableView.allowsMultipleSelection = false
        bookListTableView.delegate = self
        bookListTableView.dataSource = bookListDataSource
        bookListTableView.register(BookTableViewCell.self)
        bookListTableView.separatorStyle = .none
    }
}

extension BookListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
