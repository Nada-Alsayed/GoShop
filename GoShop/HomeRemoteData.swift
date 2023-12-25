//
//  RemoteData.swift
//  GoShop
//
//  Created by MAC on 13/12/2023.
//

import Foundation

// MARK: - BaseResponse
class BaseResponse<T: Codable>: Codable {
    let status: Bool?
    let message: String?
    let data: T?
}

// MARK: - HomeData
class HomeData: Codable {
    let banners: [Banner]?
    let products: [Product]?
    let ad: String?
}

class Banner: Codable {
    let id: Int
    let image: String?
    let category, product: String?
}

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

// MARK: - Data
class MyData <T: Codable>: Codable {
    let data: T
}

class DataClass: Codable {
    let cartItems: [Favourite]
    let subTotal, total: Double

    enum CodingKeys: String, CodingKey {
        case cartItems = "cart_items"
        case subTotal = "sub_total"
        case total
    }
}

// MARK: - Datum
class Favourite: Codable {
    let id: Int
    let product: Product
}

// MARK: - CategoryData
class CategoryData: Codable {
    let data: [Category]
}

// MARK: - Category
class Category: Codable {
    let id: Int?
    let name: String?
    let image: String?
}
