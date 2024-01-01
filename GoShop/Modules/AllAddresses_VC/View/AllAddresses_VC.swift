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
    
    //MARK: -Variables
    
    var viewModel = AddressesViewModel()
    var addresses :[Address] = []
    
//    override func viewWillAppear(_ animated: Bool) {
//        print("Nadod")
//        addresses = []
//        viewModel.getData()
//        tableView.reloadData()
//        hideEmptyImg(count: addresses.count)
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        addbackImgAction()
        bindData()
        viewModel.getData()
    }
    
    @IBAction func addAddress(_ sender: Any) {
        let vc = AddressMapKit_VC()
        vc.delegateReload = self
        vc.modalPresentationStyle = .fullScreen
        present(vc,animated: true)
    }
    
    func setUpTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: CellAddress.id, bundle: nil), forCellReuseIdentifier: CellAddress.id)
    }
    
    func bindData(){
        indicator.isHidden = false
        viewModel.bindAddressesToView = { [weak self] in
            guard let self = self else {return}
            DispatchQueue.main.async {
                self.addresses = self.viewModel.addresses
                self.indicator.stopAnimating()
                self.hideEmptyImg(count: self.addresses.count)
                self.tableView.reloadData()
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
}
