//
//  HomeExtensions.swift
//  GoShop
//
//  Created by MAC on 13/12/2023.
//

import Foundation
import UIKit

extension Home_VC : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
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
        if collectionView.tag == 0{
            return viewModel.bannersNumberInSection(section: section)
        }else if collectionView.tag == 1{
            return  viewModel.productsNumberInSection(section: section)
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView.tag == 0{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Banner_Cell.id, for: indexPath) as! Banner_Cell
            cell.setupCell(banners[indexPath.row])
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Product_Cell.id, for: indexPath) as! Product_Cell
            cell.setupCell(products[indexPath.row])
            cell.delegate = self
            cell.cellIndex = indexPath.row
            cell.delegateReload = self
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView.tag == 0{
            // print("jjjj")
            let bannerWidth = collectionView.bounds.width
            let bannerHeight: CGFloat = 180
            return CGSize(width: bannerWidth, height: bannerHeight)
        }else {
            let collectionViewWidth = collectionView.bounds.width
            let cellWidth = collectionViewWidth / 2
            let cellHeight: CGFloat = 320
            return CGSize(width: cellWidth, height: cellHeight)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView.tag == 1{
            let vc = Details_VC()
            vc.modalPresentationStyle = .fullScreen
            vc.id = products[indexPath.row].id ?? 0
            vc.delegate = self
            present(vc,animated: true)
        }
    }
}

extension Home_VC :OnClickDelegate{
    
    func clicked(_ row: Int, opertion:@escaping (Bool) -> Void) {
        if(products[row].inFavorites == false){
            productsCollectionView.isUserInteractionEnabled = false
            products[row].inFavorites = true
            indicator.startAnimating()
            indicator.isHidden = false
            viewModel.postToWishlist(product_id: products[row].id ?? 0, vc: self) {
                opertion(true)
            }
        }else{
            showAlertWithAction(title: ConstantStrings.ALERT, titleAction:  ConstantStrings.DELETE_BTN, titleNoAction:  ConstantStrings.NO_ACTION_BTN, message:  ConstantStrings.CONFIRM_DELETE_WISHLIST, viewController: self) {
                self.products[row].inFavorites = false
                self.indicator.startAnimating()
                self.indicator.isHidden = false
                self.productsCollectionView.isUserInteractionEnabled = false
                self.viewModel.postToWishlist(product_id: self.products[row].id ?? 0, vc: self) {
                    opertion(true)
                }
            }
        }
    }
}

extension Home_VC : ResponseMessage {
    
    func responsIsDone(message: String) {
        showToast(controller: self, message: message, seconds: 1)
    }
}

extension Home_VC : ReloadViewDelegate{
    func reloadView() {
        productsCollectionView.isUserInteractionEnabled = false
        bindData()
        viewModel.getData()
        bindCartItemsNumber()
        cartViewModel.getData()
    }
}
