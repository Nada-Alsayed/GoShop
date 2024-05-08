//
//  AllAddresses_VC.swift
//  GoShop
//
//  Created by MAC on 27/12/2023.
//

import UIKit

class AllAddresses_VC: UIViewController {
    
    //MARK: -IBOutlets
    
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var backImg: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var emptyImg: UIImageView!
    @IBOutlet weak var orderBtn: UIButton!
    
    //MARK: -Variables
    
    var cellIndex:Int = -10
    var viewModel = AddressesViewModel()
    var addresses :[Address] = []
    var destination : String?
    var delegateReload : ReloadViewDelegate?
    
    //MARK: -View Controller LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        setUI()
        addbackImgAction()
        bindData()
        viewModel.getData()
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        if isBeingDismissed {
//            delegateReload?.reloadView()
//        }
//    }
    
    override func viewDidDisappear(_ animated: Bool) {
        if isBeingDismissed {
            delegateReload?.reloadView()
        }
    }
    
    //MARK: -IBActions

    @IBAction func addAddress(_ sender: Any) {
        let vc = AddressMapKit_VC()
        vc.delegateReload = self
        vc.modalPresentationStyle = .fullScreen
        present(vc,animated: true)
    }
    
    
    @IBAction func DeliverOrderToAddress(_ sender: Any) {
        if cellIndex>=0{
            deliverOrder(rowIndex: cellIndex)
        }else{
            showToast(controller: self, message: "You have to pick up address first", seconds: 0.8)
        }
    }
    
    //MARK: -Methods
    
    func bindData(){
        indicator.isHidden = false
        viewModel.bindAddressesToView = { [weak self] in
            guard let self = self else {return}
            DispatchQueue.main.async {
                self.addresses = self.viewModel.addresses
                self.indicator.stopAnimating()
                self.hideEmptyImg(count: self.addresses.count)
                self.tableView.reloadData()
                self.cellIndex = -1
                self.tableView.isUserInteractionEnabled = true
            }
        }
    }
    
    func hideEmptyImg(count:Int){
        if count == 0{
            emptyImg.isHidden = false
        }else{
            emptyImg.isHidden = true
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
    
    func setUI(){
        orderBtn.layer.cornerRadius = 20
        checkDestination()
    }
    
    func checkDestination(){
        if destination == ConstantStrings.DESTINATION_PRIFILE {
            orderBtn.isHidden = true
        }else if  destination == ConstantStrings.DESTINATION_CART{
            orderBtn.isHidden = false
        }else{
            print("not available destination")
        }
    }
}
