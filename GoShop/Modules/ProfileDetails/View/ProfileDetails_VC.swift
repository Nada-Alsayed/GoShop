//
//  ProfileDetails_VC.swift
//  GoShop
//
//  Created by MAC on 01/01/2024.
//

import UIKit

class ProfileDetails_VC: UIViewController {
    
    //MARK: -IBOutLets
 
    @IBOutlet weak var backImg: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var signOutBtn: UIButton!
   
    //MARK: -Variables

    var viewModel = profileDetailsViewModel()
    
    //MARK: -View Controller LifeCycle Functions

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        addbackImgAction()
        bindData()
        viewModel.getData()
    }
    
    //MARK: -IBActions

    @IBAction func signOut(_ sender: Any) {
        viewModel.logOutFromAPI(){
            UserDefaults.standard.set("", forKey: ConstantStrings.KEY_USER_TOKEN)
            self.navigateToLogin()
        }
    }
    
    //MARK: -Methods
    
    func navigateToLogin(){
        let vc = Splash_VC()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc,animated: true)
    }
    
    func bindData(){
        viewModel.bindDataToView = { [weak self] in
            self?.setUpData(customer: self?.viewModel.customer ?? Customer())
        }
    }
    
    func setUpData(customer: Customer){
        name.text = customer.name
        email.text = customer.email
    }
    
    //MARK: -UI and Tap Gesture Methods
    
    func setUI(){
        signOutBtn.layer.cornerRadius = 20
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
