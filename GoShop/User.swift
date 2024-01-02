//
//  User.swift
//  GoShop
//
//  Created by MAC on 03/12/2023.
//

import Foundation
 
//MARK: -SignUpModel

class User : Codable{
    var name, phone, email, password: String
    var image: String
    init(name: String, phone: String, email: String, password: String, image: String) {
        self.name = name
        self.phone = phone
        self.email = email
        self.password = password
        self.image = image
    }
}

//MARK: -Customer

class Customer : Codable{
    var name, phone, email: String?
    var id: Int?
    var image: String?
    var token: String?
    
    init(name: String, phone: String, email: String, id: Int, image: String, token: String) {
        self.name = name
        self.phone = phone
        self.email = email
        self.id = id
        self.image = image
        self.token = token
    }
    init() {
        self.name = ""
        self.phone = ""
        self.email = ""
        self.id = 0
        self.image = ""
        self.token = ""
    }
}
