//
//  NSMutableAttributedString+.swift
//  BookStore
//
//  Created by Jaeyong Lee on 2022/11/02.
//

import UIKit

extension NSMutableAttributedString {

    func bold(string: String, fontSize: CGFloat) -> NSMutableAttributedString {
        let font = UIFont.gmarksans(weight: .bold, size: fontSize)
        let attributes: [NSAttributedString.Key: Any] = [.font: font]
        self.append(NSAttributedString(string: string, attributes: attributes))
        return self
    }

    func medium(string: String, fontSize: CGFloat) -> NSMutableAttributedString {
        let font = UIFont.gmarksans(weight: .medium, size: fontSize)
        let attributes: [NSAttributedString.Key: Any] = [.font: font]
        self.append(NSAttributedString(string: string, attributes: attributes))
        return self
    }

    func light(string: String, fontSize: CGFloat) -> NSMutableAttributedString {
        let font = UIFont.gmarksans(weight: .light, size: fontSize)
        let attributes: [NSAttributedString.Key: Any] = [.font: font]
        self.append(NSAttributedString(string: string, attributes: attributes))
        return self
    }
}
