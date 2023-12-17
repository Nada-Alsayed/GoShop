//
//  Splash_VC.swift
//  GoShop
//
//  Created by MAC on 06/12/2023.
//

import UIKit

class Splash_VC: UIViewController {
    
    //MARK: - Variables
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("hi")
        // Do any additional setup after loading the view.
    }
    
    @IBAction func navigateToLogin(_ sender: Any) {
        let vc = Login_VC()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc,animated: true)
    }
    

    @IBAction func navigateToSignUp(_ sender: Any) {
        let vc = SignUp_VC()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc,animated: true)
        
    }
}
