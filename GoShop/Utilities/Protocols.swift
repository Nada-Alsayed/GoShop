//
//  Protocols.swift
//  GoShop
//
//  Created by MAC on 24/12/2023.
//

import Foundation

protocol ReloadViewDelegate {
    func reloadView()
}

protocol ClickToFavBtnDelegate {
    func clicked(_ row: Int)
}