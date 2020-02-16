//
//  BUSignupViaPhoneViewController.swift
//  Burb
//
//  Created by Eugene on 16.01.2020.
//  Copyright © 2020 CC_Eugene. All rights reserved.
//

import UIKit

class BUSignupViaPhoneViewController: UIViewController {
    
    fileprivate enum CellModel {
        case phoneNumber
        case confirmCode
    }
    
    var phoneNumber: String?
    var confirmCode: String?
    
    private let model: [CellModel] = [.phoneNumber, .confirmCode]
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegating()
        registerCells()
        setupBackBarItem()
        Decorator.decorate(self)
        addRightBarButton()
        
        
        self.title = "_SIGNUPVIAPHONE"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    
    
    private func delegating() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }

    private func registerCells() {
        collectionView.register(PhoneNumberCollectionViewCell.nib, forCellWithReuseIdentifier: PhoneNumberCollectionViewCell.name)
    }

    private func setupBackBarItem() {
        var barButton = UIBarButtonItem(customView: UIImageView(image: UIImage(named: "icBack")))
        barButton = UIBarButtonItem(image: UIImage(named: "icBack"), style: .plain, target: self, action: #selector(goBack))
        barButton.tintColor = UIColor.black
        navigationItem.leftBarButtonItem = barButton
    }
    
    @objc private func goBack() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func handleChooseRole() {
        SignupPhoneRouter.shared.goToChooseRoleVC(from: self)
        
    }
    
    private func addRightBarButton() {
        let rightBarBarButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(handleToConfirmCode))
        rightBarBarButton.tintColor = burbColor
        navigationItem.rightBarButtonItem = rightBarBarButton
    }
    
    @objc private func handleToConfirmCode() {
      //  SignupPhoneInteractor.shared.sendPhoneNumber(phoneNumber: self.phoneNumber!)
        collectionView.scrollToItem(at: IndexPath(row: 1, section: 0), at: .centeredHorizontally, animated: true)
        let rightBarBarButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(handleChooseRole))
        rightBarBarButton.tintColor = burbColor
        navigationItem.rightBarButtonItem = rightBarBarButton
    }

    
}


extension BUSignupViaPhoneViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let models = model[indexPath.row]
            
        switch models {
        case .phoneNumber:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhoneNumberCollectionViewCell.name, for: indexPath) as? PhoneNumberCollectionViewCell {
                cell.phoneNumberTextField.text = self.phoneNumber
                cell.setSecurityLabel(text: "_ALLYOURDATAISINSECUREDAREA")
                cell.setPhoneLabelText(text: "_YOURPHONENUMBER")
                return cell
            }
        case .confirmCode:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhoneNumberCollectionViewCell.name, for: indexPath) as? PhoneNumberCollectionViewCell {
                cell.phoneNumberTextField.text = self.confirmCode
                cell.setPhoneLabelText(text: "_ENTERCODEFROMSMS")
                cell.setSecurityLabel(text: "_IFYOUDIDNTRECIEVETHESMS")
                cell.phoneNumberTextField.defaultTextAttributes.updateValue(5.0, forKey: NSAttributedString.Key(rawValue: NSAttributedString.Key.kern.rawValue))
                return cell
            }
        }
        return UICollectionViewCell.init()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collectionView.frame.size.width, height: self.collectionView.frame.size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    

    
}


extension BUSignupViaPhoneViewController {
    fileprivate class Decorator {
        static func decorate(_ vc: BUSignupViaPhoneViewController) {
            vc.collectionView.bounces = false
            vc.collectionView.isScrollEnabled = false
            vc.navigationController?.navigationBar.barTintColor = UIColor.white
            vc.navigationController?.navigationBar.shadowImage = UIImage()
            vc.hideKeyboardWhenTappedAround()
        }
        
    }
    
}
