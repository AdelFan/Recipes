//
//  NetworkServiceProtocol.swift
//  TableView_Recipes
//
//  Created by Адель Ахметшин on 19.12.2022.
//

import Foundation

protocol NetworkServiceProtocol: AnyObject {
    func getItalianRecipes(completion: @escaping (Result<RecipesResponse, Error>) -> Void)
    func getAmericanRecipes(completion: @escaping (Result<RecipesResponse, Error>) -> Void)
    func getIngredient(with id: Int, completion: @escaping (Result<Ingredients, Error>) -> Void)
    func createRequest(with url: URL?, type: HttpMethod, completion: @escaping (URLRequest) -> Void)
}
