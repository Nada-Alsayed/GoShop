//
//  ExtensionAddress.swift
//  GoShop
//
//  Created by MAC on 28/12/2023.
//

import Foundation
import UIKit

extension AllAddresses_VC : UITableViewDelegate,UITableViewDataSource{
    
    func setUpTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: CellAddress.id, bundle: nil), forCellReuseIdentifier: CellAddress.id)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addresses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: CellAddress.id, for: indexPath) as! CellAddress
        cell.setUpData(address: addresses[indexPath.row])
        cell.hideImage()

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? CellAddress else{
            return
        }
        cell.selectionStyle = .none
        if destination == ConstantStrings.DESTINATION_CART{
            cellIndex = indexPath.row
            print("ceel index\(cellIndex)")
            cell.showImage()
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? CellAddress else{
            return
        }
        cell.hideImage()
    }
    
    func deliverOrder(rowIndex : Int){
        self.tableView.isUserInteractionEnabled = false
        indicator.isHidden = false
        indicator.startAnimating()
        checkIfCartEmpty(index: rowIndex)
    }
    
    func checkIfCartEmpty(index : Int){
        viewModel.getCartData {
            if self.viewModel.cartlist.count == 0{
                self.showToast(controller: self, message: "Cart is Empty", seconds: 0.8)
                self.tableView.isUserInteractionEnabled = true
                self.indicator.stopAnimating()
            }else{
                self.postOrderToAPI(cellIndex: index)
            }
        }
    }
    
    func postOrderToAPI(cellIndex : Int){
        showAlertWithAction(title: "Cart Alert", titleAction: "Send", titleNoAction: "No", message: "Are You sure you want to send your rder to this address", viewController: self) {
            print("index1 \(cellIndex)")
            self.viewModel.postOrder(address: self.addresses[cellIndex]) {
                self.tableView.isUserInteractionEnabled = true
                self.indicator.stopAnimating()
                self.showToast(controller: self, message: "Your Order On His Way", seconds: 0.8)
                print("index2 \(cellIndex)")
                self.tableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

        let deleteAction = UIContextualAction(style: .destructive, title: "") { (action, view, completionHandler) in
            self.showAlertWithAction(title: ConstantStrings.ALERT, titleAction: ConstantStrings.DELETE_BTN, titleNoAction: ConstantStrings.NO_ACTION_BTN, message: ConstantStrings.CONFIRM_DELETE_WISHLIST, viewController: self) {
                self.viewModel.deleteAddress(id: self.addresses[indexPath.row].id, operation: {
                    self.addresses.remove(at: indexPath.row)
                    self.tableView.reloadData()
                    self.hideEmptyImg(count: self.addresses.count)
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

extension AllAddresses_VC : ReloadViewDelegate{
    func reloadView() {
        tableView.isUserInteractionEnabled = false
        bindData()
        viewModel.getData()
    }
}
