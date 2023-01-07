//
//  AuthService.swift
//  TableView_Recipes
//
//  Created by Адель Ахметшин on 23.12.2022.
//

import Foundation

final class AuthService: AuthServiceProtocol {
    
    var presenter: AuthViewPresenterProtocol!
    var usersDataBase: UserDefaults = .standard
    var users: [String : String] = [:]
    
    // MARK: - Login button tapped
    func loginButtonTapped(login: String, password: String) {
        guard (usersDataBase.object(forKey: login) as? String) != nil else {
            return presenter.showWrongLogin()
        }
        guard password == usersDataBase.object(forKey: login) as? String else {
            return presenter.showWrongPassword()
        }
    }
    
    // MARK: - Registration button tapped
    func registrationButtonTapped(login: String, password: String) {
        users[login] = password
        let user = users[login]
        usersDataBase.set(user, forKey: login)
    }
}
