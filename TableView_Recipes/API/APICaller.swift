//
//  APICaller.swift
//  TableView_Recipes
//
//  Created by Адель Ахметшин on 07.10.2022.
//

import Foundation

final class APICaller: NetworkServiceProtocol {
    
    // MARK: - GETItalianFood
    public func getItalianRecipes(completion: @escaping (Result<RecipesResponse, Error>) -> Void) {
        createRequest(with: URL(string: Constants.baseAPIURL + Constants.apiKey + Constants.requestItalianFood + Constants.requestNumber + String(Constants.numberRecipes)), type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                do {
                    let result = try JSONDecoder().decode(RecipesResponse.self, from: data)
                    completion(.success(result))
                } catch {
                    print("ERROR: Italian Recipes")
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    // MARK: - GETMexicanFood
    public func getAmericanRecipes(completion: @escaping (Result<RecipesResponse, Error>) -> Void) {
        createRequest(with: URL(string: Constants.baseAPIURL + Constants.apiKey + Constants.requestAmericanFood + Constants.requestNumber + String(Constants.numberRecipes)), type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                do {
                    let result = try JSONDecoder().decode(RecipesResponse.self, from: data)
                    completion(.success(result))
                } catch {
                    print("ERROR: American Recipes")
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    // MARK: - GETIngredients
    public func getIngredient(with id: Int, completion: @escaping (Result<Ingredients, Error>) -> Void) {
        createRequest(with: URL(string: Constants.ingredientURL + String(id) + Constants.ingredientWidget  + Constants.apiKey), type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                do {
                    let result = try JSONDecoder().decode(Ingredients.self, from: data)
                    completion(.success(result))
                } catch {
                    print("ERROR: Ingredients by ID")
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    // MARK: - Request method
    internal func createRequest(with url: URL?, type: HttpMethod, completion: @escaping (URLRequest) -> Void) {
        guard let apiURL = url else {
            return
        }
        var request = URLRequest(url: apiURL)
        request.httpMethod = type.rawValue
        request.timeoutInterval = 30
        completion(request)
    }
}
