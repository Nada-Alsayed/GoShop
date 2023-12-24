//
//  Profile_VC.swift
//  GoShop
//
//  Created by MAC on 23/12/2023.
//

import UIKit

class Profile_VC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCollectionView()
    }
    
    func setUpCollectionView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: section_1.id, bundle: nil), forCellReuseIdentifier: section_1.id)
        tableView.register(UINib(nibName: section_2.id, bundle: nil), forCellReuseIdentifier: section_2.id)
    }
}
