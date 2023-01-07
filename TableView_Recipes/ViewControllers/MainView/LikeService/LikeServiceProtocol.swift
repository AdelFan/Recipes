//
//  LikeServiceProtocol.swift
//  TableView_Recipes
//
//  Created by Адель Ахметшин on 19.12.2022.
//

import Foundation

protocol LikeServiceProtocol: AnyObject {
    var italianLikes: UserDefaults { get set }
    var americanLikes: UserDefaults { get set }
    var notificationCenterMainView: NotificationCenter { get }
    var notificationCenterFavoriteView: NotificationCenter { get }
    
    func addLike(type: RecipeType, and recipe: Recipe)
    func removeLike(type: RecipeType, and recipe: Recipe)
    func favoriteRecipe(nameRecipe: String) -> Bool
}
