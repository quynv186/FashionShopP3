//
//  CellItem.swift
//  UIScrollView
//
//  Created by QUYNV on 11/21/16.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit

class CellItem : UICollectionViewCell {
    var nameLabel : UILabel!
    var imgView : UIImageView!
    var price : UILabel!
    var kPriceLabelHeight : CGFloat = 30
    var kCellWidth : CGFloat = 100
    var kLabelHeight : CGFloat = 30
    
    override init(frame : CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func addSubViews(checkAddAll : Bool) {
        if (imgView == nil) {
            imgView = UIImageView(frame: CGRect(x: 0, y: 0, width: kCellWidth, height: kCellWidth))
            imgView.layer.borderColor = tintColor.cgColor
            imgView.contentMode = .scaleAspectFit
            
            contentView.addSubview(imgView)
        }
        if (checkAddAll) {
            if (nameLabel == nil) {
                nameLabel = UILabel(frame: CGRect(x: 0, y: kCellWidth, width: kCellWidth, height: kLabelHeight))
                nameLabel.textAlignment = .left
                nameLabel.textColor = UIColor(white: 0.9, alpha : 1.0)
                nameLabel.highlightedTextColor = tintColor
                nameLabel.font = UIFont.systemFont(ofSize: 10)
                nameLabel.numberOfLines = 2
                
                contentView.addSubview(nameLabel)
            }
            
            if (price == nil) {
                price = UILabel(frame: CGRect(x: 0, y: kCellWidth + kLabelHeight, width: kCellWidth, height: kPriceLabelHeight))
                price.textAlignment = .left
                price.textColor = UIColor(red: 255/255, green: 116/255, blue: 35/255, alpha: 1)
                price.font = UIFont.boldSystemFont(ofSize: 12)
                
                contentView.addSubview(price)
            }
        }
    }
    
    override var isSelected: Bool {
        didSet{
            imgView.layer.borderWidth = isSelected ? 2 : 0
        }
    }
}
