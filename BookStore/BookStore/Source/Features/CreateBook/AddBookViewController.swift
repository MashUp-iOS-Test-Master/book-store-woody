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
    lazy var categorySegmentControl = UISegmentedControl(items: categories.map { $0.rawValue })
    lazy var publishedAtTitleLabel = UILabel()
    lazy var publishedAtLabel = UILabel()
    lazy var publishedAtDatePicker = UIDatePicker()
    lazy var priceTitleLabel = UILabel()
    lazy var priceTextField = UITextField()

    let categories: [Book.Category] = [.sosal, .tech, .economy, .poem]
    var selectedCategoryIndex: Int = 0

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

    @objc func storeBook() {
        guard let name = bookNameTextField.text else { return }
        let category = categories[selectedCategoryIndex]
        guard let publishedAtDate = publishedAtLabel.text else { return }
        guard let priceText = priceTextField.text?.replacingOccurrences(of: ",", with: ""),
              let price = Formatter.amountFormatter.number(from: priceText) as? Int else { return }
        let book = Book(name: name, price: price, publishedAt: publishedAtDate, category: category, imageName: "ic_empty")

        let currentBook = UserDefaults.standard.read(key: .books, type: [Book].self) ?? []
        let success = UserDefaults.standard.store(data: currentBook + [book], key: .books)
        if success {
            self.dismiss(animated: true)
        }
    }

    @objc func cancel() {
        self.dismiss(animated: true)
    }

    @objc func categorySegmentControlValueChanged(_ segmentControl: UISegmentedControl) {
        selectedCategoryIndex = segmentControl.selectedSegmentIndex
    }

    @objc func publishedAtDatePickerValueChanged(_ datePicker: UIDatePicker) {
        publishedAtLabel.text = Formatter.dateFormatter.string(from: datePicker.date)
    }

    @objc func priceTextFieldValueChanged(_ textField: UITextField) {

        guard let text = textField.text?.replacingOccurrences(of: ",", with: ""),
              let price = Formatter.amountFormatter.number(from: text) as? Int else { return }
        priceTextField.text = Formatter.amountFormatter.string(from: NSNumber(value: price))
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
    }

    private func setCategorySegmetControl() {
        categorySegmentControl.selectedSegmentIndex = selectedCategoryIndex
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
