//
//  EmptyBookTableViewCell.swift
//  BookStore
//
//  Created by Jaeyong Lee on 2022/11/02.
//

import UIKit
import SnapKit

final class EmptyBookTableViewCell: BaseTableViewCell<EmptyHashableModel> {

    lazy var emptyDescriptionLabel = UILabel()

    override func setAttribute() {
        super.setAttribute()

        let emptyAttributedText = NSMutableAttributedString()
            .light(string: "안녕하세요 반가워요 :)\n", fontSize: 20)
            .light(string: "테스트 코드 실험중입니다\n", fontSize: 20)
            .medium(string: "📚 책을 등록해주세요! 📚", fontSize: 25)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 15
        emptyAttributedText.addAttributes(
            [.paragraphStyle: paragraphStyle],
            range: .init(location: 0, length: emptyAttributedText.length)
        )
        emptyDescriptionLabel.attributedText = emptyAttributedText
        emptyDescriptionLabel.numberOfLines = 0
        emptyDescriptionLabel.textAlignment = .center
        emptyDescriptionLabel.textColor = .gray

        self.selectionStyle = .none
    }

    override func setLayout() {
        super.setLayout()

        contentView.addSubview(emptyDescriptionLabel)

        emptyDescriptionLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(100)
            make.leading.trailing.equalToSuperview().inset(5)
            make.centerX.equalToSuperview()
        }
    }
}
