//
//  FavoriteViewController.swift
//  TableView_Recipes
//
//  Created by Адель Ахметшин on 21.10.2022.
//

import UIKit
import SnapKit

final class FavoriteViewController: UIViewController {
    
    var presenter: FavoriteViewPresenterProtocol!
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        return tableView
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        embedView()
        setupAppearance()
        setupBehavior()
        setupLayout()
    }
    
    // MARK: - Embed view
    private func embedView() {
        view.addSubview(tableView)
    }
    
    // MARK: - Setup appearance
    private func setupAppearance() {
        title = "Favorite"
        view.backgroundColor = .white
    }
    
    // MARK: - Setup behavior
    private func setupBehavior() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(FavoritesCell.self, forCellReuseIdentifier: .favoritesCell)
        presenter.likeService.notificationCenterFavoriteView.addObserver(
            self,
            selector: #selector(addLike),
            name: .updateLikeFromMainView,
            object: nil
        )
        presenter.likeService.notificationCenterFavoriteView.addObserver(
            self,
            selector: #selector(removeItalianLike),
            name: .removeItalianLike,
            object: nil
        )
        presenter.likeService.notificationCenterFavoriteView.addObserver(
            self,
            selector: #selector(removeAmericanLike),
            name: .removeAmericanLike,
            object: nil
        )
        presenter.configureCells()
    }
    
    // MARK: - Setup layout
    private func setupLayout() {
        tableView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.bottom.equalToSuperview()
        }
    }
    
    // MARK: - Actions
    @objc private func addLike(_ notification: Notification) {
        presenter.addLike()
    }
    
    @objc private func removeItalianLike(_ notification: Notification) {
        guard let recipe = notification.object as? Recipe else { return }
        presenter.removeRecipe(type: .italian, recipe: recipe)
    }
    
    @objc private func removeAmericanLike(_ notification: Notification) {
        guard let recipe = notification.object as? Recipe else { return }
        presenter.removeRecipe(type: .american, recipe: recipe)
    }
}

// MARK: - UITableViewDataSource & UITableViewDelegate
extension FavoriteViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return presenter.italianRecipes.count
        case 1: return presenter.americanRecipes.count
        default: break
        }
        return 10
    }
    
    // MARK: - NumberOfSections
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    // MARK: - TitileForHeaderInSection
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0: return "Italian Recipes"
        case 1: return "American Recipes"
        default: return "RECIPES"
        }
    }
    
    // MARK: - cellForRowAt
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: .favoritesCell,
            for: indexPath
        )  as? FavoritesCell else { return UITableViewCell() }
        
        let recipeName: String = indexPath.section == 0
        ? presenter.italianRecipes[indexPath.row].title
        : presenter.americanRecipes[indexPath.row].title
        
        cell.configure(recipe: recipeName)
        
        return cell
    }
    
    // MARK: - didSelectRowAt
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            presenter.showDetailViewController(view: self, recipe: presenter.italianRecipes[indexPath.row])
            tableView.deselectRow(at: indexPath, animated: true)
        case 1:
            presenter.showDetailViewController(view: self, recipe: presenter.americanRecipes[indexPath.row])
            tableView.deselectRow(at: indexPath, animated: true)
        default: break
        }
    }
    
    // MARK: - editActionsForRowAt
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete", handler: { _, indexPath in
            switch indexPath.section {
            case 0:
                self.presenter.removeRecipe(key: self.presenter.italianRecipes[indexPath.row].title, recipe: indexPath.row, type: .italian)
                self.presenter.likeService.notificationCenterMainView.post(name: .updateLikeFromFavoriteView, object: nil)
            case 1:
                self.presenter.removeRecipe(key: self.presenter.americanRecipes[indexPath.row].title, recipe: indexPath.row, type: .american)
                self.presenter.likeService.notificationCenterMainView.post(name: .updateLikeFromFavoriteView, object: nil)
            default: break
            }
        })
        return [deleteAction]
    }
}

// MARK: - FavoriteViewProtocol
extension FavoriteViewController: FavoriteViewProtocol {
    func success() {
        tableView.reloadData()
    }
    
    func failure(error: Error) {
        print(error.localizedDescription)
    }
}

private extension String {
    static let favoritesCell = "FavoritesCell"
}
