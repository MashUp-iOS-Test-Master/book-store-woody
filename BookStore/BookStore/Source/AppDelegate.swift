//
//  AppDelegate.swift
//  BookStore
//
//  Created by Jaeyong Lee on 2022/11/02.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow()
        self.window?.rootViewController = createRootViewController()
        window?.makeKeyAndVisible()

        return true
    }

    func createRootViewController() -> UIViewController {
        let navigationController = UINavigationController()
        let bookListViewController = BookListViewController()
        navigationController.setViewControllers([bookListViewController], animated: true)
        return navigationController
    }
}
