//
//  BUSignupViaPhoneViewController.swift
//  Burb
//
//  Created by Eugene on 16.01.2020.
//  Copyright © 2020 CC_Eugene. All rights reserved.
//

import UIKit
import FlagPhoneNumber

class BUSignupViaPhoneViewController: UIViewController {
    
    fileprivate enum CellModel {
        case phoneNumber
        case confirmCode
    }
    
    var registerModel: RegisterModel?
    
    private let model: [CellModel] = [.phoneNumber, .confirmCode]
    private var dialCode: String? = "+7"
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegating()
        registerCells()
        setupBackBarItem()
        Decorator.decorate(self)
        addRightBarButton()
        initRegisterModel()
        updateDoneButtonStatus()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    private func initRegisterModel() {
        self.registerModel = RegisterModel(phoneNumber: "", securityCode: "", country: "unknowned")
    }
    
    private func updateDoneButtonStatus() {
        navigationItem.rightBarButtonItem?.isEnabled = self.registerModel!.phoneIsFilled
    }

    private func updateDoneButtonStatusForHandleCreateUser() {
        navigationItem.rightBarButtonItem?.isEnabled = self.registerModel!.securityCodeIsFilled
    }
    
    private func delegating() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
    
    private func registerCells() {
        collectionView.register(PhoneNumberCollectionViewCell.nib, forCellWithReuseIdentifier: PhoneNumberCollectionViewCell.name)
        collectionView.register(ConfirmCodeCollectionViewCell.nib, forCellWithReuseIdentifier: ConfirmCodeCollectionViewCell.name)
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
        SignupPhoneInteractor.shared.sendConfirmCode(securityCode: registerModel?.securityCode ?? "", phoneNumber: registerModel?.phoneNumber ?? "")
        AuthManager.shared.signIn()
        SignupPhoneRouter.shared.goToChooseRoleVC(from: self)
    }
    
    private func addRightBarButton() {
        let rightBarBarButton = UIBarButtonItem(title: "_DONE", style: .done, target: self, action: #selector(handleToConfirmCode))
        rightBarBarButton.tintColor = burbColor
        navigationItem.rightBarButtonItem = rightBarBarButton
    }
    
    @objc private func handleToConfirmCode() {
        guard let phoneNumber = self.registerModel?.phoneNumber, let dial = self.dialCode else { return }
        let phoneToSend: String = "\(dial)" + "\(phoneNumber)"
        SignupPhoneInteractor.shared.sendPhoneNumber(phoneNumber: phoneToSend)
        collectionView.scrollToItem(at: IndexPath(row: 1, section: 0), at: .centeredHorizontally, animated: true)
        let rightBarBarButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(handleChooseRole))
        rightBarBarButton.tintColor = burbColor
        rightBarBarButton.isEnabled = false
        navigationItem.rightBarButtonItem = rightBarBarButton
     //   SignupPhoneInteractor.shared.checkIfUserExists(phoneNumber: phoneToSend)
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
                delay(seconds: 0.5) {
                    cell.phoneNumberTextField.becomeFirstResponder()
                }
                cell.phoneNumberTextField.delegate = self 
                cell.setSecurityLabel(text: "_ALLYOURDATAISINSECUREDAREA")
                cell.setPhoneLabelText(text: "_YOURPHONENUMBER")
                cell.textChanged = {
                    text in
                   self.registerModel?.phoneNumber = text
                   self.updateDoneButtonStatus()
                }
                return cell
            }
        case .confirmCode:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ConfirmCodeCollectionViewCell.name, for: indexPath) as? ConfirmCodeCollectionViewCell {
                cell.setCodeLabelText(text: "_ENTERCODEFROMSMS")
                cell.setSecurityLabel(text: "_IFYOUDIDNTRECIEVETHESMS")
                cell.codeTextField.defaultTextAttributes.updateValue(5.0, forKey: NSAttributedString.Key(rawValue: NSAttributedString.Key.kern.rawValue))
                cell.textChanged = {
                    text in
                    self.registerModel?.securityCode = text
                    self.updateDoneButtonStatus()
                }
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
            vc.title = "_SIGNUPVIAPHONE"
        }
    }
}

extension BUSignupViaPhoneViewController: FPNTextFieldDelegate {
    
    func fpnDidSelectCountry(name: String, dialCode: String, code: String) {
        self.registerModel?.country = name
        self.dialCode = dialCode
    }
    
    func fpnDidValidatePhoneNumber(textField: FPNTextField, isValid: Bool) {
         print("textField - \(textField)" + " isValid - \(isValid)")
    }
    
    func fpnDisplayCountryList() {
        
    }
    
}
