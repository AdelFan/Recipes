//
//  TabBarController.swift
//  TableView_Recipes
//
//  Created by Адель Ахметшин on 06.10.2022.
//

import Foundation
import UIKit

final class TabBarController: UITabBarController, UITabBarControllerDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let vc1 = AssemblyBuilder.createMainModule()
        let vc2 = AssemblyBuilder.createFavoriteModule()
        
        vc1.navigationItem.largeTitleDisplayMode = .never
        vc2.navigationItem.largeTitleDisplayMode = .never
        
        let nav1 = UINavigationController(rootViewController: vc1)
        let nav2 = UINavigationController(rootViewController: vc2)
        
        nav1.navigationBar.tintColor = .white
        nav2.navigationBar.tintColor = .white
        
        nav1.tabBarItem = UITabBarItem(title: "LIST", image: UIImage(systemName: "fork.knife.circle"), selectedImage: UIImage(systemName: "fork.knife.circle.fill"))
        nav2.tabBarItem = UITabBarItem(title: "Favorite", image: UIImage(systemName: "heart"), selectedImage: UIImage(systemName: "heart.fill"))
        
        nav1.navigationBar.prefersLargeTitles = true
        nav2.navigationBar.prefersLargeTitles = true
        
        setViewControllers([nav1, nav2], animated: false)
    }
}
