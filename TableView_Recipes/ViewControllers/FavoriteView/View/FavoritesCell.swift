//
//  FavoritesCell.swift
//  TableView_Recipes
//
//  Created by Адель Ахметшин on 21.10.2022.
//

import UIKit
import SnapKit

class FavoritesCell: UITableViewCell {

    private let nameRecipe: UILabel = {
        let nameRecipe = UILabel()
        nameRecipe.font = .systemFont(ofSize: 17)
        return nameRecipe
    }()
    
    private var likeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        button.tintColor = .red
        return button
    }()
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nameRecipe.text = ""
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Settings
    private func setupCell() {
        [nameRecipe, likeButton].forEach {
            contentView.addSubview($0)
        }
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
    
    // MARK: - Configure cell
    func configure(recipe: String) {
        nameRecipe.text = recipe
    }
}
