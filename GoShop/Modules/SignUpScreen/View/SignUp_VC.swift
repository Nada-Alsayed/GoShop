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
    @IBOutlet weak var phoneTF: UITextField!
    
    //MARK: - Variables
    var viewModel = SignUpViewModel()

    //MARK: - View Controller Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
    }

    //MARK: - IBActions

    @IBAction func signUpBtn(_ sender: Any) {
        print("SignUp")
        let password = passwordTF.text ?? ""
        let name = userNameTF.text ?? ""
        let phone = phoneTF.text ?? ""
        let email = emailTF.text ?? ""
        
        checkIfValidData(name: name,email: email,pass: password,phone: phone)
    }
    
    func checkIfValidData(name: String,email: String,pass: String,phone: String){
        if !(name.isEmpty ) &&
            !(email.isEmpty ) &&
            !(pass.isEmpty ) &&
            !(phone.isEmpty ) {

            if isValidEmail(email)
                && isValidPassword(pass)
                && isValidPhoneNumber(phone)
            {
                print("nnnnn")
                viewModel.signUp(user: User(name: name, phone: phone, email: email, password: pass, image: ""))
            } else {
                showToast(controller: self, message:ConstantStrings.NOT_VALID_DATA_TOAST, seconds: 1)
            }
        }else{
            showToast(controller: self, message:ConstantStrings.ENTER_ALL_FIELDS_TOAST, seconds: 1)
        }
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }

    func isValidPassword(_ password: String) -> Bool {
        let passwordRegex = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}$"
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        return passwordPredicate.evaluate(with: password)
    }
    
    func isValidPhoneNumber(_ phoneNumber: String) -> Bool {
        let phoneRegex = #"^\+?[0-9]{1,}$"#
        let phonePredicate = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        return phonePredicate.evaluate(with: phoneNumber)
    }
}
