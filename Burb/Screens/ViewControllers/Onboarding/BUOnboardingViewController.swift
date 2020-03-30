//
//  BUOnboardingViewController.swift
//  Burb
//
//  Created by Eugene on 28.03.2020.
//  Copyright © 2020 CC_Eugene. All rights reserved.
//

import UIKit

class BUOnboardingViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    
    
    typealias data = (image: UIImage, title1: String, title2: String)
    var dataArray = [data]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Decorator.decorate(self)
        
        fillData()
        
        delegating()
        registerCells()
        
        setupPageControl()
    }
    
    private func setupPageControl() {
        
        pageControl!.numberOfPages = 3
        pageControl!.currentPage = 0
        pageControl!.pageIndicatorTintColor = UIColor.lightGray.withAlphaComponent(0.5)
        pageControl!.currentPageIndicatorTintColor = burbColor
    }
    
    
    private func delegating() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    
    private func registerCells() {
        collectionView.register(OnboardingCVCell.nib, forCellWithReuseIdentifier: OnboardingCVCell.name)
    }
    
    fileprivate func fillData() {
        var data1, data2, data3: data!
        
//        if CurrentUser.instance.user.customer != nil {
            data1 = data(
                image: UIImage.init(), title1: "_the_right_cut", title2: "_in_the_right_place_at_right_time")
            data2 = data(
                image: UIImage.init(), title1: "_enjoy_the_progress", title2: "_instead_of_wasting_time_and_finding_a_spot")
            data3 = data(
                image: UIImage.init(), title1: "_less_is_more", title2: "_exceptional_level_of_services_to_be_satisfied_with")
//        }
//        else {
//            data1 = data(
//                image: UIImage(named: "")!, title1: "no_middlemen", title2: "work_with_your_clients_directly")
//            data2 = data(
//                image: UIImage(named: "")!, title1: "_taylor-made_schedule", title2: "the_best_work_schedule_is_self-created")
//            data3 = data(
//                image: UIImage(named: "")!, title1: "raise_vibration", title2: "_real_pro_always_in_demand")
//        }
        dataArray = [data1, data2, data3]
    }
    
    // MARK: ACTIONS
      func bottomButtonPressed() {
        let indexPath = (self.collectionView?.indexPathsForVisibleItems.first)!
        
        if indexPath.item == dataArray.count - 1 {
            let orderLocationVC = BUOrderLocationPickerViewController()
            self.navigationController?.setViewControllers([orderLocationVC], animated: true)
        }
        else
        {
            let nextIndexPath = IndexPath(item: indexPath.item + 1, section: indexPath.section)
            self.collectionView?.scrollToItem(at: nextIndexPath, at: .centeredHorizontally, animated: true)
        }
    }
}


extension BUOnboardingViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingCVCell.name, for: indexPath) as! OnboardingCVCell
        let data = dataArray[indexPath.row]
        cell.fillWith(data: data)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collectionView.frame.size.width, height: self.collectionView.frame.size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets (top: 0, left: 0, bottom: 0, right: 0)
    }
}

extension BUOnboardingViewController: UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        newPageWasShown()
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        newPageWasShown()
    }
    
    fileprivate func newPageWasShown() {
        let index = Int(collectionView!.contentOffset.x / collectionView!.frame.size.width);
        
        pageControl!.currentPage = index
        
        let title = ((index == dataArray.count - 1) ? NSLocalizedString("let's ride", comment: "") : NSLocalizedString("next", comment: "")).uppercased()
        self.doneButton!.setTitle(title, for: .normal)
    }
}

extension BUOnboardingViewController {
    fileprivate class Decorator {
        private init() {}
        
        static func decorate(_ vc: BUOnboardingViewController) {
            vc.doneButton.tintColor = burbColor
            vc.doneButton.titleLabel?.font = UIFont(name: "OpenSans-Semibold", size: 15)
            vc.navigationController?.navigationBar.barTintColor = UIColor.white
            vc.navigationController?.navigationBar.shadowImage = UIImage()
        }
    }
}
