//
//  SignUpViewModel.swift
//  GoShop
//
//  Created by MAC on 20/12/2023.
//

import Foundation
import FirebaseAuth

protocol SignUpDelegate:AnyObject {
    func signUpSuccessfully()
    func SignUpFailed()
   // func userNotVerified(user : User)
}

class SignUpViewModel{
    
    //MARK: - Variables
    
    private var api:UserAPI = UserAPI()
    private var user: User?
    weak var delegate: SignUpDelegate?

    let defaults = UserDefaults.standard
    
//    var bindData:((Customer) -> ()) = { _ in }
//    var customer = Customer(){
//        didSet{
//            bindData(self.customer)
//        }
//    }
    
    func signUp(user : User){
        api.postUser(user: user) { response, err in
            print("post method")
            guard let response = response else{return}
            if response.status == true{
                print("messege: \(response.message)")
                guard let currentCustomer = response.data else {
                    self.delegate?.SignUpFailed()
                    return
                }
                self.setUserDefaults(customer: currentCustomer)
                
                Auth.auth().createUser(withEmail: user.email , password: user.password ) { authResult, error in
                    if let error = error {
                        print("Error creating user: \(error.localizedDescription)")
                        return
                    }
                    print("creating User and send mail")
                    guard let user = authResult?.user else{return}
                    user.sendEmailVerification { error in
                        if let error = error {
                            // Handle the error
                            print("Error sending email verification: \(error.localizedDescription)")
                            return
                        }
                        print("Email verification sent successfully")
                        self.delegate?.signUpSuccessfully()
                    }
                }
                
            }
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
