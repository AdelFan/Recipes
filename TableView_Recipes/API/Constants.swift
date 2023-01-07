//
//  Constants.swift
//  TableView_Recipes
//
//  Created by Адель Ахметшин on 19.12.2022.
//

import Foundation

// MARK: - Constants
struct Constants {
    static let baseAPIURL = "https://api.spoonacular.com/recipes/complexSearch"
    static let apiKey = "?apiKey=63feaae6fdbb4e5b992c784c4d2c31b5"
    static let requestItalianFood = "&cuisine=Italian"
    static let requestAmericanFood = "&cuisine=American"
    static let requestNumber = "&number="
    static let numberRecipes = 30
    static let ingredientURL = "https://api.spoonacular.com/recipes/"
    static let ingredientWidget = "/ingredientWidget.json"
    static let imageURL = "https://spoonacular.com/cdn/ingredients_250x250/"
}

// MARK: - APIError
enum APIError: Error {
    case failedToGetData
}

// MARK: - Http method
enum HttpMethod: String {
    case GET
    case POST
}
