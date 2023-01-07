//
//  FavoriteViewProtocol.swift
//  TableView_Recipes
//
//  Created by Адель Ахметшин on 12.12.2022.
//

import Foundation

protocol FavoriteViewProtocol: AnyObject {
    func success()
    func failure(error: Error)
}
