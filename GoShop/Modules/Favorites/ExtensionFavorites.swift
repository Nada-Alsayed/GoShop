//
//  ExtensionFavorites.swift
//  GoShop
//
//  Created by MAC on 24/12/2023.
//

import Foundation
import UIKit

extension Favorites_VC :UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: FavoritesCell.id, for: indexPath) as! FavoritesCell
            cell.setUpData(product: products[indexPath.row])
            cell.changeBtnTitle(product: products[indexPath.row])
            cell.cellIndex = indexPath.row
            cell.delegateReload = self
            cell.delegteClick = self
            return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = Details_VC()
        vc.modalPresentationStyle = .fullScreen
        vc.id = products[indexPath.row].product.id ?? 0
        vc.delegate = self
        present(vc,animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

        let deleteAction = UIContextualAction(style: .destructive, title: "") { (action, view, completionHandler) in
            self.showAlertWithAction(title: ConstantStrings.ALERT, titleAction: ConstantStrings.DELETE_BTN, titleNoAction: ConstantStrings.NO_ACTION_BTN, message: ConstantStrings.CONFIRM_DELETE_WISHLIST, viewController: self) {
                self.tableView.isUserInteractionEnabled = false
                self.indicator.isHidden = false
                self.indicator.startAnimating()
                self.viewModel.postToWishlist(product_id: self.products[indexPath.row].product.id ?? 0, operation: {
                    self.tableView.isUserInteractionEnabled = true
                    self.indicator.stopAnimating()
                    self.products.remove(at: indexPath.row)
                    self.tableView.reloadData()
                    self.hideImage(array: self.products)
                })
            }
            completionHandler(true)
        }

        deleteAction.backgroundColor = .black
        deleteAction.image = UIImage(named: "icon-table-delete")

        let swipeConfiguration = UISwipeActionsConfiguration(actions: [deleteAction])
        swipeConfiguration.performsFirstActionWithFullSwipe = false

        return swipeConfiguration
    }
}

extension Favorites_VC : ReloadViewDelegate{
    func reloadView() {
        bindData()
        viewModel.getData()
    }
}

extension Favorites_VC : OnClickDelegate {
    func clicked(_ row: Int, opertion: @escaping (Bool) -> Void) {
       // print("ppop\(products[row].product.inCart)")
        if(products[row].product.inCart == false){
            tableView.isUserInteractionEnabled = false
            products[row].product.inCart = true
            viewModel.postToCart(product_id: products[row].product.id ?? 0, vc: self) {
                self.setCartItemsNumber(sum: self.sum)
                opertion(true)
            }
        }else if products[row].product.inCart == true {
            showAlertWithAction(title: ConstantStrings.ALERT, titleAction:  ConstantStrings.DELETE_BTN, titleNoAction:  ConstantStrings.NO_ACTION_BTN, message:  ConstantStrings.CONFIRM_DELETE_CART, viewController: self) {
                self.products[row].product.inCart = false
                self.tableView.isUserInteractionEnabled = false
                self.viewModel.postToCart(product_id: self.products[row].product.id ?? 0, vc: self) {
                    self.setCartItemsNumber(sum: self.sum)
                    opertion(false)
                }
            }
        }else{
            print("Nilll")
        }
    }
}
