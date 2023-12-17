//
//  RemoteData.swift
//  GoShop
//
//  Created by MAC on 13/12/2023.
//

import Foundation

// MARK: - Welcome
struct Response: Codable {
    let status: Bool
    let message: String?
    let data: HomeData
}

// MARK: - DataClass
struct HomeData: Codable {
    let banners: [Banner]
    let products: [Product]
    let ad: String
}

struct Banner: Codable {
    let id: Int
    let image: String
    let category, product: String?
}

// MARK: - Product
struct Product: Codable {
    let id, price, oldPrice, discount: Int
    let image: String
    let name, description: String
    let inFavorites, inCart: Bool
    let images: [String]

    enum CodingKeys: String, CodingKey {
        case id, price
        case oldPrice = "old_price"
        case discount, image, name, description
        case inFavorites = "in_favorites"
        case inCart = "in_cart"
        case images
    }
}
