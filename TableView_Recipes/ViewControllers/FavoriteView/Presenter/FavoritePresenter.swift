//
//  FavoritePresenter.swift
//  TableView_Recipes
//
//  Created by Адель Ахметшин on 12.12.2022.
//

import Foundation
import UIKit

class FavoritePresenter: FavoriteViewPresenterProtocol {
    
    weak var view: FavoriteViewProtocol?
    let likeService: LikeServiceProtocol
    var router: MainRouter
    var mainPresenter: MainViewPresenterProtocol
    var italianRecipes = [Recipe]()
    var americanRecipes = [Recipe]()
    
    // MARK: - Init
    required init(view: FavoriteViewProtocol, router: MainRouter, mainPresenter: MainViewPresenterProtocol, likeService: LikeServiceProtocol) {
        self.view = view
        self.likeService = likeService
        self.router = router
        self.mainPresenter = mainPresenter
    }
    
    // MARK: - Configure cells
    func configureCells() {
        // Italian Recipes
        for recipe in mainPresenter.italianRecipes ?? [] {
            do {
                if let data = likeService.italianLikes.object(forKey: recipe.title) as? Data {
                    if let recipeDecode = try? JSONDecoder().decode(Recipe.self, from: data ) {
                        if !italianRecipes.contains(where: { recipe in
                            recipe == recipeDecode ? true : false
                        }) {
                            italianRecipes.append(recipeDecode)
                        }
                    }
                }
            }
        }
        
        // American Recipes
        for recipe in mainPresenter.americanRecipes ?? [] {
            do {
                if let data = likeService.americanLikes.object(forKey: recipe.title) as? Data {
                    if let recipeDecode = try? JSONDecoder().decode(Recipe.self, from: data ) {
                        if !americanRecipes.contains(where: { recipe in
                            recipe == recipeDecode ? true : false
                        }) {
                            americanRecipes.append(recipeDecode)
                        }
                    }
                }
            }
        }
    }
    
    // MARK: - Show detail view
    func showDetailViewController(view: UIViewController, recipe: Recipe) {
        router.showDetailViewController(from: view, recipe: recipe)
    }
    
    // MARK: - Remove recipe
    func removeRecipe(key: String, recipe: Int, type: RecipeType) {
        switch type {
        case .italian:
            likeService.italianLikes.removeObject(forKey: key)
            italianRecipes.remove(at: recipe)
        case .american:
            likeService.americanLikes.removeObject(forKey: key)
            americanRecipes.remove(at: recipe)
        }
        view?.success()
    }
    
    func removeRecipe(type: RecipeType, recipe: Recipe) {
        switch type {
        case .italian:
            let recipes = italianRecipes.filter() {$0 != recipe}
            italianRecipes = recipes
        case .american:
            let recipes = americanRecipes.filter() {$0 != recipe}
            americanRecipes = recipes
        }
        configureCells()
        view?.success()
    }
    
    // MARK: - Add like
    func addLike() {
        configureCells()
        view?.success()
    }
}
