//
//  Video.swift
//  YouTube
//
//  Created by Tran's Macpro on 3/7/17.
//  Copyright © 2017 THL. All rights reserved.
//

import UIKit


class Video: NSObject {
    
    var thumbnailImageName: String?
    var title: String?
    var channel: Channel?
    var numberOfViews: NSNumber?
    var uploadDate: Date?
    
}

class Channel: NSObject {
    
    var name: String?
    var profileImageName: String?
}
