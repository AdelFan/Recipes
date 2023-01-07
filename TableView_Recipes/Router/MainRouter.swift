//
//  MainRouter.swift
//  TableView_Recipes
//
//  Created by Адель Ахметшин on 29.11.2022.
//

import UIKit

protocol MainRouter {
    func showDetailViewController(from viewController: UIViewController, recipe: Recipe)
}

// MARK: - MainRouter
extension Router: MainRouter {
    func showDetailViewController(from viewController: UIViewController, recipe: Recipe) {
        let detailController = AssemblyBuilder.createDetailModule(recipe: recipe)
        viewController.navigationController?.pushViewController(detailController, animated: true)
    }
}
