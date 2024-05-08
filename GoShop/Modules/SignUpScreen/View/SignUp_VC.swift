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
    @IBOutlet weak var backImg: UIImageView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    //MARK: - Variables
    
    var viewModel = SignUpViewModel()

    //MARK: - View Controller Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        addbackImgAction()
        hideKeyboardWhenTappedAround()
        viewModel.delegate = self
        viewModel.delegateResponse = self
    }

    //MARK: - IBActions

    @IBAction func signUpBtn(_ sender: Any) {
        let user = userAuth(name: userNameTF.text ?? "", email: emailTF.text ?? "", pass: passwordTF.text ?? "", phone: phoneTF.text ?? "")
        checkIfValidData(user: user)
    }
    
    func userAuth(name: String,email: String,pass: String,phone: String) -> User{
        return User(name: name, phone: phone, email: email, password: pass, image: "")
    }
    
    func checkIfValidData(user:User){
        if !(user.name.isEmpty ) &&
            !(user.email.isEmpty ) &&
            !(user.phone.isEmpty ) &&
            !(user.password.isEmpty ) {

            if viewModel.isValidEmail(user.email)
                && viewModel.isValidPassword(user.password)
                && viewModel.isValidPhoneNumber(user.phone)
            {
                indicator.isHidden = true
                indicator.startAnimating()
                viewModel.signUp(user: user)
            } else {
                showToast(controller: self, message:ConstantStrings.NOT_VALID_DATA_TOAST, seconds: 1)
            }
        }else{
            showToast(controller: self, message:ConstantStrings.ENTER_ALL_FIELDS_TOAST, seconds: 1)
        }
    }
    
    func addbackImgAction(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(goBack))
        backImg.isUserInteractionEnabled = true
        backImg.addGestureRecognizer(tap)
    }
    
    @objc func goBack(){
        self.dismiss(animated: true)
    }
}

extension SignUp_VC: ResponseMessage{
    func responsIsDone(message: String) {
        print("here")
        showToast(controller: self, message: message, seconds: 1)
    }
}
