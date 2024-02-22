//
//  ExtensionsSignIn_VC.swift
//  GoShop
//
//  Created by MAC on 21/12/2023.
//

import Foundation
import UIKit

extension Login_VC : SignInDelegate{
    func signInFailed(message: String) {
        self.indicator.stopAnimating()
        showToast(controller: self, message: message, seconds: 1)
    }
    
    func signInSuccessfully() {
        self.indicator.stopAnimating()
        
        let vc = BottomTaPBar()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc,animated: true)
    }
}

extension Login_VC: ResponseMessage{
    func responsIsDone(message: String) {
        print("here")
        showToast(controller: self, message: message, seconds: 1)
    }
}
