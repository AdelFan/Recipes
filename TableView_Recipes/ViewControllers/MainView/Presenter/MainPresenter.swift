//
//  MainPresenter.swift
//  TableView_Recipes
//
//  Created by Адель Ахметшин on 11.12.2022.
//

import Foundation
import UIKit

final class MainPresenter: MainViewPresenterProtocol {

    weak var view: MainViewProtocol?
    var router: MainRouter?
    var italianRecipes: [Recipe]?
    var americanRecipes: [Recipe]?
    var recipes = [String]()
    
    private let networkService: NetworkServiceProtocol
    private let likeService: LikeServiceProtocol
    private let group = DispatchGroup()

    // MARK: - Init
    required init(view: MainViewProtocol, networkService: NetworkServiceProtocol, router: MainRouter, likeService: LikeServiceProtocol) {
        self.view = view
        self.networkService = networkService
        self.likeService = likeService
        self.router = router
        
        getItalianRecipes()
        getAmericanRecipes()
        fetchData()
    }
    
    // MARK: - Get italian recipes
    private func getItalianRecipes() {
        group.enter()
        networkService.getItalianRecipes { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let models):
                    var recipes = [Recipe]()
                    for number in 0..<Constants.numberRecipes {
                        recipes.append(models.results[number])
                    }
                    self.italianRecipes = recipes
                    do {
                        self.group.leave()
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    // MARK: - Get american recipes
    private func getAmericanRecipes() {
        group.enter()
        networkService.getAmericanRecipes { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let models):
                    var recipes = [Recipe]()
                    for number in 0..<Constants.numberRecipes {
                        recipes.append(models.results[number])
                    }
                    self.americanRecipes = recipes
                    do {
                        self.group.leave()
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    // MARK: - Fetch data
    func fetchData() {
        group.notify(queue: .main) {
            guard let italianRecipes = self.italianRecipes else { return }
            for recipe in italianRecipes {
                self.updateUI(with: recipe.title)
            }
            self.view?.success()
        }
    }
    
    // MARK: - Update UI
    func updateUI(with model: String) {
        recipes.append(model)
    }
    
    // MARK: - Tap segment control
    func tapSegmentControl(type: RecipeType) {
        switch type {
        case .italian:
            recipes.removeAll()
            
            for number in 0..<Constants.numberRecipes {
                updateUI(with: italianRecipes?[number].title ?? "")
            }
            view?.success()
        case .american:
            recipes.removeAll()
            
            for number in 0..<Constants.numberRecipes {
                updateUI(with: americanRecipes?[number].title ?? "")
            }
            view?.success()
        }
    }
    
    // MARK: - Show detail view
    func showDetailViewController(view: UIViewController, recipe: Recipe) {
        router?.showDetailViewController(from: view, recipe: recipe)
    }
    
    // MARK: - Filter for search
    func filterContentForSearchText(type: RecipeType, searchText: String) -> [Recipe] {
        guard let italianRecipes = italianRecipes else { return [Recipe(id: 0, title: "", image: "")]}
        guard let americanRecipes = americanRecipes else { return [Recipe(id: 0, title: "", image: "")]}
        
        switch type {
        case .italian:
            let searchRecipe = italianRecipes.filter { (recipe: Recipe) -> Bool in
                return recipe.title.lowercased().contains(searchText.lowercased())
            }
            return searchRecipe
        case .american:
            let searchRecipe = americanRecipes.filter { (recipe: Recipe) -> Bool in
                return recipe.title.lowercased().contains(searchText.lowercased())
            }
            return searchRecipe
        }
    }
}
