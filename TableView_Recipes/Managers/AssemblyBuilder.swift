//
//  AssemblyBuilder.swift
//  TableView_Recipes
//
//  Created by Адель Ахметшин on 11.12.2022.
//

import Foundation
import UIKit

protocol AssemblyBuilderProtocol: AnyObject {
    static func createAuthModule() -> UIViewController
    static func createMainModule() -> UIViewController
    static func createDetailModule(recipe: Recipe?) -> UIViewController
    static func createFavoriteModule() -> UIViewController
}

final class AssemblyBuilder: AssemblyBuilderProtocol {
    
    // MARK: - Auth module
    static func createAuthModule() -> UIViewController {
        let view = AuthViewController()
        let router = Router()
        let authService = AuthService()
        let presenter = AuthPresenter(view: view, router: router, authService: authService)
        view.presenter = presenter
        authService.presenter = presenter
        return view
    }
    
    // MARK: - Main module
    static func createMainModule() -> UIViewController {
        let view = MainViewController()
        let networkService = APICaller()
        let router = Router()
        let likeService = LikeService()
        let presenter = MainPresenter(view: view, networkService: networkService, router: router, likeService: likeService)
        view.likeService = likeService
        view.presenter = presenter
        return view
    }
    
    // MARK: - Detail module
    static func createDetailModule(recipe: Recipe?) -> UIViewController {
        let view = DetailViewController(recipe: recipe!)
        let networkService = APICaller()
        let presenter = DetailPresenter(view: view, networkService: networkService)
        view.presenter = presenter
        return view
    }
    
    // MARK: - Favorite module
    static func createFavoriteModule() -> UIViewController {
        let view = FavoriteViewController()
        let mainView = MainViewController()
        let networkService = APICaller()
        let router = Router()
        let likeService = LikeService()
        let mainPresenter = MainPresenter(view: mainView, networkService: networkService, router: router, likeService: likeService)
        let presenter = FavoritePresenter(view: view, router: router, mainPresenter: mainPresenter, likeService: likeService)
        view.presenter = presenter
        return view
    }
}
