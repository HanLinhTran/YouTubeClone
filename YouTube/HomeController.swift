//
//  ViewController.swift
//  YouTube
//
//  Created by Tran's Macpro on 3/3/17.
//  Copyright © 2017 THL. All rights reserved.
//

import UIKit



class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    // create a array video
//    var videos: [Video] = {
//        
//        var ManhTranChannel = Channel()
//        ManhTranChannel.name = "ManhTranDNAChannel"
//        ManhTranChannel.profileImageName = "manh_niu"
//        
//        
//       var blackSpaceVideo = Video()
//        blackSpaceVideo.title = "Taylor Swift - Black Space"
//        blackSpaceVideo.thumbnailImageName = "TaylorSwift_BlackSpace"
//        blackSpaceVideo.channel = ManhTranChannel
//        blackSpaceVideo.numberOfViews = 1200544345
//       var badBloodVideo = Video()
//        badBloodVideo.title = "Taylor Swift - Bad Blood featuring Kendrick lamar"
//        badBloodVideo.thumbnailImageName = "TaylorSwift_bloodType"
//        badBloodVideo.channel = ManhTranChannel
//        badBloodVideo.numberOfViews = 12423435345
//        return [blackSpaceVideo, badBloodVideo]
//        
//    }()
    var videos: [Video]?
    
    func fetchVideos() {
        let url = URL(string: "https://s3-us-west-2.amazonaws.com/youtubeassets/home.json")
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            
            // test request to sever load data error
            if error != nil{
                print(error!)
            }
            do {
             let json = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers)
                self.videos = [Video]()
                
                for dictionary in json as! [[String : AnyObject]] {
                let video = Video()
                    video.title = dictionary["title"]! as? String
                    video.thumbnailImageName = dictionary["thumbnail_image_name"] as? String
                    let channelDictionary = dictionary["channel"] as! [String : AnyObject]
                    let channel = Channel()
                    channel.name = channelDictionary["name"] as? String
                    channel.profileImageName = channelDictionary["profile_image_name"] as? String
                    video.channel = channel
                    self.videos?.append(video)
                
                }
                DispatchQueue.main.async(execute: { 
                    self.collectionView?.reloadData()
                })
                
            }catch let jsonError {
                print(jsonError)
            }
            
           
        }.resume()
        
    }

    override func viewDidLoad() {
        fetchVideos()
        
        super.viewDidLoad()
        navigationItem.title = "Home"
        navigationController?.navigationBar.isTranslucent = false
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width  - 32, height: view.frame.height))
        titleLabel.text = "Home"
        titleLabel.textColor = UIColor.white

        titleLabel.font = UIFont.systemFont(ofSize: 20)
        navigationItem.titleView = titleLabel
        collectionView?.backgroundColor = UIColor.white
        // register CollectionViewCell
        collectionView?.register(VideoCell.self, forCellWithReuseIdentifier: "cellId")
        // scroll area around content CollectionView with Menubar
        collectionView?.contentInset = UIEdgeInsetsMake(50, 0, 0, 0)
        collectionView?.scrollIndicatorInsets = UIEdgeInsetsMake(50, 0, 0, 0)
        
        setUpMenuBar()
        setupNavBarButton()
        
       
    }
    func setupNavBarButton() {
        let searchImage = UIImage(named: "search")?.withRenderingMode(.alwaysOriginal)
        let searchBarButtonItem = UIBarButtonItem(image: searchImage, style: .plain, target: self, action: #selector(handleSearch))
        let moreImage = UIImage(named: "more")?.withRenderingMode(.alwaysOriginal)
        let moreButton = UIBarButtonItem(image: moreImage, style: .plain, target: self, action: #selector(handleMore))
        navigationItem.rightBarButtonItems = [moreButton, searchBarButtonItem]
    }
  
    let settingsLaucher = SettingsLaucher()
    
    func handleMore() {
        
       settingsLaucher.showSetting()
    }
    func handleSearch () {
        print(123)
    }
    //handleDissmiss more Button
   
    // create menuBar in collection View use customize Menubar for collection View
    let menuBar : MenuBar = {
        let mb = MenuBar()
        return mb
    }()
    
    private func setUpMenuBar() {
        view.addSubview(menuBar)
        view.addContrainsWithVisualFormat(format: "H:|[v0]|", views: menuBar)
        view.addContrainsWithVisualFormat(format: "V:|[v0(50)]|", views: menuBar)
    }
    // Custom CollectionView
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videos?.count ?? 0
        
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! VideoCell
        cell.video = videos?[indexPath.item]
      
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let heights = (view.frame.height - 16 - 16 ) * 9 / 16
        return CGSize(width: view.frame.width, height: heights + 16 + 80)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }


}



