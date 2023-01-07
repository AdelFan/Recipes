//
//  RecipesCell.swift
//  TableView_Recipes
//
//  Created by Адель Ахметшин on 06.10.2022.
//

import Foundation
import UIKit
import SnapKit

final class RecipesCell: UITableViewCell {
    
    var mainView: MainViewController?
    
    private var isLiked = false {
        didSet {
            if isLiked {
                likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
                mainView?.addLike(cell: self)
            } else {
                likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
                mainView?.removeLike(cell: self)
            }
        }
    }
    
    // MARK: - UI elements
    private let nameRecipe: UILabel = {
        let nameRecipe = UILabel()
        nameRecipe.font = .systemFont(ofSize: 17)
        return nameRecipe
    }()
    
    private let likeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.tintColor = .red
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        embedViews()
        setupLayout()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nameRecipe.text = ""
        likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Embed View
    private func embedViews() {
        [nameRecipe, likeButton].forEach {
            contentView.addSubview($0)
        }
    }
    
    // MARK: - Setup layout
    private func setupLayout() {
        nameRecipe.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(20)
            make.centerY.equalToSuperview()
            make.width.equalTo(270)
        }
        
        likeButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(20)
        }
    }
    
    // MARK: - Actions
    @objc private func buttonTapped(sender: UIButton) {
        isLiked.toggle()
    }
    
    // MARK: - Set cell methods
    func set(name: String) {
        nameRecipe.text = name
    }
    
    func set(isFavorite: Bool) {
        isFavorite
        ? likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        : likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
    }
}
