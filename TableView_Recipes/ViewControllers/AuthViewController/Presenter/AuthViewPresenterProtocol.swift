//
//  AuthViewPresenterProtocol.swift
//  TableView_Recipes
//
//  Created by Адель Ахметшин on 14.12.2022.
//

import Foundation
import UIKit

protocol AuthViewPresenterProtocol: AnyObject {
    init(view: AuthViewProtocol, router: AuthRouter, authService: AuthServiceProtocol)
    
    var authService: AuthServiceProtocol { get set }
    
    func showWrongLogin()
    func showWrongPassword()
    func loginButtonTapped(view: UIViewController, login: String, password: String)
    func registrationButtonTapped(login: String, password: String)
}
