//
//  DetalView.swift
//  JobSearch
//
//  Created by Nickolay Vasilchenko on 20.11.2023.
//

import Foundation
import UIKit

final class DetalView: UIView {
    
    private var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = UIStackView.Distribution.equalSpacing
        return stackView
    }()
    
    private var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.bounces = true
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    private var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0)
        label.numberOfLines = 0
        return label
    }()
    
    private var salaryLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0)
        return label
    }()
    
    private var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUIFoundation() {
        scrollView.frame = self.bounds
    }
    
    private func setupView() {
        self.backgroundColor = .white
    }
    
    private func addToHierarchy() {
        
    }
    
    private func setupLayout() {
        
    }
}
