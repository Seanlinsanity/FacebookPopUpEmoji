//
//  IconsContainerView.swift
//  FacebookPopUpAnimation
//
//  Created by SEAN on 2018/7/12.
//  Copyright © 2018年 SEAN. All rights reserved.
//

import UIKit

class IconsContainerView: UIView {
    
    let iconHeight: CGFloat = 38
    let padding: CGFloat = 6
    let images =  [#imageLiteral(resourceName: "blue_like"), #imageLiteral(resourceName: "red_heart"), #imageLiteral(resourceName: "surprised"), #imageLiteral(resourceName: "cry_laugh"), #imageLiteral(resourceName: "cry"), #imageLiteral(resourceName: "angry")]
    var containerWidth: CGFloat?
    var containerHeight: CGFloat?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let numIcons = CGFloat(images.count)
        self.containerWidth = numIcons * iconHeight + (numIcons + 1) * padding
        self.containerHeight = iconHeight + 2 * padding
        
        setupContainerUI()
        setupStackView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupContainerUI(){
        backgroundColor = .white
        layer.cornerRadius = (containerHeight ?? 0) / 2
        layer.shadowColor = UIColor(white: 0.4, alpha: 0.4).cgColor
        layer.shadowRadius = 8
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 0, height: 4)
    }
    
    private func setupStackView(){
        
        let arrangedSubviews = images.map({ (image) -> UIImageView in
            let iv = UIImageView()
            iv.image = image
            iv.layer.cornerRadius = iconHeight / 2
            //require for hit testing
            iv.isUserInteractionEnabled = true
            return iv
        })
        
        let stackView = UIStackView(arrangedSubviews: arrangedSubviews)
        stackView.distribution = .fillEqually
        stackView.spacing = padding
        stackView.layoutMargins = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(stackView)
        stackView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        stackView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        stackView.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
    }
    
}
