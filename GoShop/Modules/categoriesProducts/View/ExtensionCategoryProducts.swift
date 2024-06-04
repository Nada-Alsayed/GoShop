//
//  ExtensionCategoryProducts.swift
//  GoShop
//
//  Created by MAC on 02/01/2024.
//

import Foundation
import UIKit

extension CategoryProducts :UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func setUpCollectionViews(){
        collectionView.delegate = self
        collectionView.dataSource = self
        registerCell()
    }
    
    func registerCell(){
        collectionView.register(UINib(nibName: Product_Cell.id , bundle: nil), forCellWithReuseIdentifier: Product_Cell.id)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Product_Cell.id, for: indexPath) as! Product_Cell
        cell.setupCell(products[indexPath.row])
        cell.delegate = self
        cell.cellIndex = indexPath.row
        cell.delegateReload = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewWidth = collectionView.frame.width
        let cellWidth = collectionViewWidth / 2.1
        let cellHeight: CGFloat = 320
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            let vc = Details_VC()
            vc.modalPresentationStyle = .fullScreen
            vc.id = products[indexPath.row].id ?? 0
            vc.delegate = self
            present(vc,animated: true)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

//MARK: -OnClick Extension

extension CategoryProducts :OnClickDelegate{
    
    func clicked(_ row: Int, opertion:@escaping (Bool) -> Void) {
        if(products[row].inFavorites == false){
            collectionView.isUserInteractionEnabled = false
            products[row].inFavorites = true
            indicator.startAnimating()
            indicator.isHidden = false
            homeView.postToWishlist(product_id: products[row].id ?? 0, vc: self) {
                opertion(true)
            }
        }else{
            showAlertWithAction(title: ConstantStrings.ALERT, titleAction:  ConstantStrings.DELETE_BTN, titleNoAction:  ConstantStrings.NO_ACTION_BTN, message:  ConstantStrings.CONFIRM_DELETE_WISHLIST, viewController: self) {
                self.products[row].inFavorites = false
                self.indicator.startAnimating()
                self.indicator.isHidden = false
                self.collectionView.isUserInteractionEnabled = false
                self.homeView.postToWishlist(product_id: self.products[row].id ?? 0, vc: self) {
                    opertion(true)
                }
            }
        }
    }
}

//MARK: -Show Response Message Extension

extension CategoryProducts : ResponseMessage {
    
    func responsIsDone(message: String) {
        showToast(controller: self, message: message, seconds: 1)
    }
}

//MARK: -Reload View Extension

extension CategoryProducts : ReloadViewDelegate{
    func reloadView() {
        collectionView.isUserInteractionEnabled = false
        bindData()
        categoryViewModel.getData(category_id: self.id ?? 0)
    }
}
