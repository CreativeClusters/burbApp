//
//  BULoginViewController.swift
//  Burb
//
//  Created by Eugene on 13.01.2020.
//  Copyright © 2020 CC_Eugene. All rights reserved.
//

import UIKit

class BULoginViewController: UIViewController, UIPopoverPresentationControllerDelegate {
    
    fileprivate enum CellModel {
        case logo
        case signupViaPhone
        case signupAsFacebook
        case termsOfUse
    }
    
    fileprivate enum HeaderModel {
        typealias CellType = CellModel
        case logo
        case signupViaPhone
        case signupAsFacebook
        case termsOfUse
        
        
        var cellModels: [BULoginViewController.CellModel] {
            switch self {
            case .logo: return [.logo]
            case .signupViaPhone: return [.signupViaPhone]
            case .signupAsFacebook: return [.signupAsFacebook]
            case .termsOfUse: return [.termsOfUse]
            }
        }
    }
    
    private let models: [CellModel] = [.logo, .signupViaPhone, .signupAsFacebook, .termsOfUse]
    private let HeaderModels: [HeaderModel] = [.logo, .signupViaPhone, .signupAsFacebook, .termsOfUse]
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegating()
        registerCells()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    private func delegating() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    private func registerCells() {
        tableView.register(LogoTableViewCell.nib, forCellReuseIdentifier: LogoTableViewCell.name)
        tableView.register(BUButtonTableViewCell.nib, forCellReuseIdentifier: BUButtonTableViewCell.name)
    }
}


extension BULoginViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return HeaderModels[section].cellModels.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let headerModel = HeaderModels[section]
        switch headerModel {
        case .logo:
            return self.tableView.frame.height / 8
        case .signupAsFacebook:
            return 16
        case .signupViaPhone:
            return  self.tableView.frame.height / 6
        case .termsOfUse:
            return self.tableView.frame.height / 7
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerModel = HeaderModels[section]
        switch headerModel {
        case .logo, .signupAsFacebook, .signupViaPhone, .termsOfUse:
            let view = HeaderView.loadFromNib()
            view.setColor(color: UIColor.white)
            return view
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = HeaderModels[indexPath.section].cellModels[indexPath.row]
        switch  model {
        case .logo:
            if let cell = tableView.dequeueReusableCell(withIdentifier: LogoTableViewCell.name, for: indexPath) as? LogoTableViewCell {
                cell.setTitle(text: "_PERSONALHAIRCUTLOCATOR")
                cell.setLabelFont(font: UIFont(name: "OpenSans", size: 18)!)
                return cell
            }
        case .signupAsFacebook:
            if let cell = tableView.dequeueReusableCell(withIdentifier: BUButtonTableViewCell.name, for: indexPath) as? BUButtonTableViewCell {
                cell.setTitle(text: "_LOGINVIAFACEBOOK")
                cell.setColor(color: .black)
                cell.setTitleColor(color: .white)
                cell.setFont(font: UIFont(name: "OpenSans-Semibold", size: 15)!)
                return cell
            }
        case .signupViaPhone:
            if let cell = tableView.dequeueReusableCell(withIdentifier: BUButtonTableViewCell.name, for: indexPath) as? BUButtonTableViewCell {
                cell.setTitle(text: "_LOGINVIAPHONE")
                cell.setColor(color: burbColor)
                cell.setTitleColor(color: .white)
                cell.setFont(font: UIFont(name: "OpenSans-Semibold", size: 15)!)
                cell.buttonHandler = { [unowned self]  in
                    LoginRouter.shared.goToSignupViaPhoneViewController(from: self)
                }
                return cell
            }
        case .termsOfUse:
            if let cell = tableView.dequeueReusableCell(withIdentifier: BUButtonTableViewCell.name, for: indexPath) as? BUButtonTableViewCell {
                cell.setColor(color: .white)
                cell.setTitleColor(color: .black)
                let attributedString = NSMutableAttributedString(string: "I agree with terms of use", attributes: [
                    .font: UIFont(name: "OpenSans-Light", size: 12.0)!,
                    .foregroundColor: UIColor(white: 50.0 / 255.0, alpha: 1.0)
                ])
                attributedString.addAttribute(.font, value: UIFont(name: "OpenSans-Semibold", size: 12.0)!, range: NSRange(location: 13, length: 12))
                cell.setTitle(text: attributedString.string)
                cell.buttonHandler = { [unowned self ] in
                    LoginRouter.shared.goToTermsOfUseViewController(from: self)
                }
                return cell
            }
        }
        return UITableViewCell.init()
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let model = HeaderModels[indexPath.section].cellModels[indexPath.row]
        switch model {
        case .logo:
            return self.tableView.frame.height / 3
        case .signupAsFacebook, .signupViaPhone, .termsOfUse:
            return 45
        }
    }
}

extension BULoginViewController {
    fileprivate class Decorator {
        static func decorate(_ vc: BULoginViewController) {
            
        }
    }
}


class HalfSizePresentationController : UIPresentationController {
    override var frameOfPresentedViewInContainerView: CGRect {
        get {
            guard let theView = containerView else {
                return CGRect.zero
            }
            
            return CGRect(x: 0, y: theView.bounds.height / 2, width: theView.bounds.width, height: theView.bounds.height / 2)
        }
    }
}

extension BULoginViewController : UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return HalfSizePresentationController(presentedViewController: presented, presenting: presenting)
    }
}
