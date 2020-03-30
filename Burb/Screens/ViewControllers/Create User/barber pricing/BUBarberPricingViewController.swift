//
//  BUBarberPricingViewController.swift
//  Burb
//
//  Created by Eugene on 19.02.2020.
//  Copyright © 2020 CC_Eugene. All rights reserved.
//

import UIKit

class BUBarberPricingViewController: UIViewController, NiBLoadable {
    
    fileprivate enum CellModel {
        case textLabel
        case curency
        case nameAndPrice
        case haircut
        case beardHaircut
        case babyHaircut
        case dangerousShave
        case clipper
        case stacking
        case button
    }
    
    fileprivate enum HeaderModel {
        typealias CellType = CellModel
        case textLabel
        case curency
        case nameAndPrice
        case haircut
        case beardHaircut
        case babyHaircut
        case dangerousShave
        case clipper
        case stacking
        case button
        
        var cellModels: [BUBarberPricingViewController.CellModel] {
            switch self {
            case .textLabel: return [.textLabel]
            case .curency: return [.curency]
            case .nameAndPrice: return [.nameAndPrice]
            case .haircut: return [.haircut]
            case .beardHaircut: return [.beardHaircut]
            case .babyHaircut: return [.babyHaircut]
            case .dangerousShave: return [.dangerousShave]
            case .clipper: return [.clipper]
            case .stacking: return [.stacking]
            case .button: return [.button]
            }
        }
    }
    
    private let curencyModel: [Curency] = [.rubles, .euro, .dollars]
    private var headerModel: [HeaderModel] = [.textLabel, .curency, .nameAndPrice, .haircut, .beardHaircut, .babyHaircut, .dangerousShave, .clipper, .stacking, .button]
    private var model: [CellModel] = [.textLabel, .curency, .nameAndPrice, .haircut, .beardHaircut, .babyHaircut, .dangerousShave, .clipper, .stacking, .button]
    
    private var pricingModel: PricingModel?
    @IBOutlet weak var tableView: UITableView!
    
    
    init(barber: Barber, nibName: String?, bundle: Bundle?) {
        self.pricingModel?.barber = barber
        super.init(nibName: nibName, bundle: bundle)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(nibName: BUBarberPricingViewController.name, bundle: Bundle.main)
 }
 
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
     super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
 }
 
    deinit {
     NotificationCenter.default.removeObserver(self)
 }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Decorator.decorate(self)
        delegating()
        registerCells()
    }
    
    private func delegating() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    private func registerCells() {
        tableView.register(BULabelTableViewCell.nib, forCellReuseIdentifier: BULabelTableViewCell.name)
        tableView.register(BUButtonTableViewCell.nib, forCellReuseIdentifier: BUButtonTableViewCell.name)
        tableView.register(SetPriceTableViewCell.nib, forCellReuseIdentifier: SetPriceTableViewCell.name)
        tableView.register(PricingLabelsTableViewCell.nib, forCellReuseIdentifier: PricingLabelsTableViewCell.name)
        tableView.register(SegmentControllTableViewCell.nib, forCellReuseIdentifier: SegmentControllTableViewCell.name)
    }
    
    @objc func handleOnboarding() {
        print("asdad")
    }
    
}

extension BUBarberPricingViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return model.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return headerModel[section].cellModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let models = headerModel[indexPath.section].cellModels[indexPath.row]
        switch  models {
        case .textLabel:
            if let cell = self.tableView.dequeueReusableCell(withIdentifier: BULabelTableViewCell.name, for: indexPath) as? BULabelTableViewCell {
                cell.textLabel?.textAlignment = .center
                cell.setFont(font: UIFont(name: "Open Sans", size: 18)!)
                cell.setText(text: "_SETPRICEFORSERVICE")
                return cell
            }
        case .curency:
            if let cell = self.tableView.dequeueReusableCell(withIdentifier: SegmentControllTableViewCell.name, for: indexPath) as? SegmentControllTableViewCell {
                cell.set(titles: self.curencyModel.map{ $0.rawValue.capitalized})
                cell.indexChanged = {
                    index in
                    print(index)
                    cell.index = index
                    
                }
                return cell
            }
        case .nameAndPrice:
            if let cell = self.tableView.dequeueReusableCell(withIdentifier: PricingLabelsTableViewCell.name, for: indexPath) as? PricingLabelsTableViewCell {
                cell.setText(serviceText: "_SERVICE", priceText: "_PRICE")
                return cell
            }
        case .haircut:
            if let cell = self.tableView.dequeueReusableCell(withIdentifier: SetPriceTableViewCell.name, for: indexPath) as? SetPriceTableViewCell {
                cell.setTitle(text: "_HAIRCUT")
                if let haircutImage = UIImage(named: "haircut") {
                 cell.setPicture(image: haircutImage)
                }
                return cell
            }
        case .beardHaircut:
            if let cell = self.tableView.dequeueReusableCell(withIdentifier: SetPriceTableViewCell.name, for: indexPath) as? SetPriceTableViewCell {
                cell.setTitle(text: "_BEARDHAIRCUT")
                if let beardHaircutImage = UIImage(named: "beardHaircut") {
                 cell.setPicture(image: beardHaircutImage)
                }
                return cell
            }
        case .babyHaircut:
            if let cell = self.tableView.dequeueReusableCell(withIdentifier: SetPriceTableViewCell.name, for: indexPath) as? SetPriceTableViewCell {
                cell.setTitle(text: "_BABYHAIRCUT")
                if let babyHaircutImage = UIImage(named: "babyHaircut") {
                 cell.setPicture(image: babyHaircutImage)
                }
                return cell
            }
        case .dangerousShave:
            if let cell = self.tableView.dequeueReusableCell(withIdentifier: SetPriceTableViewCell.name, for: indexPath) as? SetPriceTableViewCell {
                cell.setTitle(text: "_DANGEROUSSAVE")
                if let dangerousShaveImage = UIImage(named: "dangerousShave") {
                 cell.setPicture(image: dangerousShaveImage)
                }
                return cell
            }
        case .clipper:
            if let cell = self.tableView.dequeueReusableCell(withIdentifier: SetPriceTableViewCell.name, for: indexPath) as? SetPriceTableViewCell {
                cell.setTitle(text: "_CLIPPER")
                if let clipperImage = UIImage(named: "clipper") {
                 cell.setPicture(image: clipperImage)
                }
                return cell
            }        case .stacking:
                if let cell = self.tableView.dequeueReusableCell(withIdentifier: SetPriceTableViewCell.name, for: indexPath) as? SetPriceTableViewCell {
                    cell.setTitle(text: "_STACKING")
                    if let stackingImage = UIImage(named: "stacking") {
                     cell.setPicture(image: stackingImage)
                    }
                    return cell
            }        case .button:
                if let cell = self.tableView.dequeueReusableCell(withIdentifier: BUButtonTableViewCell.name, for: indexPath) as? BUButtonTableViewCell {
                    cell.button.setTitle("_CONFIRM", for: .normal)
                    cell.setColor(color: burbColor)
                    cell.setFont(font: UIFont(name: "OpenSans-Semibold", size: 15)!)
                    cell.button.tintColor = .white
                    cell.button.addTarget(self, action: #selector(handleOnboarding), for: .touchUpInside)
                    return cell
            }
        }
        return UITableViewCell.init()
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let models = headerModel[indexPath.section].cellModels[indexPath.row]
        switch models {
        case .textLabel:
            return 50
        case .curency:
            return 44
        case .nameAndPrice:
            return 44
        case .haircut:
            return 44
        case .beardHaircut:
            return 44
        case .babyHaircut:
            return 44
        case .dangerousShave:
            return 44
        case .clipper:
            return 44
        case .stacking:
            return 44
        case .button:
            return 50
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let headerModels = headerModel[section]
        switch headerModels {
        case .textLabel:
            return 44
        case .curency:
            return 0
        case .nameAndPrice:
            return 0
        case .haircut:
            return 0
        case .beardHaircut:
            return 0
        case .babyHaircut:
            return 0
        case .dangerousShave:
            return 0
        case .clipper:
            return 0
        case .stacking:
            return 0
        case .button:
            return self.tableView.frame.height / 10
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        _ = headerModel[section]
        return UIView.init()
    }
    
    
    
}


extension BUBarberPricingViewController {
    fileprivate class Decorator {
        private init() {}
        
        static func decorate(_ vc: BUBarberPricingViewController) {
            vc.title = "_PRICING"
            vc.navigationController?.navigationBar.barTintColor = UIColor.white
            vc.navigationController?.navigationBar.shadowImage = UIImage()
            vc.hideKeyboardWhenTappedAround()
        }
        
    }
}
