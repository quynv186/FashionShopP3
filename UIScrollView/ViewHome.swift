//
//  ViewHome.swift
//  UIScrollView
//
//  Created by QUYNV on 11/18/16.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit

class ViewHome: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{
    
    var items : [Item] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var myDict : NSDictionary?
        if let path = Bundle.main.path(forResource: "items", ofType: "plist") {
            myDict = NSDictionary(contentsOfFile: path)
        }
        
        for dic in (myDict!.allValues) as! [NSDictionary] {
            items.append(Item(name: dic["name"] as! String, content: dic["content"] as! String, nameImages: dic["images"] as! NSArray as! [String], price: dic["price"] as! String))
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CellItem
        
        cell.addSubViews(checkAddAll: true)
        cell.imgView.image = UIImage(named: items[indexPath.item].nameImages[0] + ".jpg")
        cell.nameLabel.text = items[indexPath.item].name
        cell.price.text = items[indexPath.item].price
        
        return cell
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let listView = self.storyboard?.instantiateViewController(withIdentifier: "ViewDetailShop") as! ListImages
        
        listView.item = items[indexPath.item]
        self.navigationController?.pushViewController(listView, animated: true)
    }

}
