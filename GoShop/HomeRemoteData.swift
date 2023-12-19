//
//  RemoteData.swift
//  GoShop
//
//  Created by MAC on 13/12/2023.
//

import Foundation

// MARK: - BaseResponse
struct BaseResponse<T: Codable>: Codable {
    let status: Bool?
    let message: String?
    let data: T?
}

// MARK: - HomeData
struct HomeData: Codable {
    let banners: [Banner]?
    let products: [Product]?
    let ad: String?
}

struct Banner: Codable {
    let id: Int
    let image: String?
    let category, product: String?
}

// MARK: - Product
struct Product: Codable {
    let id, price, oldPrice, discount: Double?
    let image: String?
    let name, description: String?
    let inFavorites, inCart: Bool?
    let images: [String]?
    
    enum CodingKeys: String, CodingKey {
        case id, price
        case oldPrice = "old_price"
        case discount, image, name, description
        case inFavorites = "in_favorites"
        case inCart = "in_cart"
        case images
    }
}

// MARK: - CategoryData
struct CategoryData: Codable {
    let data: [Category]
}

// MARK: - Category
struct Category: Codable {
    let id: Int?
    let name: String?
    let image: String?
}
