//
//  HeaderCollectionReusableView.swift
//  TableView_Recipes
//
//  Created by Адель Ахметшин on 08.11.2022.
//

import UIKit
import SnapKit
import Kingfisher

class HeaderCollectionReusableView: UICollectionReusableView, UIScrollViewDelegate {
    static let identifier = "HeaderCollectionReusableView"
    
    private var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.minimumZoomScale = 0.5
        scrollView.maximumZoomScale = 5.0
        return scrollView
    }()
    
    private let imageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.layer.masksToBounds = true
        image.layer.cornerRadius = 7
        return image
    }()
    
    private let recipeTitle: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }()
    
    private let stripeView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray4
        return view
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        scrollView.delegate = self
        addSubview(scrollView)
        scrollView.addSubview(imageView)
        addSubview(recipeTitle)
        addSubview(stripeView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // ScrollView
        scrollView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(140)
            make.width.height.equalTo(260)
        }
        
        // ImageView
        imageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(140)
            make.width.height.equalTo(260)
        }
        
        // Recipe title
        recipeTitle.snp.makeConstraints { make in
            make.leading.trailing.equalTo(imageView)
            make.top.equalTo(imageView.snp.bottom).offset(12)
        }
        
        // Stripe View
        stripeView.snp.makeConstraints { make in
            make.top.equalTo(recipeTitle.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.width.equalTo(350)
            make.height.equalTo(1)
        }
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    // MARK: - Configure
    func configure(with model: Recipe) {
        let url = URL(string: model.image)
        imageView.kf.indicatorType = .activity
        imageView.kf.setImage(with: url)
        recipeTitle.text = model.title
    }
}
