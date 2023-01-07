//
//  IngredientsViewCell.swift
//  TableView_Recipes
//
//  Created by Адель Ахметшин on 09.11.2022.
//

import UIKit
import SnapKit
import Kingfisher

class IngredientsViewCell: UICollectionViewCell {
    static let identifier = "IngredietnsViewCell"
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 5
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let ingredientTitle: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        label.numberOfLines = 2
        label.lineBreakMode = .byTruncatingHead
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        contentView.addSubview(ingredientTitle)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // ImageView
        imageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(130)
            make.width.equalTo(160)
        }
        
        // Recipe title
        ingredientTitle.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(imageView.snp.bottom).offset(25)
            make.width.equalTo(140)
            make.bottom.equalToSuperview()
        }
    }
    
    // MARK: - Configure
    func configure(with model: Ingredient) {
        let url = URL(string: "\(Constants.imageURL)\(model.image)")
            imageView.kf.indicatorType = .activity
            imageView.kf.setImage(with: url)
            ingredientTitle.text = model.name
    }
}
