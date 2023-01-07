//
//  DetailViewPresenterProtocol.swift
//  TableView_Recipes
//
//  Created by Адель Ахметшин on 11.12.2022.
//

import Foundation

protocol DetailViewPresenterProtocol: AnyObject {
    init(view: DetailViewProtocol, networkService: NetworkServiceProtocol)
    
    var ingredients: [Ingredient] { get set }
    
    func fetchData()
}
