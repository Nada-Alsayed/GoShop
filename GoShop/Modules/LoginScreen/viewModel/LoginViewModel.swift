//
//  LoginViewModel.swift
//  GoShop
//
//  Created by MAC on 21/12/2023.
//

import Foundation
//import GoogleSignIn
//import Firebase
//import FirebaseAuth

protocol SignInDelegate:AnyObject {
    func signInSuccessfully()
    func signInFailed(message:String)
}

class LoginViewModel{
    
    private var api:UserAPI = UserAPI()
    private var user: User?
    var delegate: SignInDelegate?
 //   var delegateResponse: ResponseMessage?
    let defaults = UserDefaults.standard
    
    func Original_Login(password : String, email:String){
        let user = User(name: "", phone: "", email: email, password: password, image: "")
        api.loginUser(user: user) { response, err in
            guard let response = response else{return}
            guard let currentCustomer = response.data else {
                self.delegate?.signInFailed(message: response.message ?? "")
                return
            }
            self.setUserDefaults(customer: currentCustomer)
            self.delegate?.signInSuccessfully()
        }
    }
    
//    func Google_Login(_vc: UIViewController) {
//        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
//        let config = GIDConfiguration(clientID: clientID)
//        
//        GIDSignIn.sharedInstance.configuration = config
//        GIDSignIn.sharedInstance.signIn(withPresenting: _vc) { signInResult, error in
//            if let error = error {
//                print("Google Sign-In Error: \(error.localizedDescription)")
//                return
//            }
//            
//            guard let signInResult = signInResult else { return }
//            let user = signInResult.user
//            let emailAddress = user.profile?.email
//            let fullName = user.profile?.name
//            let profilePicUrl = user.profile?.imageURL(withDimension: 320)
//        }
//    }
    
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
    
    func setUserDefaults(customer:Customer){
        defaults.set(customer.name, forKey: ConstantStrings.KEY_USERNAME)
        defaults.set(customer.token, forKey: ConstantStrings.KEY_USER_TOKEN)
        defaults.set(customer.email, forKey: ConstantStrings.KEY_USEREMAIL)
        defaults.set(customer.id, forKey: ConstantStrings.KEY_USER_ID)
        if let customer_token = UserDefaults.standard.string(forKey: ConstantStrings.KEY_USER_TOKEN)
        {
            print("Customer Token : \(customer_token)!")
        } else {
            print("No username found.")
        }
    }
}
