//
//  AuthRouter.swift
//  TableView_Recipes
//
//  Created by Адель Ахметшин on 30.11.2022.
//

import UIKit

protocol AuthRouter {
    func showTabBarController(from viewController: UIViewController)
}

// MARK: - AuthRouter
extension Router: AuthRouter {
    func showTabBarController(from viewController: UIViewController) {
        let tabBarController = TabBarController()
        tabBarController.modalPresentationStyle = .fullScreen
        viewController.present(tabBarController, animated: true)
    }
}
