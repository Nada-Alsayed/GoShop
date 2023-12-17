//
//  HomeExtensions.swift
//  GoShop
//
//  Created by MAC on 13/12/2023.
//

import Foundation
import UIKit

extension Home_VC : UICollectionViewDelegate,UICollectionViewDataSource {

    func setUpCollectionViews(){
        bannerCollectionView.delegate = self
        bannerCollectionView.dataSource = self
        
        productsCollectionView.delegate = self
        productsCollectionView.dataSource = self
        
        registerCells()
    }
    
    func registerCells(){
        productsCollectionView.register(UINib(nibName: Product_Cell.id , bundle: nil), forCellWithReuseIdentifier: Product_Cell.id)
        
        bannerCollectionView.register(UINib(nibName: Banner_Cell.id , bundle: nil), forCellWithReuseIdentifier: Banner_Cell.id)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        <#code#>
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        <#code#>
    }
    
}
