//
//  ExtensionNotificationCenter.swift
//  TableView_Recipes
//
//  Created by Адель Ахметшин on 21.12.2022.
//

import Foundation

extension Notification.Name {
    
    // MARK: - Update like
    static var updateLikeFromMainView: Notification.Name {
        return .init(rawValue: "User.updateLikeFromMainView") }
    
    static var updateLikeFromFavoriteView: Notification.Name {
        return .init(rawValue: "User.updateLikeFromFavoriteView") }
    
    // MARK: - Remove like
    static var removeItalianLike: Notification.Name {
        return .init(rawValue: "User.removeItalianLike") }
    
    static var removeAmericanLike: Notification.Name {
        return .init(rawValue: "User.removeAmericanLike") }
}
