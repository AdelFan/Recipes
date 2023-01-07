//
//  DetailPresenter.swift
//  TableView_Recipes
//
//  Created by Адель Ахметшин on 11.12.2022.
//

import Foundation
import UIKit

class DetailPresenter: DetailViewPresenterProtocol {
    
    weak var view: DetailViewProtocol?
    let networkService: NetworkServiceProtocol
    var ingredients = [Ingredient]()
    
    // MARK: - Init
    required init(view: DetailViewProtocol, networkService: NetworkServiceProtocol) {
        self.view = view
        self.networkService = networkService
        fetchData()
    }
    
    // MARK: - Fetch data
    func fetchData() {
        let group = DispatchGroup()
        group.enter()
        networkService.getIngredient(with: view?.recipe.id ?? 0) { [weak self] result  in
            DispatchQueue.main.async {
                switch result {
                case .success(let model):
                    self?.ingredients = model.ingredients
                    do {
                        group.leave()
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
        group.notify(queue: .main) {
            self.view?.success()
        }
    }
}
