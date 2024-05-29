//
//  OnBoarding_VC.swift
//  GoShop
//
//  Created by MAC on 17/12/2023.
//

import UIKit

class OnBoarding_VC: UIViewController {
    
    //MARK: -IBOutlets

    @IBOutlet weak var nextBtn: UIImageView!
    @IBOutlet weak var slideCollectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    //MARK: -Variables

    var slides: [OnBoardingSlide] = []
    var currentPage = 0 {
        didSet {
            pageControl.currentPage = currentPage
        }
    }
    
    //MARK: -View Controller Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setData()
        setUpCollectionView()
        addAction()
    }
    
    //MARK: -Methods

    func setData(){
        slides = [
            OnBoardingSlide(title:OnBoardingStrings.title_1.rawValue , description: OnBoardingStrings.description_1.rawValue, img: UIImage(named:"5")!),
            OnBoardingSlide(title: OnBoardingStrings.title_2.rawValue, description: OnBoardingStrings.description_2.rawValue, img: UIImage(named:"3")!),
            OnBoardingSlide(title:OnBoardingStrings.title_3.rawValue, description: OnBoardingStrings.description_3.rawValue, img: UIImage(named:"2")!)
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
            let vc = Splash_VC()
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
        } else if currentPage < slides.count - 1 {
            currentPage += 1
            let indexPath = IndexPath(item: currentPage, section: 0)
            slideCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
    
    private enum OnBoardingStrings : String{
        case title_1 = "20% Discount New Arrival Product"
        case title_2 = "Take Advantage Of The Offer Shopping"
        case title_3 = "All Types Of Offers Within Your Reach"
        case description_1 = "Experience a variety of amazing items from different places around the world."
        case description_2 = "Our products are prepared by only the best."
        case description_3 = "Your orders will be delivered instantly irrespective of your location around the world."
    }
}

//MARK: -Extensions

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
