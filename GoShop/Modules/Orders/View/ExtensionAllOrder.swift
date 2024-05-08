//
//  ExtensionAllOrder.swift
//  GoShop
//
//  Created by MAC on 30/12/2023.
//

import Foundation
import UIKit

extension AllOrders_VC : UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return status == "New" ? viewModel.newOrderInSection(section: section) : viewModel.canceledOrderInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: OrderCell.id, for: indexPath) as! OrderCell
        if status == "New" {
            cell.setUPCell(order: newOrders[indexPath.row])
        }else{
            cell.setUPCell(order: cancelledOrders[indexPath.row])
        }
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = OrderDetails_VC()
        vc.modalPresentationStyle = .fullScreen
        if status == "New" {
            vc.productID = newOrders[indexPath.row].id
            vc.status = "New"
        }else{
            vc.productID = cancelledOrders[indexPath.row].id
            vc.status = "Canceled"
        }
        vc.status = status
        vc.delegateReload = self
        present(vc,animated: true)
    }
}

extension AllOrders_VC : ReloadViewDelegate{
    func reloadView() {
        status = "New"
        setBtnSelected(btn: newBtn)
        setBtnNormal(btn: canceledBtn)
        bindData()
        viewModel.getData()
    }
}
