//
//  ExtensionCartsVC.swift
//  GoShop
//
//  Created by MAC on 25/12/2023.
//

import Foundation
import UIKit

extension Carts_VC :UITableViewDelegate,UITableViewDataSource, OnClickDelegate{
    
    func clicked(_ row: Int, opertion: @escaping (Bool) -> Void) {
        print("lllllll")
        tableView.isUserInteractionEnabled = false
        viewModel.postToCart(product_id: products[row].product.id ?? 0, vc: self){
            opertion(true)
        }
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.productsNumberInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: CartCell.id, for: indexPath) as! CartCell
            cell.setUpData(product: products[indexPath.row])
            cell.delegateReload = self
            cell.delegateQuantity = self
            cell.delegate = self
            cell.cellIndex = indexPath.row
            return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 220
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = Details_VC()
        vc.modalPresentationStyle = .popover
        vc.id = products[indexPath.row].product.id ?? 0
        vc.delegate = self
        present(vc,animated: true)
    }
}

extension Carts_VC : ReloadViewDelegate{
    func reloadView() {
        bindData()
        viewModel.getData()
    }
}

extension Carts_VC :CartQuantityDelegate{
    func clickedQuantity(_ row: Int, _ quantity: Int, opertion: @escaping (SubCart) -> Void) {
        tableView.isUserInteractionEnabled = false
        indicator.isHidden = false
        indicator.startAnimating()
        viewModel.updateCart(itemID: products[row].id , quantity: quantity) { response in
            opertion(response)
        }
    }
}
