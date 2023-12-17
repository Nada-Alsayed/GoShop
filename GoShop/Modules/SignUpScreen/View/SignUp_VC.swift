//
//  SignUp_VC.swift
//  GoShop
//
//  Created by MAC on 06/12/2023.
//

import UIKit

class SignUp_VC: UIViewController {
    
    //MARK: - IBOutlets

    @IBOutlet weak var userNameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var confirmPasswordTF: UITextField!
    
    
    //MARK: - View Controller Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()

    }

    //MARK: - IBActions

    @IBAction func signUpBtn(_ sender: Any) {
        print("SignUp")
    }
    
}
