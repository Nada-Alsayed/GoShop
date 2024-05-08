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
}

class SignUpViewModel{
    
    //MARK: - Variables
    
    private var api:UserAPI = UserAPI()
    private var user: User?
    weak var delegate: SignUpDelegate?
    var delegateResponse:ResponseMessage?
    let defaults = UserDefaults.standard
    
    //MARK: -Methods

    func signUp(user : User){
        api.postUser(user: user) { response, err in
            print("post method")
            guard let response = response else{return}
                print("messege: \(response.message)")
                self.delegateResponse?.responsIsDone(message: response.message ?? "")
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
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        print("\(emailPredicate.evaluate(with: email))")
        return emailPredicate.evaluate(with: email)
    }

    func isValidPassword(_ password: String) -> Bool {
        let passwordRegex = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}$"
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        print("\(passwordPredicate.evaluate(with: password))")

        return passwordPredicate.evaluate(with: password)
    }
    
    func isValidPhoneNumber(_ phoneNumber: String) -> Bool {
        let phoneRegex = #"^\+?[0-9]{1,}$"#
        let phonePredicate = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        print("\(phonePredicate.evaluate(with: phoneNumber))")

        return phonePredicate.evaluate(with: phoneNumber)
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
