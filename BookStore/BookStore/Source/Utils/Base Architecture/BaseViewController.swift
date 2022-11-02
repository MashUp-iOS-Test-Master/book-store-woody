//
//  BaseViewController.swift
//  BookStore
//
//  Created by Jaeyong Lee on 2022/11/02.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    private func setup() {
        setAttribute()
        setLayout()
    }
    func setAttribute() {
        view.backgroundColor = .black
    }
    func setLayout() {}
}
