//
//  BaseTableViewCell.swift
//  BookStore
//
//  Created by Jaeyong Lee on 2022/11/02.
//

import UIKit

struct EmptyHashableModel: Hashable {}

class BaseTableViewCell<T: Hashable>: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setAttribute()
        setLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with itemModel: T) {}

    func setAttribute() {}

    func setLayout() {}
}
