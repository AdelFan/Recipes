//
//  MainViewController.swift
//  TableView_Recipes
//
//  Created by Адель Ахметшин on 06.10.2022.
//

import UIKit
import SnapKit

final class MainViewController: UIViewController {
    
    // MARK: - Presenter & Like service
    var presenter: MainViewPresenterProtocol!
    var likeService: LikeServiceProtocol!
    
    // MARK: - Search elements
    private var searchRecipes = [Recipe]()
    
    private var isSearchBarEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    
    private var isFiltering: Bool { //
        return searchController.isActive && !isSearchBarEmpty
    }
    
    // MARK: - UI elements
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        return tableView
    }()
    
    private let searchController: UISearchController = {
        let search = UISearchController(searchResultsController: nil)
        return search
    }()
    
    private let segmentControl: UISegmentedControl = {
        let segmentControl = UISegmentedControl(items: ["Italian","American"])
        segmentControl.selectedSegmentIndex = 0
        segmentControl.backgroundColor = .white
        segmentControl.addTarget(self, action: #selector(tapSegmentControl), for: .valueChanged)
        segmentControl.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Arial", size: 17)], for: .normal)
        return segmentControl
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
        view.addSubview(segmentControl)
    }
    
    // MARK: - Setup appearance
    private func setupAppearance() {
        title = "Recipes"
        view.backgroundColor = .white
        self.navigationController?.navigationBar.tintColor = .secondarySystemBackground
    }
    
    // MARK: - Setup behavior
    private func setupBehavior() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(RecipesCell.self, forCellReuseIdentifier: "Cell")
        
        likeService.notificationCenterMainView.addObserver(
            self,
            selector: #selector(notificationUpdateLike),
            name: .updateLikeFromFavoriteView,
            object: nil
        )
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
        
        definesPresentationContext = true
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    // MARK: - Setup layout
    private func setupLayout() {
        segmentControl.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(30)
            make.top.equalToSuperview().offset(160)
            make.height.equalTo(30)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(200)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    // MARK: - Update likes
    @objc private func notificationUpdateLike(_ notification: Notification) {
        tableView.reloadData()
    }
    
    // MARK: - Update segment control
    @objc private func tapSegmentControl(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            presenter.tapSegmentControl(type: .italian)
        case 1:
            presenter.tapSegmentControl(type: .american)
        default: break
        }
    }
}

// MARK: - UITableViewDataSource
extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        isFiltering ? searchRecipes.count : presenter.recipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "Cell",
            for: indexPath
        ) as? RecipesCell else { return UITableViewCell() }
        
        let recipeName: String = isFiltering
        ? searchRecipes[indexPath.row].title
        : presenter.recipes[indexPath.row]
        
        cell.mainView = self
        cell.set(isFavorite: likeService.favoriteRecipe(nameRecipe: recipeName))
        cell.set(name: recipeName)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isFiltering {
            presenter.showDetailViewController(view: self, recipe: searchRecipes[indexPath.row])
            tableView.deselectRow(at: indexPath, animated: true)
        } else {
            switch segmentControl.selectedSegmentIndex {
            case 0:
                presenter.showDetailViewController(view: self, recipe: presenter.italianRecipes![indexPath.row])
                tableView.deselectRow(at: indexPath, animated: true)
            case 1:
                presenter.showDetailViewController(view: self, recipe: presenter.americanRecipes![indexPath.row])
                tableView.deselectRow(at: indexPath, animated: true)
            default: break
            }
        }
    }
}

// MARK: - UITableViewDelegate
extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

// MARK: - UISearchResultsUpdating
extension MainViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let text = searchController.searchBar.text {
            filterContentForSearchText(text)
        }
    }
    
    private func filterContentForSearchText(_ searchText: String) {
        switch segmentControl.selectedSegmentIndex {
        case 0:
            searchRecipes = presenter.filterContentForSearchText(type: .italian, searchText: searchText)
            tableView.reloadData()
        case 1:
            searchRecipes = presenter.filterContentForSearchText(type: .american, searchText: searchText)
            tableView.reloadData()
        default: break
        }
    }
}

// MARK: - Add like
extension MainViewController {
    func addLike(cell: UITableViewCell) {
        guard let indexPathTapped = tableView.indexPath(for: cell) else { return }
        switch segmentControl.selectedSegmentIndex {
        case 0:
            let recipe = presenter.italianRecipes![indexPathTapped.row]
            likeService.addLike(type: .italian, and: recipe)
            likeService.notificationCenterFavoriteView.post(name: .updateLikeFromMainView, object: nil)
        case 1:
            let recipe = presenter.americanRecipes![indexPathTapped.row]
            likeService.addLike(type: .american, and: recipe)
            likeService.notificationCenterFavoriteView.post(name: .updateLikeFromMainView, object: nil)
            
        default: break
        }
    }
    
    // MARK: - Remove like
    func removeLike(cell: UITableViewCell) {
        guard let indexPathTapped = tableView.indexPath(for: cell) else { return }
        switch segmentControl.selectedSegmentIndex {
        case 0:
            let recipe = presenter.italianRecipes![indexPathTapped.row]
            likeService.removeLike(type: .italian, and: recipe)
            likeService.notificationCenterFavoriteView.post(name: .removeItalianLike, object: recipe)
        case 1:
            let recipe = presenter.americanRecipes![indexPathTapped.row]
            likeService.removeLike(type: .american, and: recipe)
            likeService.notificationCenterFavoriteView.post(name: .removeAmericanLike, object: recipe)
            
        default: break
        }
    }
}

// MARK: - MainViewProtocol
extension MainViewController: MainViewProtocol {
    func success() {
        tableView.reloadData()
    }
    
    func failure(error: Error) {
        print(error.localizedDescription)
    }
}
