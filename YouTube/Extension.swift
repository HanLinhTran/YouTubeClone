//
//  Extension.swift
//  YouTube
//
//  Created by Tran's Macpro on 3/4/17.
//  Copyright © 2017 THL. All rights reserved.
//

import UIKit

// custom color RGB
extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
}

// Autolayout with Syntax Visual Format
extension UIView {
    func addContrainsWithVisualFormat(format: String, views: UIView...) {
        var viewsDictionary = [String : UIView]()
        for(index, view) in views.enumerated(){
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDictionary[key] = view
        }
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
        
    }
    
}
let imageCache = NSCache<AnyObject, AnyObject>()


class customImageView: UIImageView {
    
    var ImageUrlString: String?
    
    func loadImageUsingUrlString(urlString: String) {
        let url = URL(string: urlString)
        ImageUrlString = urlString
        
        
        image = nil
        
        if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            self.image = imageFromCache
            return
        }
        URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
            
            if error != nil {
                print(error!)
                return
            }
            
            DispatchQueue.main.async(execute: {
                let imageToCache = UIImage(data: data!)
                
                if self.ImageUrlString == urlString{
                    self.image = imageToCache
                }
                
                imageCache.setObject(imageToCache!, forKey: urlString as AnyObject)
            })
            
            
        }).resume()
        
    }
}
