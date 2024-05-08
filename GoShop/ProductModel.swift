//
//  ProductModel.swift
//  GoShop
//
//  Created by MAC on 02/01/2024.
//

import Foundation

// MARK: - Product

class Product: Codable {
    let id, price, oldPrice, discount: Double?
    let image: String?
    let name, description: String?
    var inFavorites, inCart: Bool?
    let images: [String]?
    init() {
        self.id = 0
        self.price = 0
        self.oldPrice = 0
        self.discount = 0
        self.image = "image"
        self.name = "name"
        self.description = "description"
        self.inFavorites = false
        self.inCart = false
        self.images = []
    }
    enum CodingKeys: String, CodingKey {
        case id, price
        case oldPrice = "old_price"
        case discount, image, name, description
        case inFavorites = "in_favorites"
        case inCart = "in_cart"
        case images
    }
}
