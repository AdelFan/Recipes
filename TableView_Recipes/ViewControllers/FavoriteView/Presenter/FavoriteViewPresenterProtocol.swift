//
//  FavoriteViewPresenterProtocol.swift
//  TableView_Recipes
//
//  Created by Адель Ахметшин on 12.12.2022.
//

import Foundation
import UIKit

protocol FavoriteViewPresenterProtocol: AnyObject {
    init(view: FavoriteViewProtocol, router: MainRouter, mainPresenter: MainViewPresenterProtocol, likeService: LikeServiceProtocol)
    
    var italianRecipes: [Recipe] { get set }
    var americanRecipes: [Recipe] { get set }
    var likeService: LikeServiceProtocol { get }
    
    func configureCells()
    func showDetailViewController(view: UIViewController, recipe: Recipe)
    func removeRecipe(key: String, recipe: Int, type: RecipeType)
    func removeRecipe(type: RecipeType, recipe: Recipe)
    func addLike()
}
