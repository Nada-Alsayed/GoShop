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
        return viewModel.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.productsNumberInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: FavoritesCell.id, for: indexPath) as! FavoritesCell
            cell.setUpData(product: products[indexPath.row])
            return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = Details_VC()
        vc.modalPresentationStyle = .popover
        vc.id = products[indexPath.row].product.id ?? 0
        vc.delegate = self
        present(vc,animated: true)
    }
    
}

extension Favorites_VC : ReloadViewDelegate{
    func reloadView() {
        print("Implementation")
        tableView.reloadData()
    }
}
