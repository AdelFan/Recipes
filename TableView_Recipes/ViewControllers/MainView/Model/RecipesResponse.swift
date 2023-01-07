//
//  ItalianRecipesResponse.swift
//  TableView_Recipes
//
//  Created by Адель Ахметшин on 09.10.2022.
//

import Foundation

// MARK: - Recipe type
enum RecipeType {
    case italian, american
}

// MARK: - Recipes response
struct RecipesResponse: Codable {
    let results: [Recipe]
}

// MARK: - Recipe
struct Recipe: Codable, Equatable {
    let id: Int
    let title: String
    let image: String
}
