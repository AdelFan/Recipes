//
//  AuthViewProtocol.swift
//  TableView_Recipes
//
//  Created by Адель Ахметшин on 14.12.2022.
//

import Foundation
import UIKit

protocol AuthViewProtocol: AnyObject {
    func present(alert: UIAlertController)
    func successRegistration()
    func failure(error: Error)
}
