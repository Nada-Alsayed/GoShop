//
//  ConstantStrings.swift
//  GoShop
//
//  Created by MAC on 21/12/2023.
//

import Foundation

class ConstantStrings{
   
    //MARK: - Alert Strings
    
    static let ALERT = "Alert!"
    static let DELETE_BTN = "Delete"
    static let ADD_BTN = "Add"
    static let NO_ACTION_BTN = "No"
    static let NEW_ADDRESS_BTN = "New Address"
    static let EXISTED_ADDRESS_BTN = "Existed Addresses"
    static let CONFIRM_DELETE_WISHLIST = "Are you sure you want to delete this product from your wishlist?"
    static let CONFIRM_ADD_ADDRESS = "Are you sure you want to add this Address?"
    static let CONFIRM_DELETE_CART = "Are you sure you want to delete this product from your cart?"
    static let CHOOSE_METHOD_TO_GET_ADDRESS = "Do you want to add new address or choose from existed addresses?"
    static let LOGOUT = "Logout"
    static let CONFIRM_LOGOUT_MESSEGE = "Are you sure you want to logout?"
    static let NOT_VALID_DATA_TOAST = "Not valid data"
    static let ENTER_ALL_FIELDS_TOAST = "Please enter all fields"
    static let SignUp_Failed = "Register Failed."
    
    //MARK: - UserDefaults
    
    static let KEY_USERNAME = "UserName"
    static let KEY_USEREMAIL = "UserEmail"
    static let KEY_USER_ID = "CustomerID"
    static let KEY_USER_TOKEN = "CustomerToken"
    static let KEY_Cart_ITEMS = "CartItems"
    
    //MARK: -Static TableView Data

    static let lables = ["Personal Details","My Order","My Favorites","Shipping Address","My Card" ,"Settings"]
    static let images = ["icon-profile","icon-order","icon-favs","icon-address","icon-card" ,"icon-settings"]
    
    //MARK: -Destination to order
    
    static let DESTINATION_PRIFILE = "profile"
    static let DESTINATION_CART = "cart"
}
