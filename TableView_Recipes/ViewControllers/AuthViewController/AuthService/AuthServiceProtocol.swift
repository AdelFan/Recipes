//
//  AuthServiceProtocol.swift
//  TableView_Recipes
//
//  Created by Адель Ахметшин on 23.12.2022.
//

import Foundation

protocol AuthServiceProtocol: AnyObject {
    
    var usersDataBase: UserDefaults { get set }
    var users: [String: String] { get set }
    
    func loginButtonTapped(login: String, password: String)
    func registrationButtonTapped(login: String, password: String)
}
