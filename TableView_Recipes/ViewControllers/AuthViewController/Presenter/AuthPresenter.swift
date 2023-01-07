//
//  AuthPresenter.swift
//  TableView_Recipes
//
//  Created by Адель Ахметшин on 14.12.2022.
//

import Foundation
import UIKit

class AuthPresenter: AuthViewPresenterProtocol {
    
    var authService: AuthServiceProtocol
    weak var view: AuthViewProtocol?
    let router: AuthRouter?
    private let usersDataBase = UserDefaults.standard
    private var users: [String: String] = [:]
    
    // MARK: - Init
    required init(view: AuthViewProtocol, router: AuthRouter, authService: AuthServiceProtocol) {
        self.view = view
        self.router = router
        self.authService = authService
    }
    
    // MARK: - Show wrong login
    func showWrongLogin() {
        let alertController = UIAlertController(title: "Error", message: "User is not found", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(okAction)
        view?.present(alert: alertController)
    }
    
    // MARK: - Show wrong password
    func showWrongPassword() {
        let alertController = UIAlertController(title: "Error", message: "Wrong password", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(okAction)
        view?.present(alert: alertController)
    }
    
    // MARK: - Show success registration
    private func showSuccessRegistration() {
        let alertController = UIAlertController(title: "Congratulations", message: "You have successfully registered", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(okAction)
        view?.present(alert: alertController)
    }
    
    // MARK: - Actions
    func loginButtonTapped(view: UIViewController, login: String, password: String) {
        authService.loginButtonTapped(login: login, password: password)
        router?.showTabBarController(from: view)
    }
    
    func registrationButtonTapped(login: String, password: String) {
        authService.registrationButtonTapped(login: login, password: password)
        showSuccessRegistration()
        view?.successRegistration()
    }
}
