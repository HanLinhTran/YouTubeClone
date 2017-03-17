//
//  VideoCell.swift
//  YouTube
//
//  Created by Tran's Macpro on 3/4/17.
//  Copyright © 2017 THL. All rights reserved.
//

import UIKit

// create subclass BaseCell and class (UICollectionViewCell) inreheit BaseCell 
class BaseCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    func setupView() {
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// create CollectionViewCell
class VideoCell: BaseCell {
    
    var video: Video? {
        // use didset to do updateUI
        didSet {
            
            // update UI titlelabel 
            titleLabel.text = video?.title
            setupThumbnailImage()
            
            setupProfileImage()
            
            // update UI Image useProfile
//            if let profileImageName = video?.channel?.profileImageName {
//                useProfileImageView.image = UIImage(named: profileImageName)
//                
//            
//            }
            // update subTitleTextView and unwrap optional
            if let channelName = video?.channel?.name, let numberView = video?.numberOfViews {
                // formater numberView has dot or comma
                let numberFormatter = NumberFormatter()
                numberFormatter.numberStyle = .decimal
              
                let subtitleText = "\(channelName) . \(numberFormatter.string(from: numberView)!) . 2 year ago "
                subTitleTextView.text = subtitleText
            }
            //measure title text
            if let title = video?.title {
                let size = CGSize(width: frame.width - 16 - 44 - 8 - 16, height: 1000)
                let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
                let estimatedRect = NSString(string: title).boundingRect(with: size, options: options, attributes: [NSFontAttributeName : UIFont.systemFont(ofSize: 14)], context: nil)
                
                if estimatedRect.size.height > 20 {
                    titleLabelHeightContrains?.constant = 44
                }else{
                    titleLabelHeightContrains?.constant = 20
                }
                
            }
            
        }

    }
    

func setupProfileImage() {
    if let profileImageUrl = video?.channel?.profileImageName {
        
        useProfileImageView.loadImageUsingUrlString(urlString: profileImageUrl)
    }
}


    func setupThumbnailImage() {
        if let thumbnailImageUrl = video?.thumbnailImageName {
            thumbnailImageView.loadImageUsingUrlString(urlString: thumbnailImageUrl)
        }
    }
    
    // custom imageView in CollectionView Cell
    let thumbnailImageView: customImageView = {
        let imageView = customImageView()
        imageView.image = UIImage(named: "manh_niu")
        // custom content mode scaletofit image with frame imageView
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        return imageView 
    }()
    
    let useProfileImageView : customImageView = {
        let imageView = customImageView()
        imageView.image = UIImage(named: "manh_niudiu")
        imageView.layer.cornerRadius = 22
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    let separatorView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        
        return view
    }()
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "ManhTran DNA - Khoai Trôi"
        label.numberOfLines = 2
        return label
    }()
    
    
    
    let subTitleTextView : UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.text = "ManhTranVEVO . 1,265,648,589 views . 15 years ago"
        textView.textContainerInset = UIEdgeInsetsMake(0, -4, 0, 0)
        textView.textColor = UIColor.lightGray
        return textView
    }()
    
    var titleLabelHeightContrains: NSLayoutConstraint?
    
    override func setupView() {
        addSubview(thumbnailImageView)
        addSubview(separatorView)
        addSubview(useProfileImageView)
        addSubview(titleLabel)
        addSubview(subTitleTextView)
        
        addContrainsWithVisualFormat(format: "H:|-16-[v0]-16-|", views: thumbnailImageView)
        addContrainsWithVisualFormat(format: "H:|-16-[v0(44)]|", views: useProfileImageView)
        addContrainsWithVisualFormat(format: "V:|-16-[v0]-8-[v1(44)]-36-[v2(1)]|", views: thumbnailImageView,useProfileImageView, separatorView)
        addContrainsWithVisualFormat(format: "H:|[v0]|", views: separatorView)
        // top contrains
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: thumbnailImageView, attribute: .bottom, multiplier: 1, constant: 8))
        // left contrains
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .left, relatedBy: .equal, toItem: useProfileImageView, attribute: .right, multiplier: 1, constant: 8))
        // right contrains
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .right, relatedBy: .equal, toItem: thumbnailImageView, attribute: .right, multiplier: 1, constant: 0))
        // Height contrains
        titleLabelHeightContrains = NSLayoutConstraint(item: titleLabel, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 44)
        addConstraint(titleLabelHeightContrains!)
        
        // top contrains
        addConstraint(NSLayoutConstraint(item: subTitleTextView, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1, constant: 4))
        // left contrains
        addConstraint(NSLayoutConstraint(item: subTitleTextView, attribute: .left, relatedBy: .equal, toItem: useProfileImageView, attribute: .right, multiplier: 1, constant: 8))
        // right contrains
        addConstraint(NSLayoutConstraint(item: subTitleTextView, attribute: .right, relatedBy: .equal, toItem: thumbnailImageView, attribute: .right, multiplier: 1, constant: 0))
        // Height contrains
        addConstraint(NSLayoutConstraint(item: subTitleTextView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 30))
        
    }
    
    
}
