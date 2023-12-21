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

class LoginViewModel{

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

}
