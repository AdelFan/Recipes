//
//  MainViewProtocol.swift
//  TableView_Recipes
//
//  Created by Адель Ахметшин on 11.12.2022.
//

import Foundation

protocol MainViewProtocol: AnyObject {
    func success()
    func failure(error: Error)
}
