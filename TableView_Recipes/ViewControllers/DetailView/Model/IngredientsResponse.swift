//
//  IngredientsResponse.swift
//  TableView_Recipes
//
//  Created by Адель Ахметшин on 13.11.2022.
//

import Foundation

// MARK: - Ingredients
struct Ingredients: Codable {
    let ingredients: [Ingredient]
}

// MARK: - Ingredient
struct Ingredient: Codable {
    let name, image: String
    let amount: Amount
}

// MARK: - Amount
struct Amount: Codable {
    let metric, us: Metric
}

// MARK: - Metric
struct Metric: Codable {
    let value: Double
    let unit: String
}
