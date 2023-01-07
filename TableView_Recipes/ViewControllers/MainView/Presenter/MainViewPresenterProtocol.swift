//
//  MainViewpresenterProtocol.swift
//  TableView_Recipes
//
//  Created by Адель Ахметшин on 11.12.2022.
//

import Foundation
import UIKit

protocol MainViewPresenterProtocol: AnyObject {
    init(view: MainViewProtocol, networkService: NetworkServiceProtocol, router: MainRouter, likeService: LikeServiceProtocol)
    
    var recipes: [String] { get set }
    var italianRecipes: [Recipe]? { get set }
    var americanRecipes: [Recipe]? { get set }
    
    func fetchData()
    func updateUI(with model: String)
    func tapSegmentControl(type: RecipeType)
    func showDetailViewController(view: UIViewController, recipe: Recipe)
    func filterContentForSearchText(type: RecipeType, searchText: String) -> [Recipe]
}
