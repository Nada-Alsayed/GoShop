//
//  AllOrders_VC.swift
//  GoShop
//
//  Created by MAC on 30/12/2023.
//

import UIKit

class AllOrders_VC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var backImg: UIImageView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var canceledBtn: UIButton!
    @IBOutlet weak var newBtn: UIButton!
    
    @IBOutlet weak var emptyImg: UIImageView!
    
    var viewModel = OrderViewModel()
    var newOrders = [Datum]()
    var cancelledOrders = [Datum]()
    var status = "New"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        setBtnSelected(btn: newBtn)
        setBtnNormal(btn: canceledBtn)
        addbackImgAction()
        bindData()
        viewModel.getData()
    }
    
    
    @IBAction func filter(_ sender: UIButton) {
        indicator.isHidden = false // Show the indicator
            
            if sender.tag == 0 {
                status = "New"
                setBtnSelected(btn: newBtn)
                setBtnNormal(btn: canceledBtn)
                hideImage(array: newOrders)
            } else {
                status = "canceled"
                setBtnSelected(btn: canceledBtn)
                setBtnNormal(btn: newBtn)
                hideImage(array: cancelledOrders)
            }
            
            tableView.reloadData()
            indicator.stopAnimating()
    }
    
    func setBtnNormal(btn :UIButton){
        btn.layer.cornerRadius = 16
        btn.layer.backgroundColor = UIColor.white.cgColor
        btn.layer.borderColor = UIColor.black.cgColor
        btn.layer.borderWidth = 1
        btn.setTitleColor(.black, for: .normal)
    }
    
    func setBtnSelected(btn :UIButton){
        btn.layer.cornerRadius = 16
        btn.layer.backgroundColor = UIColor.black.cgColor
        btn.setTitleColor(.white, for: .normal)
    }
    
    func hideImage(array:[Datum]){
        if array.count == 0{
            emptyImg.isHidden = false
        }else{
            emptyImg.isHidden = true
        }
    }
    
    func bindData(){
        indicator.isHidden = false
        viewModel.bindOrdersToView = { [weak self] in
            guard let self = self else {return}
            DispatchQueue.main.async {
                self.newOrders = self.viewModel.newOrders
                self.cancelledOrders = self.viewModel.canceledOrders
                self.hideImage(array: self.newOrders)
                self.tableView.reloadData()
                self.indicator.stopAnimating()
            }
        }
    }
    
    func setUpTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: OrderCell.id, bundle: nil), forCellReuseIdentifier: OrderCell.id)
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
