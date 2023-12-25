//
//  ExtensionCartsVC.swift
//  GoShop
//
//  Created by MAC on 25/12/2023.
//

import Foundation
import UIKit

extension Carts_VC :UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.productsNumberInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: CartCell.id, for: indexPath) as! CartCell
            cell.setUpData(product: products[indexPath.row])
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
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

        let deleteAction = UIContextualAction(style: .destructive, title: "") { (action, view, completionHandler) in
            print("gggggggggg")
            completionHandler(true)
        }

        // You can customize the appearance of the action, such as its background color
        deleteAction.backgroundColor = .black
        deleteAction.image = UIImage(named: "icon-table-delete")

        let swipeConfiguration = UISwipeActionsConfiguration(actions: [deleteAction])
        swipeConfiguration.performsFirstActionWithFullSwipe = false

        return swipeConfiguration
    }
    
    func imageWithView(view: UIView) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: view.bounds.size)
        let image = renderer.image { (context) in
            view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
        }
        return image
    }

}

extension Carts_VC : ReloadViewDelegate{
    func reloadView() {
        tableView.reloadData()
}
}
