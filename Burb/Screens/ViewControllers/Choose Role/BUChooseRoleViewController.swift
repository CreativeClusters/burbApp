//
//  BUChooseRoleViewController.swift
//  Burb
//
//  Created by Eugene on 19.01.2020.
//  Copyright © 2020 CC_Eugene. All rights reserved.
//

import UIKit

class ZoomAndSnapFlowLayout: UICollectionViewFlowLayout {
    
    let activeDistance: CGFloat = 200
    let zoomFactor: CGFloat = 0.3
    
    override init() {
        super.init()
        
        scrollDirection = .horizontal
        minimumLineSpacing = 40
        itemSize = CGSize(width: 150, height: 150)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepare() {
        guard let collectionView = collectionView else { fatalError() }
        let verticalInsets = (collectionView.frame.height - collectionView.adjustedContentInset.top - collectionView.adjustedContentInset.bottom - itemSize.height) / 2
        let horizontalInsets = (collectionView.frame.width - collectionView.adjustedContentInset.right - collectionView.adjustedContentInset.left - itemSize.width) / 2
        sectionInset = UIEdgeInsets(top: verticalInsets, left: horizontalInsets, bottom: verticalInsets, right: horizontalInsets)
        super.prepare()
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let collectionView = collectionView else { return nil }
        let rectAttributes = super.layoutAttributesForElements(in: rect)!.map { $0.copy() as! UICollectionViewLayoutAttributes }
        let visibleRect = CGRect(origin: collectionView.contentOffset, size: collectionView.frame.size)
        
        // Make the cells be zoomed when they reach the center of the screen
        for attributes in rectAttributes where attributes.frame.intersects(visibleRect) {
            let distance = visibleRect.midX - attributes.center.x
            let normalizedDistance = distance / activeDistance
            
            if distance.magnitude < activeDistance {
                let zoom = 1 + zoomFactor * (1 - normalizedDistance.magnitude)
                attributes.transform3D = CATransform3DMakeScale(zoom, zoom, 1)
                attributes.zIndex = Int(zoom.rounded())
            }
        }
        
        return rectAttributes
    }
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        guard let collectionView = collectionView else { return .zero }
        
        // Add some snapping behaviour so that the zoomed cell is always centered
        let targetRect = CGRect(x: proposedContentOffset.x, y: 0, width: collectionView.frame.width, height: collectionView.frame.height)
        guard let rectAttributes = super.layoutAttributesForElements(in: targetRect) else { return .zero }
        
        var offsetAdjustment = CGFloat.greatestFiniteMagnitude
        let horizontalCenter = proposedContentOffset.x + collectionView.frame.width / 2
        
        for layoutAttributes in rectAttributes {
            let itemHorizontalCenter = layoutAttributes.center.x
            if (itemHorizontalCenter - horizontalCenter).magnitude < offsetAdjustment.magnitude {
                offsetAdjustment = itemHorizontalCenter - horizontalCenter
            }
        }
        
        return CGPoint(x: proposedContentOffset.x + offsetAdjustment, y: proposedContentOffset.y)
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        // Invalidate layout so that every cell get a chance to be zoomed when it reaches the center of the screen
        return true
    }
    
    override func invalidationContext(forBoundsChange newBounds: CGRect) -> UICollectionViewLayoutInvalidationContext {
        let context = super.invalidationContext(forBoundsChange: newBounds) as! UICollectionViewFlowLayoutInvalidationContext
        context.invalidateFlowLayoutDelegateMetrics = newBounds.size != collectionView?.bounds.size
        return context
    }
    
}

class BUChooseRoleViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var isfirstTimeTransform: Bool = true
    
    fileprivate enum CellModel {
        case client
        case barber
    }
    
    let flowLayout = ZoomAndSnapFlowLayout()
    private let model: [CellModel] = [.client, .barber]
    
    var selectedRole: UserRole = .Customer
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Decorator.decorate(self)
        delegating()
        registerCells()
        addRightBarButton()
        setupBackBarItem()
        chooseBarberInteratcor.shared.fetchBarbers()
    }
    
    private func delegating() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.collectionViewLayout = flowLayout
        collectionView.contentInsetAdjustmentBehavior = .always
    }
    
    private func registerCells() {
        collectionView.register(RoleCollectionViewCell.nib, forCellWithReuseIdentifier: RoleCollectionViewCell.name)
        collectionView.register(BarberCVCell.nib, forCellWithReuseIdentifier: BarberCVCell.name)
    }
    
    @objc private func handleCreateUser() {
        switch self.selectedRole {
        case .Barber:
            ChooseRoleRouter.shared.handleCreateBarberVC(from: self)
        case .Customer:
            ChooseRoleRouter.shared.handleCreateCustomerVC(from: self)
        case .None:
            break
        }
    }
    
    private func addRightBarButton() {
        let rightBarBarButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(handleCreateUser))
        rightBarBarButton.tintColor = burbColor
        navigationItem.rightBarButtonItem = rightBarBarButton
    }
    
    @objc private func goBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func setupBackBarItem() {
        var barButton = UIBarButtonItem(customView: UIImageView(image: UIImage(named: "icBack")))
        barButton = UIBarButtonItem(image: UIImage(named: "icBack"), style: .plain, target: self, action: #selector(goBack))
        barButton.tintColor = .clear
        barButton.isEnabled = false
        navigationItem.leftBarButtonItem = barButton
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let models = model[indexPath.row]
        switch models {
        case .client:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RoleCollectionViewCell.name, for: indexPath) as? RoleCollectionViewCell {
                cell.setTitle(text: "_Client")
                cell.setDescription(text: "_Iwouldliketolooksharp")
                cell.clientView.addDeselectAnimation()
                cell.clientView.addSelectAnimation()
                
                return cell
            }
        case .barber:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BarberCVCell.name, for: indexPath) as? BarberCVCell {
                cell.setTitle(text: "_Barber")
                cell.setDescription(text: "_Icanmakeyoulookrealcool")
                cell.barberView.addDeselectAnimation()
                return cell
            }
        }
        return UICollectionViewCell.init()
    }
    
    func centerCell () {
        let centerPoint = CGPoint(x: collectionView.contentOffset.x + collectionView.frame.midX, y: 100)
        if let path = collectionView.indexPathForItem(at: centerPoint) {
            collectionView.scrollToItem(at: path, at: .centeredHorizontally, animated: true)
        }
    }
    
    
    // MARK: - for switching cells
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        
        let centerPoint = CGPoint(x: self.collectionView.center.x, y: self.collectionView.center.y)
        
        
        let collectionViewCenterPoint = self.view.convert(centerPoint, to: collectionView)
        
        let indexPath = collectionView.indexPathForItem(at: collectionViewCenterPoint)
        
        
        let models = model[indexPath!.item]
        
        switch models {
            
        case .client:
            if let clientCell: RoleCollectionViewCell = collectionView.cellForItem(at: indexPath!) as? RoleCollectionViewCell {
                clientCell.clientView.addSelectAnimation()
                self.selectedRole = .Customer
                print(self.selectedRole.rawValue)
            } else {
                return
            }
            if let barberCell: BarberCVCell = collectionView.cellForItem(at: indexPath!) as? BarberCVCell {
                barberCell.barberView.addDeselectAnimation()
            } else {
                return
            }
        case .barber:
            if let barberCell: BarberCVCell = collectionView.cellForItem(at: indexPath!) as? BarberCVCell {
                barberCell.barberView.addSelectAnimation()
                selectedRole = .Barber
                print(self.selectedRole.rawValue)
            } else {
                return
            }
            if let clientCell: RoleCollectionViewCell = collectionView.cellForItem(at: indexPath!) as? RoleCollectionViewCell {
                clientCell.clientView.addDeselectAnimation()
            } else {
                return
            }
        }
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collectionView.frame.size.width - self.collectionView.frame.size.width / 2.5, height: self.collectionView.frame.size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets (top: 0, left: 100, bottom: 0, right: 100)
    }
    
}

extension BUChooseRoleViewController {
    fileprivate class Decorator {
        private init() {}
        static func decorate(_ vc: BUChooseRoleViewController) {
            vc.collectionView.bounces = false
            vc.navigationController?.navigationBar.barTintColor = UIColor.white
            vc.navigationController?.navigationBar.shadowImage = UIImage()
            vc.title = "_CHOOSEYOURROLE"
        }
    }
}

