//
//  OnBoarding_VC.swift
//  GoShop
//
//  Created by MAC on 17/12/2023.
//

import UIKit

class OnBoarding_VC: UIViewController {
    
    @IBOutlet weak var nextBtn: UIImageView!
    @IBOutlet weak var slideCollectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var slides: [OnBoardingSlide] = []
    
    var currentPage = 0 {
        didSet {
            pageControl.currentPage = currentPage
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setData()
        setUpCollectionView()
        addAction()
    }
    
    func setData(){
        slides = [
            OnBoardingSlide(title: "20% Discount New Arrival Product", description: "Experience a variety of amazing items from different places around the world.", img: UIImage(named:"Slide1")!),
            OnBoardingSlide(title: "Take Advantage Of The Offer Shopping", description: "Our products are prepared by only the best.", img: UIImage(named:"Slide2")!),
            OnBoardingSlide(title: "All Types Of Offers Within Your Reach", description: "Your orders will be delivered instantly irrespective of your location around the world.", img: UIImage(named:"Slide3")!)
        ]
        pageControl.numberOfPages = slides.count
    }
    
    func setUpCollectionView(){
        slideCollectionView.delegate = self
        slideCollectionView.dataSource = self
        slideCollectionView.register(UINib(nibName: OnBoardingCell.identifier, bundle: nil), forCellWithReuseIdentifier: OnBoardingCell.identifier)
    }
    
    func addAction(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(moveNext) )
        nextBtn.isUserInteractionEnabled = true
        nextBtn.addGestureRecognizer(tap)
    }
    
    @objc func moveNext(){
        if currentPage == slides.count - 1 {
               let vc = BottomTaPBar()
               vc.modalPresentationStyle = .fullScreen
               self.present(vc, animated: true)
           } else if currentPage < slides.count - 1 {
               currentPage += 1
               let indexPath = IndexPath(item: currentPage, section: 0)
               slideCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
           }
    }
    
}

extension OnBoarding_VC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slides.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnBoardingCell.identifier, for: indexPath) as! OnBoardingCell
        cell.setUpCell(slides[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x / width)
    }
}
