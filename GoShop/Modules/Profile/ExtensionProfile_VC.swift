//
//  ExtensionProfile_VC.swift
//  GoShop
//
//  Created by MAC on 23/12/2023.
//

import Foundation
import UIKit

extension Profile_VC :UITableViewDelegate,UITableViewDataSource{
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 1
        }else{
            return 6
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: section_1.id, for: indexPath) as! section_1
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: section_2.id, for: indexPath) as! section_2
            cell.setUpData(name: ConstantStrings.lables[indexPath.row], imge: ConstantStrings.images[indexPath.row])
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0{
            return 110
        }else{
            return 55
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 && indexPath.row == 2{
            let vc = Favorites_VC()
            vc.modalPresentationStyle = .fullScreen
            present(vc,animated: true)
        }else if indexPath.section == 1 && indexPath.row == 3{
            let vc = AllAddresses_VC()
            vc.destination = ConstantStrings.DESTINATION_PRIFILE
            vc.modalPresentationStyle = .fullScreen
            present(vc,animated: true)
        }else if indexPath.section == 1 && indexPath.row == 1{
            let vc = AllOrders_VC()
            vc.modalPresentationStyle = .fullScreen
            present(vc,animated: true)
        }else if indexPath.section == 1 && indexPath.row == 0{
            let vc = ProfileDetails_VC()
            vc.modalPresentationStyle = .fullScreen
            present(vc,animated: true)
        }
    }
//
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//            let headerView = UIView()
//            headerView.backgroundColor = UIColor.black // Set your desired background color
//            headerView.layer.borderWidth = 1.0 // Set the border width
//            headerView.layer.borderColor = UIColor.black.cgColor // Set the border color
//
//            return headerView
//        }
//
//        func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//            return 1.0 // Set the desired height for the section header
//        }
//
//        func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//            return 0.0 // Set the height of the footer to remove the default space
//        }
}
