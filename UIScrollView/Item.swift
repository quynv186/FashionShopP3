//
//  Item.swift
//  UIScrollView
//
//  Created by QUYNV on 11/18/16.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit

class Item : NSObject {
    var name : String?
    var content : String?
    var nameImages : [String] = []
    var price : String?
    
    init(name : String, content : String, nameImages : [String], price : String) {
        self.name = name
        self.content = content
        self.nameImages = nameImages
        self.price = price
    }
}
