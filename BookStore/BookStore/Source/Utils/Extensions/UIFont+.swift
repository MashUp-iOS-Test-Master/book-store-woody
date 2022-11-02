//
//  UIFont+.swift
//  BookStore
//
//  Created by Jaeyong Lee on 2022/11/02.
//

import UIKit

extension UIFont {

    enum CustomFontWeight: String {
        case bold = "Bold"
        case light = "Light"
        case medium = "medium"
    }

    class func gmarksans(weight: CustomFontWeight, size: CGFloat) -> UIFont {

        return ._font(name: "GmarketSansTTF\(weight.rawValue)", size: size)
    }

    private static func _font(name: String, size: CGFloat) -> UIFont {
        guard let font = UIFont(name: name, size: size) else {
            return .systemFont(ofSize: size)
        }
        return font
    }
}
