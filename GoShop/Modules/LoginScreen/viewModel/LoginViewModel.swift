//
//  LoginViewModel.swift
//  GoShop
//
//  Created by MAC on 21/12/2023.
//

import Foundation
import GoogleSignIn
import Firebase
import FirebaseAuth

protocol SignInDelegate:AnyObject {
    func signInSuccessfully()
    func SignInFailed(message:String)
}

class LoginViewModel{
    
    private var api:UserAPI = UserAPI()
    private var user: User?
    weak var delegate: SignInDelegate?

    let defaults = UserDefaults.standard
    func Original_Login(password : String, email:String){
        let user = User(name: "", phone: "", email: email, password: password, image: "")
        api.loginUser(user: user) { response, err in
            print("post method")
            guard let response = response else{return}
            if response.status == true{
                print("messege: \(response.message)")
                guard let currentCustomer = response.data else {
                    self.delegate?.SignInFailed(message:response.message ?? "")
                    return
                }
                self.setUserDefaults(customer: currentCustomer)
                self.delegate?.signInSuccessfully()
            }
        }
    }
    
    func Google_Login(_vc: UIViewController) {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        let config = GIDConfiguration(clientID: clientID)

        GIDSignIn.sharedInstance.configuration = config
        GIDSignIn.sharedInstance.signIn(withPresenting: _vc) { signInResult, error in
            if let error = error {
                print("Google Sign-In Error: \(error.localizedDescription)")
                return
            }

            guard let signInResult = signInResult else { return }
            let user = signInResult.user
            let emailAddress = user.profile?.email
            let fullName = user.profile?.name

            let profilePicUrl = user.profile?.imageURL(withDimension: 320)

            // Continue with your user handling logic
        }
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
