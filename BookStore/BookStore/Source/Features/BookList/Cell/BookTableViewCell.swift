//
//  BookTableViewCell.swift
//  BookStore
//
//  Created by Jaeyong Lee on 2022/11/02.
//

import UIKit

final class BookTableViewCell: BaseTableViewCell<Book> {

    lazy var bookImageView = UIImageView()
    lazy var bookInformationStackView = UIStackView()
    lazy var bookDetailStackView = UIStackView()
    lazy var bookDetailBottomStackView = UIStackView()
    lazy var nameLabel = UILabel()
    lazy var categoryLabel = UILabel()
    lazy var publishedAtLabel = UILabel()
    lazy var priceLabel = UILabel()

    override func configure(with itemModel: Book) {
        bookImageView.image = UIImage(named: itemModel.imageName ?? "")
        setNameLabel(name: itemModel.name)
        setCategoryLabel(category: itemModel.category.rawValue)
        setPublishedAtLabel(publishedAt: itemModel.publishedAt)
        setPriceLabel(price: itemModel.price)
    }

    override func setAttribute() {
        super.setAttribute()

        backgroundColor = .clear
        contentView.backgroundColor = .clear
        
        bookDetailStackView.axis = .vertical
        bookDetailStackView.alignment = .leading
        bookDetailStackView.distribution = .fill
        bookDetailStackView.spacing = 8

        bookInformationStackView.axis = .horizontal
        bookInformationStackView.alignment = .bottom
        bookInformationStackView.distribution = .fill
        bookInformationStackView.spacing = 12

        bookDetailBottomStackView.axis = .horizontal
        bookDetailBottomStackView.alignment = .center
        bookDetailBottomStackView.distribution = .fill
        bookDetailBottomStackView.spacing = 8

        bookImageView.backgroundColor = .lightGray
        bookImageView.contentMode = .scaleAspectFit
        bookImageView.backgroundColor = .clear
        bookImageView.layer.cornerRadius = 10
        bookImageView.layer.masksToBounds = true
    }

    override func setLayout() {
        super.setLayout()

        contentView.addSubview(bookImageView)
        contentView.addSubview(bookInformationStackView)
        bookInformationStackView.addArrangedSubview(bookDetailStackView)
        bookInformationStackView.addArrangedSubview(priceLabel)
        bookDetailStackView.addArrangedSubview(nameLabel)
        bookDetailStackView.addArrangedSubview(bookDetailBottomStackView)
        bookDetailBottomStackView.addArrangedSubview(categoryLabel)
        bookDetailBottomStackView.addArrangedSubview(publishedAtLabel)

        bookImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(20)
            make.width.equalTo(90)
            make.height.equalTo(170)
        }

        bookInformationStackView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(60)
            make.centerY.equalToSuperview()
            make.leading.equalTo(bookImageView.snp.trailing).offset(20)
            make.trailing.equalToSuperview().inset(20)
        }
    }

}

extension BookTableViewCell {

    private func setNameLabel(name: String) {
        let nameAttributedString = NSMutableAttributedString()
            .bold(string: name, fontSize: 16)
        nameLabel.attributedText = nameAttributedString
    }

    private func setCategoryLabel(category: String) {
        let categoryAttributedString = NSMutableAttributedString()
            .bold(string: category, fontSize: 11)
        categoryLabel.attributedText = categoryAttributedString
    }

    private func setPublishedAtLabel(publishedAt: String) {
        let publishedAtAttributedString = NSMutableAttributedString()
            .light(string: publishedAt, fontSize: 11)
        publishedAtLabel.attributedText = publishedAtAttributedString
    }

    private func setPriceLabel(price: Int) {

        if let price = Formatter.amountFormatter.string(from: NSNumber(value: price)) {
            let priceAttributedString = NSMutableAttributedString()
                .medium(string: price, fontSize: 16)
                .light(string: "원", fontSize: 12)
            priceLabel.attributedText = priceAttributedString
        }
    }

}
