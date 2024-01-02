//
//  ExtensionsSignIn_VC.swift
//  GoShop
//
//  Created by MAC on 21/12/2023.
//

import Foundation

extension Login_VC : SignInDelegate{
    
    func signInSuccessfully() {
        let vc = BottomTaPBar()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc,animated: true)
    }
    
    func SignInFailed(message: String) {
        print("failed to login")
        showToast(controller: self, message: message, seconds: 1)
    }
}
