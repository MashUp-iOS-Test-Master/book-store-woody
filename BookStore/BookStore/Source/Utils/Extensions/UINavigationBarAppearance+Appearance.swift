//
//  UINavigationBarAppearance+Appearance.swift
//  BookStore
//
//  Created by Jaeyong Lee on 2022/11/02.
//

import UIKit

extension UINavigationBarAppearance {

    static func makeNavigationBarAppearance() -> UINavigationBarAppearance {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .blue
        appearance.titleTextAttributes = [
            NSAttributedString.Key.font: UIFont.gmarksans(weight: .bold, size: 17),
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
        appearance.shadowColor = .clear
        return appearance
    }
}
