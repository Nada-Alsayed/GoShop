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

protocol OnClickDelegate {
    func clicked(_ row: Int, opertion:@escaping(Bool)->Void)
}

protocol ResponceMessage{
    func responsIsDone(message: String)
}

protocol GoBack{
    func moveBack()
}
