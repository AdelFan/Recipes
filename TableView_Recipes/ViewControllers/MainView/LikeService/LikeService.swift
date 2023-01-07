//
//  LikeService.swift
//  TableView_Recipes
//
//  Created by Адель Ахметшин on 19.12.2022.
//

import Foundation
import UIKit

final class LikeService: LikeServiceProtocol {
    
    var italianLikes: UserDefaults = .standard
    var americanLikes: UserDefaults = .standard
    var notificationCenterMainView = NotificationCenter.default
    var notificationCenterFavoriteView = NotificationCenter.default
    
    // MARK: - Add like
    func addLike(type: RecipeType, and recipe: Recipe) {
        switch type {
        case .italian:
            do {
                if let data: Data = try? JSONEncoder().encode(recipe) {
                    italianLikes.set(data, forKey: recipe.title)
                }
            }
        case .american:
            do {
                if let data: Data = try? JSONEncoder().encode(recipe) {
                    americanLikes.set(data, forKey: recipe.title)
                }
            }
        }
    }
    
    // MARK: - Remove like
    func removeLike(type: RecipeType, and recipe: Recipe) {
        switch type {
        case .italian:
            italianLikes.removeObject(forKey: recipe.title)
        case .american:
            americanLikes.removeObject(forKey: recipe.title)
        }
    }
    
    // MARK: - Favorite recipe
    func favoriteRecipe(nameRecipe: String) -> Bool {
        var decodeRecipeTitle = ""
        if let data = italianLikes.object(forKey: nameRecipe) as? Data {
            if let decodeRecipe = try? JSONDecoder().decode(Recipe.self, from: data) {
                decodeRecipeTitle = decodeRecipe.title
            }
        }
        return nameRecipe == decodeRecipeTitle ? true : false
    }
}
