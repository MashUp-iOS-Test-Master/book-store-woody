//
//  AddBookViewController.swift
//  BookStore
//
//  Created by Jaeyong Lee on 2022/11/02.
//

import UIKit

final class AddBookViewController: BaseViewController {

    lazy var scrollView = UIScrollView()
    lazy var contentView = UIView()
    lazy var bookNameTitleLabel = UILabel()
    lazy var bookNameTextField = UITextField()
    lazy var categoryTitleLabel = UILabel()
    lazy var categorySegmentControl = UISegmentedControl(items: AddBookViewModel.categories.map { $0.rawValue })
    lazy var publishedAtTitleLabel = UILabel()
    lazy var publishedAtLabel = UILabel()
    lazy var publishedAtDatePicker = UIDatePicker()
    lazy var priceTitleLabel = UILabel()
    lazy var priceTextField = UITextField()

    let viewModel: AddBookBusinessLogic

    init(viewModel: AddBookBusinessLogic = AddBookViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    override func bind() {

        viewModel.publishedAtPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] publishedAt in
                self?.publishedAtLabel.text = publishedAt
            }
            .store(in: &cancellables)

        viewModel.pricePublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] price in
                if let price = Formatter.amountFormatter.string(from: NSNumber(value: price)) {
                    self?.priceTextField.text = price
                }

            }
            .store(in: &cancellables)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: UI

    override func setAttribute() {
        super.setAttribute()

        setTitleLabels()
        setNavigationBar()
        setScrollView()
        setBookNameTextField()
        setCategorySegmetControl()
        setPublishedAtLabel()
        setPublishedAtDatePicker()
        setPriceTextField()
    }

    override func setLayout() {
        super.setLayout()

        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(bookNameTitleLabel)
        contentView.addSubview(bookNameTextField)
        contentView.addSubview(categoryTitleLabel)
        contentView.addSubview(categorySegmentControl)
        contentView.addSubview(publishedAtTitleLabel)
        contentView.addSubview(publishedAtLabel)
        contentView.addSubview(publishedAtDatePicker)
        contentView.addSubview(priceTitleLabel)
        contentView.addSubview(priceTextField)

        scrollView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.leading.trailing.equalToSuperview()
        }
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalTo(scrollView.snp.width)
            make.height.equalTo(scrollView.snp.height).priority(250)
        }
        bookNameTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(30)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        bookNameTextField.snp.makeConstraints { make in
            make.top.equalTo(bookNameTitleLabel.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
        categoryTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(bookNameTextField.snp.bottom).offset(25)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        categorySegmentControl.snp.makeConstraints { make in
            make.top.equalTo(categoryTitleLabel.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        publishedAtTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(categorySegmentControl.snp.bottom).offset(25)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        publishedAtLabel.snp.makeConstraints { make in
            make.top.equalTo(publishedAtTitleLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview().inset(20)
        }
        publishedAtDatePicker.snp.makeConstraints { make in
            make.centerY.equalTo(publishedAtLabel)
            make.trailing.equalToSuperview().inset(20)
            make.leading.equalTo(publishedAtLabel.snp.trailing).offset(30)
        }
        priceTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(publishedAtDatePicker.snp.bottom).offset(25)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        priceTextField.snp.makeConstraints { make in
            make.top.equalTo(priceTitleLabel.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
        }
    }

    // MARK: Business Logic

    @objc func bookNameValueChanged(_ textField: UITextField) {
        guard let text = textField.text else { return }
        viewModel.updateBookName(to: text)
    }

    @objc func categorySegmentControlValueChanged(_ segmentControl: UISegmentedControl) {
        viewModel.updateCategory(selectedIndex: segmentControl.selectedSegmentIndex)
    }

    @objc func publishedAtDatePickerValueChanged(_ datePicker: UIDatePicker) {
        viewModel.updatePublishedAt(selectedDate: datePicker.date)
    }

    @objc func priceTextFieldValueChanged(_ textField: UITextField) {
        guard let text = textField.text else { return }
        viewModel.updatePrice(to: text)
    }

    @objc func storeBook() {
        let addBookResult = viewModel.addBook()
        if addBookResult != nil {
            self.dismiss(animated: true)
        }
    }

    @objc func cancel() {
        self.dismiss(animated: true)
    }
}

// MARK: - UI

extension AddBookViewController {

    private func setNavigationBar() {
        let appearnce = UINavigationBarAppearance.makeNavigationBarAppearance()
        navigationController?.navigationBar.standardAppearance = appearnce
        navigationController?.navigationBar.scrollEdgeAppearance = appearnce
        navigationItem.backButtonTitle = ""
        navigationItem.title = "책 추가하기"
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.topItem?.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .cancel,
            target: self,
            action: #selector(cancel)
        )
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(storeBook)
        )
    }
    
    private func setScrollView() {
        view.backgroundColor = .white
    }

    private func setTitleLabels() {
        bookNameTitleLabel.text = "제목"
        categoryTitleLabel.text = "카테고리"
        publishedAtTitleLabel.text = "출판일"
        priceTitleLabel.text = "가격"
        [bookNameTitleLabel, categoryTitleLabel, publishedAtTitleLabel, priceTitleLabel].forEach { label in
            label.font = .gmarksans(weight: .bold, size: 20)
            label.textAlignment = .left
        }
    }

    private func setBookNameTextField() {
        bookNameTextField.clearButtonMode = .whileEditing
        bookNameTextField.leftView = UIView(frame: .init(origin: .zero, size: .init(width: 20, height: bookNameTextField.frame.height)))
        bookNameTextField.placeholder = "Harry Potter"
        bookNameTextField.font = .gmarksans(weight: .medium, size: 15)
        bookNameTextField.borderStyle = .roundedRect
        bookNameTextField.autocorrectionType = .no
        bookNameTextField.autocapitalizationType = .none
        bookNameTextField.addTarget(self, action: #selector(bookNameValueChanged), for: .editingChanged)
    }

    private func setCategorySegmetControl() {
        categorySegmentControl.selectedSegmentIndex = 0
        categorySegmentControl.backgroundColor = .blue.withAlphaComponent(0.2)
        categorySegmentControl.addTarget(self, action: #selector(categorySegmentControlValueChanged), for: .valueChanged)
    }

    private func setPublishedAtLabel() {
        publishedAtLabel.font = .gmarksans(weight: .medium, size: 15)
        publishedAtLabel.text = Formatter.dateFormatter.string(from: Date())
    }

    private func setPublishedAtDatePicker() {
        publishedAtDatePicker.datePickerMode = .date
        publishedAtDatePicker.addTarget(self, action: #selector(publishedAtDatePickerValueChanged), for: .valueChanged)
        publishedAtDatePicker.timeZone = NSTimeZone.local
        publishedAtDatePicker.backgroundColor = .white
    }

    private func setPriceTextField() {
        priceTextField.clearButtonMode = .whileEditing
        priceTextField.leftView = UIView(frame: .init(origin: .zero, size: .init(width: 20, height: bookNameTextField.frame.height)))
        priceTextField.placeholder = "12,000"
        priceTextField.font = .gmarksans(weight: .medium, size: 15)
        priceTextField.borderStyle = .roundedRect
        priceTextField.keyboardType = .numberPad
        priceTextField.textAlignment = .right
        priceTextField.addTarget(self, action: #selector(priceTextFieldValueChanged), for: .editingChanged)
    }
}
