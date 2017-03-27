//
//  SettingCell.swift
//  YouTube
//
//  Created by Tran's Macpro on 3/21/17.
//  Copyright © 2017 THL. All rights reserved.
//

import UIKit

class SettingCell: BaseCell {
    override var isHighlighted: Bool{
        didSet{
            backgroundColor = isHighlighted ? UIColor.lightGray : UIColor.white
            nameLabel.textColor = isHighlighted ? UIColor.white : UIColor.black
            iconImageView.tintColor = isHighlighted ? UIColor.white : UIColor.darkGray
        }
    }
    
    var setting: Setting? {
        didSet{
            nameLabel.text = setting?.name
            if let imageName = setting?.imageName{
                 iconImageView.image = UIImage(named: imageName)?.withRenderingMode(.alwaysTemplate)
                 iconImageView.tintColor = UIColor.darkGray
                
            }
           
        }
    }
    
    let nameLabel:UILabel = {
       let label = UILabel()
        label.text = "Setting"
        label.font = UIFont.systemFont(ofSize: 13)
        
        return label
    }()
    let iconImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.image = UIImage(named: "settings")
        return imageView
    }()
    override func setupView() {
        super.setupView()
        addSubview(nameLabel)
        addSubview(iconImageView)
        addContrainsWithVisualFormat(format: "V:|[v0]|", views: nameLabel)
        
        addContrainsWithVisualFormat(format: "H:|-8-[v0(30)]-8-[v1]|", views:iconImageView, nameLabel)
        addContrainsWithVisualFormat(format: "V:[v0(30)]", views: iconImageView)
        addConstraint(NSLayoutConstraint(item: iconImageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
    }
}
