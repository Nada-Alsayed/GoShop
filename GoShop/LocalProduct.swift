//
//  Products.swift
//  GoShop
//
//  Created by MAC on 13/12/2023.
//

import Foundation
import RealmSwift

class LocalProduct : Object{
    
    @objc dynamic var id = 0
    @objc dynamic var price = 0
    @objc dynamic var oldPrice = 0
    @objc dynamic var discount = 0
    @objc dynamic var image: String?
    @objc dynamic var name : String?
    @objc dynamic var desc: String?
    @objc dynamic var inFavorites = false
    @objc dynamic var inCart = false
    var images = List<String>()
    
    
}
