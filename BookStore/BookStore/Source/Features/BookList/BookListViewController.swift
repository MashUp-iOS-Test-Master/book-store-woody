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
    lazy var totalPriceBottomView = UIView()
    lazy var totalPriceTitleLabel = UILabel()
    lazy var totalPriceLabel = UILabel()

    let bookLocalStorage: BookLocalStorage

    init(bookLocalStorage: BookLocalStorage = BookLocalStorageImpl()) {
        self.bookLocalStorage = bookLocalStorage
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Life Cycle

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        requestBookList()
    }

    override func setAttribute() {
        super.setAttribute()

        setNavigationBar()
        setBookListTableView()
        setActivityIndicator()
        setTotalPriceBottom()
    }

    override func setLayout() {
        super.setLayout()

        view.addSubview(bookListTableView)
        view.addSubview(activityIndicator)
        view.addSubview(totalPriceBottomView)
        totalPriceBottomView.addSubview(totalPriceTitleLabel)
        totalPriceBottomView.addSubview(totalPriceLabel)

        bookListTableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.bottom.equalToSuperview()
        }
        activityIndicator.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
        totalPriceBottomView.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(60)
        }
        totalPriceTitleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(20)
        }
        totalPriceLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(20)
        }
    }

    // MARK: Business Logic

    func requestBookList() {
        activityIndicator.startAnimating()
        DispatchQueue.main.asyncAfter(deadline: .now()+1.0) { [weak self] in
            if let books = self?.bookLocalStorage.read() {
                self?.display(books: books)
            } else {
                self?.display(books: [])
            }
            self?.activityIndicator.stopAnimating()
        }
    }

    func calculateTotalPrice(books: [Book]) -> Int {
        books.reduce(0) { partialResult, book in
            return partialResult + book.price
        }
    }

    func display(books: [Book]) {
        if let price = Formatter.amountFormatter.string(from: NSNumber(value: calculateTotalPrice(books: books))) {
            totalPriceLabel.attributedText = NSMutableAttributedString()
                .bold(string: "\(price)", fontSize: 20)
                .medium(string: "원", fontSize: 15)
        }

        if books.isEmpty {
            applySnapShot(section: [.empty])
        } else {
            applySnapShot(section: [.list(books.map { .book($0) })])
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

    private func setTotalPriceBottom() {
        totalPriceTitleLabel.font = .gmarksans(weight: .medium, size: 16)
        totalPriceTitleLabel.text = "가격 합계: "
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

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        guard let itemIdentifier = bookListDataSource.itemIdentifier(for: indexPath) else { return nil }
        guard case .book(let model) = itemIdentifier else { return nil }

        let delete = UIContextualAction(style: .normal, title: "삭제") { [weak self] action, view, success in

            guard let result = self?.bookLocalStorage.remove(data: model) else { fatalError() }
            success(result)
            self?.requestBookList()
        }
        delete.image = UIImage(systemName: "xmark.circle")
        delete.backgroundColor = .systemRed
        return UISwipeActionsConfiguration(actions: [delete])
    }

}
