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
        cell.setupCell(category: categories[indexPath.row])
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
}
