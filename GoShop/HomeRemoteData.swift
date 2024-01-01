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
    let data: T?
}

struct SubCart: Codable {
    let cart: Favourite
    let subTotal, total: Int

    enum CodingKeys: String, CodingKey {
        case cart
        case subTotal = "sub_total"
        case total
    }
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
    let quantity: Int
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

struct Address: Codable {
    let name, city, region, details: String
    let latitude, longitude: Double
    let notes: String?
    let id: Int
    init(name: String, city: String, region: String, details: String, latitude: Double, longitude: Double, notes: String?, id: Int) {
        self.name = name
        self.city = city
        self.region = region
        self.details = details
        self.latitude = latitude
        self.longitude = longitude
        self.notes = notes
        self.id = id
    }
    init() {
        self.name = ""
        self.city = ""
        self.region = ""
        self.details = ""
        self.latitude = 0
        self.longitude = 0
        self.notes = ""
        self.id = 0
    }
}

struct Order: Codable {
    let paymentMethod: String
    let cost: Int
    let vat: Double
    let discount, points: Int
    let total: Double
    let id: Int
    
    enum CodingKeys: String, CodingKey {
        case paymentMethod = "payment_method"
        case cost, vat, discount, points, total, id
    }
}
struct Datum: Codable {
    let id: Int?
    let total: Double?
    let date: String?
    let status: String?
}

struct OrderDetails: Codable {
    let id, cost, discount, points: Int
    let vat, total: Double
    let pointsCommission: Int
    let promoCode, paymentMethod, date, status: String
    let address: Address
    let products: [Product]
    
    enum CodingKeys: String, CodingKey {
        case id, cost, discount, points, vat, total
        case pointsCommission = "points_commission"
        case promoCode = "promo_code"
        case paymentMethod = "payment_method"
        case date, status, address, products
    }
    
    init() {
        self.id = 0
        self.cost = 0
        self.discount = 0
        self.points = 0
        self.vat = 0
        self.total = 0
        self.pointsCommission = 0
        self.promoCode = ""
        self.paymentMethod = ""
        self.date = ""
        self.status = ""
        self.address = Address()
        self.products = []
    }
}
