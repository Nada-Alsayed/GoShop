//
//  CategoriesExtensions.swift
//  GoShop
//
//  Created by MAC on 18/12/2023.
//

import Foundation
import UIKit

extension Categories_VC : UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(150)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.categoriesNumberInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CategoriesCell.identifier, for: indexPath) as! CategoriesCell
        cell.index = indexPath.row
        cell.setupCell(category: categories[indexPath.row],index: indexPath.row)
        return cell
    }
    
    
    func setupTable(){
        categoriesTableView.delegate = self
        categoriesTableView.dataSource = self
        registerCell()
    }
    
    func registerCell(){
        categoriesTableView.register(UINib(nibName: CategoriesCell.identifier, bundle: nil), forCellReuseIdentifier: CategoriesCell.identifier)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = CategoryProducts()
        vc.modalPresentationStyle = .fullScreen
        vc.id = categories[indexPath.row].id
        vc.categoryName = categories[indexPath.row].name
        present(vc,animated: true)
    }
}
