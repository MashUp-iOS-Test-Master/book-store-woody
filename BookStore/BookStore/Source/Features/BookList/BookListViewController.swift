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
    lazy var activityIndicator = UIActivityIndicatorView()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        requestBookList()
    }

    override func setAttribute() {
        super.setAttribute()

        setNavigationBar()
        setBookListTableView()
        setActivityIndicator()
    }

    override func setLayout() {
        super.setLayout()

        view.addSubview(bookListTableView)
        view.addSubview(activityIndicator)

        bookListTableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.bottom.equalToSuperview()
        }
        activityIndicator.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }

    func requestBookList() {
        activityIndicator.startAnimating()
        DispatchQueue.main.asyncAfter(deadline: .now()+1.0) { [weak self] in
            if let books = UserDefaults.standard.read(key: .books, type: [Book].self){
                print(books)
                self?.applySnapShot(section: [.list(books.map { .book($0) })])
            } else {
                self?.applySnapShot(section: [.empty])
            }
            self?.activityIndicator.stopAnimating()
        }
    }

    func applySnapShot(section: [BookListSection]) {
        var snapshot = NSDiffableDataSourceSnapshot<BookListSection, BookListSection.Item>()
        snapshot.appendSections(section)
        section.forEach { section in
            switch section {
            case .list(let models):
                snapshot.appendItems(models)
            case .empty:
                snapshot.appendItems([.empty])
            }
        }
        self.bookListDataSource.apply(snapshot, animatingDifferences: false)
    }

    @objc func addBook() {
        let addBookViewController = AddBookViewController()
        let navigationController = UINavigationController()
        navigationController.setViewControllers([addBookViewController], animated: false)
        navigationController.modalPresentationStyle = .fullScreen
        self.present(navigationController, animated: true)
    }
}

// MARK: - UI

extension BookListViewController {

    private func setBookListTableView() {
        bookListTableView.allowsSelection = true
        bookListTableView.allowsMultipleSelection = false
        bookListTableView.delegate = self
        bookListTableView.dataSource = bookListDataSource
        bookListTableView.register(BookTableViewCell.self)
        bookListTableView.register(EmptyBookTableViewCell.self)
        bookListTableView.separatorStyle = .singleLine
        bookListTableView.separatorInset = .init(top: 0, left: 0, bottom: 0, right: 0)
    }

    private func setNavigationBar() {
        navigationItem.backButtonTitle = ""
        navigationItem.title = "책 목록"
        navigationController?.navigationBar.tintColor = .white

        let appearance = UINavigationBarAppearance.makeNavigationBarAppearance()
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance

        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addBook)
        )
    }

    private func setActivityIndicator() {
        activityIndicator.hidesWhenStopped = true
    }
}

// MARK: - UITableViewDelegate

extension BookListViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
