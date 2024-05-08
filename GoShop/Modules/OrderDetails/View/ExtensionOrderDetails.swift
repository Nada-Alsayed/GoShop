//
//  ExtensionOrderDetails.swift
//  GoShop
//
//  Created by MAC on 31/12/2023.
//

import Foundation
import UIKit

extension OrderDetails_VC : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func setUpCollectionView(){
        productsCollectionView.delegate = self
        productsCollectionView.dataSource = self
        productsCollectionView.register(UINib(nibName: CellOrderProduct.id, bundle: nil), forCellWithReuseIdentifier: CellOrderProduct.id)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // print("jjjj")
        let bannerWidth = collectionView.bounds.width
        let bannerHeight: CGFloat = 180
        return CGSize(width: bannerWidth, height: bannerHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfProducts(section: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellOrderProduct.id, for: indexPath) as! CellOrderProduct
        cell.setUpData(product: orderDetails.products[indexPath.row])
        return cell
    }
}
