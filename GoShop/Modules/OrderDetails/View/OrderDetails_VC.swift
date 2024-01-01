//
//  OrderDetails_VC.swift
//  GoShop
//
//  Created by MAC on 30/12/2023.
//

import UIKit

class OrderDetails_VC: UIViewController {

    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var backImg: UIImageView!
    @IBOutlet weak var productsCollectionView: UICollectionView!
    @IBOutlet weak var region: UILabel!
    @IBOutlet weak var city: UILabel!
    @IBOutlet weak var payMethod: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var cost: UILabel!
    @IBOutlet weak var discount: UILabel!
    @IBOutlet weak var total: UILabel!
    @IBOutlet weak var cancelBtn: UIButton!
    
    var productID : Int? = 0
    var status : String? = ""
    var viewModel = OrderDetailsViewModel()
    var orderDetails = OrderDetails()
    var delegateReload : ReloadViewDelegate?
    
    override func viewWillAppear(_ animated: Bool) {
        if status == "New"{
            cancelBtn.isHidden = false
        }else{
            cancelBtn.isHidden = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addbackImgAction()
        setUpCollectionView()
        setUI()
        bindData()
        viewModel.getData(product_id: productID ?? 0)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if isBeingDismissed {
            delegateReload?.reloadView()
        }
    }
    
    @IBAction func cancelOrder(_ sender: Any) {
        cancelBtn.isUserInteractionEnabled = true
        viewModel.cancelOrder(orderId: orderDetails.id)
    }
    
    func setUI(){
        cancelBtn.isUserInteractionEnabled = false
        cancelBtn.layer.cornerRadius = 20
    }
    
    func setUpData(orderDetails:OrderDetails){
        region.text = orderDetails.address.region
        city.text = orderDetails.address.city
        payMethod.text = orderDetails.paymentMethod
        date.text = orderDetails.date
        cost.text = "$\(Float(orderDetails.cost))"
        discount.text = "$\(Float(orderDetails.discount))"
        total.text = "$\(Float(orderDetails.total))"
    }
    
    func bindData(){
        indicator.isHidden = false
        viewModel.bindOrderToView = { [weak self] in
            guard let self = self else {return}
            DispatchQueue.main.async {
                print("kkkk")
                self.orderDetails = self.viewModel.orderDetails
                self.setUpData(orderDetails: self.orderDetails)
                self.productsCollectionView.reloadData()
                self.indicator.stopAnimating()
                self.cancelBtn.isUserInteractionEnabled = true
            }
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
