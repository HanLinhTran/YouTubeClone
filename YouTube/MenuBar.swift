//
//  MenuBar.swift
//  YouTube
//
//  Created by Tran's Macpro on 3/5/17.
//  Copyright © 2017 THL. All rights reserved.
//

import UIKit


// create object has name Menubar inreheit UIView because Collection View inreheit UIView
class MenuBar: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    // in MenuBar has collectionView, atribute lazy var will calls on collectionView create finsher
   lazy var colletionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.rgb(red: 230, green: 32, blue: 31)
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()
    
    let cellId = "cellId"
    let imageNames = ["home","trending","subscription","account"]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        colletionView.register(MenuCell.self, forCellWithReuseIdentifier: cellId)
        
        addSubview(colletionView)
        
        addContrainsWithVisualFormat(format: "H:|[v0]|", views: colletionView)
        addContrainsWithVisualFormat(format: "V:|[v0]|", views: colletionView)
        
        let seletedIndexPath = NSIndexPath(item: 0, section: 0)
        colletionView.selectItem(at: seletedIndexPath as IndexPath, animated: false, scrollPosition: .centeredHorizontally)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = colletionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MenuCell
        cell.imageView.image = UIImage(named: imageNames[indexPath.item])?.withRenderingMode(.alwaysTemplate)
        cell.tintColor = UIColor.rgb(red: 91, green: 14, blue: 13)
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width / 4, height: frame.height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class MenuCell: BaseCell {
    
    let imageView: UIImageView = {
       let img = UIImageView()
        img.image = UIImage(named: "Home")?.withRenderingMode(.alwaysTemplate)
        img.tintColor = UIColor.rgb(red: 91, green: 14, blue: 13)
        
        return img
    }()
    
    override var isHighlighted: Bool {
        didSet {
            imageView.tintColor = isHighlighted ? UIColor.white : UIColor.rgb(red: 91, green: 14, blue: 13)
        }
    }
    override var isSelected: Bool{
        didSet {
            imageView.tintColor = isSelected ? UIColor.white : UIColor.rgb(red: 91, green: 14, blue: 13)
        }
    }
    
    
    override func setupView() {
        super.setupView()
        
        addSubview(imageView)
       
        addContrainsWithVisualFormat(format: "H:[v0(22)]", views: imageView)
        addContrainsWithVisualFormat(format: "V:[v0(22)]", views: imageView)
        
        addConstraint(NSLayoutConstraint(item: imageView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: imageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        
        
    }
}









