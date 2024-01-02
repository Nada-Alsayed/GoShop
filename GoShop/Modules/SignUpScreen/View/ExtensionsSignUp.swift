//
//  ExtensionsSignUp.swift
//  GoShop
//
//  Created by MAC on 21/12/2023.
//

import Foundation

extension SignUp_VC: SignUpDelegate {
        
    func signUpSuccessfully() {
        let vc = OnBoarding_VC()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc,animated: true)
    }
    
    func SignUpFailed() {
        print("failed to login")
        showToast(controller: self, message: ConstantStrings.SignUp_Failed, seconds: 1)
    }
}
