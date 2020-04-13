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
    private var currencyModel: [Curency] = [.rubles]
    lazy private var currentCurencyImage: UIImage? = UIImage(systemName: "dollarsign.circle.fill")?.withTintColor(burbColor)
    
    private let dollarImage = UIImage(systemName: "dollarsign.circle.fill")?.withTintColor(burbColor)
    private let euroImage = UIImage(systemName: "eurosign.circle.fill")?.withTintColor(burbColor)
    private let rurImage = UIImage(systemName: "rublesign.circle.fill")?.withTintColor(burbColor)
    
    private var pricingModel: PricingModel?
    private var currentBarber: BarberSQL?
    
    @IBOutlet weak var tableView: UITableView!
    
    override init(nibName: String?, bundle: Bundle?) {
        super.init(nibName: nibName, bundle: bundle)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(nibName: BUBarberPricingViewController.name, bundle: Bundle.main)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Decorator.decorate(self)
        delegating()
        registerCells()
        initIfavailable()
        initPricingModel()
    }
    
    private func initIfavailable() {
        SpecifyCityInteractor.shared.fetchBarberSQL { (data) in
            self.currentBarber = data
        }
    }
    
    private func initPricingModel() {
        self.pricingModel = PricingModel(curency: .rubles, haircut: Int.init(), beardHaircur: Int.init(), babyHaircut: Int.init(), dangerousShave: Int.init(), clipper: Int.init(), stacking: Int.init())
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
        guard let barberId = self.currentBarber?.id, let barberPricingModel = self.pricingModel else { return }
        BarberPricingInteractor.shared.savePricingData(by: barberId, with: barberPricingModel)
        BarberPricingRouter.shared.handleOnboarding(from: self, with: .Barber)
    }
    
    fileprivate func switchCurency(with image: UIImage) {
        if let cell = self.tableView.dequeueReusableCell(withIdentifier: SetPriceTableViewCell.name) as? SetPriceTableViewCell {
            cell.priceTextField.iconImage = image
            self.tableView.reloadData()
        }
    }
    
    fileprivate func updateDoneButtonStatus() {
        if let cell = self.tableView.dequeueReusableCell(withIdentifier: BUButtonTableViewCell.name) as? BUButtonTableViewCell {
            cell.button.isEnabled = ((self.pricingModel?.pricingIsFilled) != nil)
        }
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
                    cell.index = index
                    let currency = self.curencyModel[index]
                    self.pricingModel?.curency = currency
                    self.currentCurencyImage = self.rurImage
                    
                    switch index {
                    case 0:
                        self.switchCurency(with: self.currentCurencyImage!)
                        self.currentCurencyImage = self.rurImage
                        self.updateDoneButtonStatus()
                    case 1:
                        self.switchCurency(with: self.currentCurencyImage!)
                        self.currentCurencyImage = self.dollarImage
                        self.updateDoneButtonStatus()
                    case 2:
                        self.switchCurency(with: self.currentCurencyImage!)
                        self.currentCurencyImage = self.euroImage
                        self.updateDoneButtonStatus()
                    default:
                        break
                    }
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
                if let haircutImage = UIImage(named: "cut1") {
                    cell.setPicture(image: haircutImage)
                }
                cell.setPriceImage(image: self.currentCurencyImage!)
                cell.textChanged = {
                    text in
                    self.pricingModel?.haircut = Int(text)
                    self.updateDoneButtonStatus()
                }
                return cell
            }
        case .beardHaircut:
            if let cell = self.tableView.dequeueReusableCell(withIdentifier: SetPriceTableViewCell.name, for: indexPath) as? SetPriceTableViewCell {
                cell.setTitle(text: "_BEARDHAIRCUT")
                if let beardHaircutImage = UIImage(named: "cut2") {
                    cell.setPicture(image: beardHaircutImage)
                }
                cell.setPriceImage(image: self.currentCurencyImage!)
                cell.textChanged = {
                    text in
                    self.pricingModel?.beardHaircur = Int(text)
                    self.updateDoneButtonStatus()
                }
                return cell
            }
        case .babyHaircut:
            if let cell = self.tableView.dequeueReusableCell(withIdentifier: SetPriceTableViewCell.name, for: indexPath) as? SetPriceTableViewCell {
                cell.setTitle(text: "_BABYHAIRCUT")
                if let babyHaircutImage = UIImage(named: "cut3") {
                    cell.setPicture(image: babyHaircutImage)
                }
                cell.setPriceImage(image: self.currentCurencyImage!)
                cell.textChanged = {
                    text in
                    self.pricingModel?.babyHaircut = Int(text)
                    self.updateDoneButtonStatus()
                }
                return cell
            }
        case .dangerousShave:
            if let cell = self.tableView.dequeueReusableCell(withIdentifier: SetPriceTableViewCell.name, for: indexPath) as? SetPriceTableViewCell {
                cell.setTitle(text: "_DANGEROUSSAVE")
                if let dangerousShaveImage = UIImage(named: "cut4") {
                    cell.setPicture(image: dangerousShaveImage)
                }
                cell.setPriceImage(image: self.currentCurencyImage!)
                cell.textChanged = {
                    text in
                    self.pricingModel?.dangerousShave = Int(text)
                    self.updateDoneButtonStatus()
                }
                return cell
            }
        case .clipper:
            if let cell = self.tableView.dequeueReusableCell(withIdentifier: SetPriceTableViewCell.name, for: indexPath) as? SetPriceTableViewCell {
                cell.setTitle(text: "_CLIPPER")
                if let clipperImage = UIImage(named: "cut5") {
                    cell.setPicture(image: clipperImage)
                }
                cell.setPriceImage(image: self.currentCurencyImage!)
                cell.textChanged = {
                    text in
                    self.pricingModel?.clipper = Int(text)
                    self.updateDoneButtonStatus()
                }
                return cell
            }
        case .stacking:
            if let cell = self.tableView.dequeueReusableCell(withIdentifier: SetPriceTableViewCell.name, for: indexPath) as? SetPriceTableViewCell {
                cell.setTitle(text: "_STACKING")
                if let stackingImage = UIImage(named: "cut6") {
                    cell.setPicture(image: stackingImage)
                }
                cell.setPriceImage(image: self.currentCurencyImage!)
                cell.textChanged = {
                    text in
                    self.pricingModel?.stacking = Int(text)
                    self.updateDoneButtonStatus()
                }
                return cell
            }
        case .button:
            if let cell = self.tableView.dequeueReusableCell(withIdentifier: BUButtonTableViewCell.name, for: indexPath) as? BUButtonTableViewCell {
                cell.button.setTitle("_CONFIRM", for: .normal)
                cell.setColor(color: burbColor)
                cell.setFont(font: UIFont(name: "OpenSans-Semibold", size: 15)!)
                cell.button.tintColor = .white
                cell.button.isEnabled = ((pricingModel?.pricingIsFilled) != nil)
                cell.buttonHandler = {
                    self.handleOnboarding()
                }
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
            return 52
        case .beardHaircut:
            return 52
        case .babyHaircut:
            return 52
        case .dangerousShave:
            return 52
        case .clipper:
            return 52
        case .stacking:
            return 52
        case .button:
            return 50
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let headerModels = headerModel[section]
        switch headerModels {
        case .textLabel:
            return 0
        case .curency:
            return 0
        case .nameAndPrice:
            return 0
        case .haircut:
            return 0
        case .beardHaircut:
            return 3
        case .babyHaircut:
            return 3
        case .dangerousShave:
            return 3
        case .clipper:
            return 3
        case .stacking:
            return 3
        case .button:
            return self.tableView.frame.height / 9
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
