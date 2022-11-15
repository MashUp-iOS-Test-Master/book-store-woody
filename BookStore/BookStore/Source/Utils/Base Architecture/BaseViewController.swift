//
//  BaseViewController.swift
//  BookStore
//
//  Created by Jaeyong Lee on 2022/11/02.
//

import UIKit
import Combine

class BaseViewController: UIViewController {
    var cancellables: Set<AnyCancellable> = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    private func setup() {
        setAttribute()
        setLayout()
        bind()
    }
    
    func bind() {}
    func setAttribute() {}
    func setLayout() {}
}
