//
//  ListImages.swift
//  UIScrollView
//
//  Created by QUYNV on 11/21/16.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit

class ListImages : UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var nameShop: UILabel!
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var contentShop: UITextView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var item : Item!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        nameShop.text = item.name
        contentShop.text = item.content
        imgProfile.image = UIImage(named: item.nameImages[0] + ".jpg")
        imgProfile.isUserInteractionEnabled = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapImgView))
        imgProfile.addGestureRecognizer(tap)
    }
    
    func pushView(index : Int) {
        let listView = self.storyboard?.instantiateViewController(withIdentifier: "ViewScroll") as! ViewScroll
        listView.currentPage = index
        listView.pageImages = item.nameImages
        self.navigationController?.pushViewController(listView, animated: true)
    }
    
    func tapImgView() {
        pushView(index: 0)
        
    }
    
    //delegate collection
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return item.nameImages.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CellItem
        cell.kCellWidth = 60
        cell.addSubViews(checkAddAll: false)
        cell.imgView.contentMode = .scaleAspectFit
        cell.imgView.image = UIImage(named: item.nameImages[indexPath.item] + ".jpg")
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        pushView(index: indexPath.item)
    }
}
