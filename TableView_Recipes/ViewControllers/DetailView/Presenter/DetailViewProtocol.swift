//
//  DetailViewProtocol.swift
//  TableView_Recipes
//
//  Created by Адель Ахметшин on 11.12.2022.
//

import Foundation

protocol DetailViewProtocol: AnyObject {
    var recipe: Recipe { get set }
    
    func success()
    func failure(error: Error)
}
