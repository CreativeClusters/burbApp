//
//  extension+UIView.swift
//  Burb
//
//  Created by Eugene on 26.03.2020.
//  Copyright © 2020 CC_Eugene. All rights reserved.
//

import UIKit

extension UIView {

    func dropShadow() {

        var shadowLayer: CAShapeLayer!
        let cornerRadius: CGFloat = 16.0
        let fillColor: UIColor = .white

        if shadowLayer == nil {
            shadowLayer = CAShapeLayer()

            shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
            shadowLayer.fillColor = fillColor.cgColor

            shadowLayer.shadowColor = UIColor.black.cgColor
            shadowLayer.shadowPath = shadowLayer.path
            shadowLayer.shadowOffset = CGSize(width: -2.0, height: 2.0)
            shadowLayer.shadowOpacity = 0.8
            shadowLayer.shadowRadius = 2

            layer.insertSublayer(shadowLayer, at: 0)
        }
    }
}

extension UIView
{
    var width: CGFloat!
    {
        return self.frame.size.width
    }
    
    var height: CGFloat!
    {
        return self.frame.size.height
    }
    
    var halfWidth: CGFloat!
    {
        return self.frame.size.width / 2
    }
    
    var halfHeight: CGFloat!
    {
        return self.frame.size.height / 2
    }
    
    var maxX: CGFloat!
    {
        return self.frame.maxX
    }
    
    var maxY: CGFloat!
    {
        return self.frame.maxY
    }
    
    func findSuperViewOfType<T>(_ type: T.Type) -> T?
    {
        var superView = self
        while self.superview != nil
        {
            superView = superView.superview!
            if superView is T
            {
                return superView as? T
            }
        }
        return nil
    }
    
    func screenshot() -> UIImage
    {
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, 0)
        layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!;
    }
    
    func addParallax(_ relativeValue: CGFloat)
    {
        let horizontal = UIInterpolatingMotionEffect(keyPath: "center.x", type: .tiltAlongHorizontalAxis)
        horizontal.minimumRelativeValue = -relativeValue
        horizontal.maximumRelativeValue = relativeValue
        
        let vertical = UIInterpolatingMotionEffect(keyPath: "center.y", type: .tiltAlongVerticalAxis)
        vertical.minimumRelativeValue = -relativeValue
        vertical.maximumRelativeValue = relativeValue
        
        let group = UIMotionEffectGroup()
        group.motionEffects = [horizontal, vertical]
        self.addMotionEffect(group)
    }
    
    var parentViewController: UIViewController?
    {
        var parentResponder: UIResponder? = self
        while parentResponder != nil
        {
            parentResponder = parentResponder!.next
            if let viewController = parentResponder as? UIViewController
            {
                return viewController
            }
        }
        return nil
    }
}

extension UIView
{
    private static let indicatorTag = 987
    
    func addActivityIndicator(withStyle style: UIActivityIndicatorView.Style = .gray, backgroundColor color: UIColor = .white) -> UIActivityIndicatorView
    {
        let indicator = UIActivityIndicatorView(style: style)
        indicator.tag = UIView.indicatorTag
        indicator.backgroundColor = color
        indicator.contentMode = .center
        self.addSubview(indicator)
        indicator.fillSuperView()
        indicator.addWidthConstraint(toView: self)
        indicator.addHeightConstraint(toView: self)
        return indicator
    }
    
    func launchActivityIndicator(withStyle style: UIActivityIndicatorView.Style = .gray, backgroundColor color: UIColor = .white)
    {
        let indicator = addActivityIndicator(withStyle: style, backgroundColor: color)
        indicator.startAnimating()
    }
    
    func stopActivityIndicator()
    {
        viewWithTag(UIView.indicatorTag)?.removeFromSuperview()
    }
}

extension UIView
{
    @discardableResult
    public func attachToSuperViewSideWithConstraint(top: CGFloat? = nil, left: CGFloat? = nil, bottom: CGFloat? = nil, right: CGFloat? = nil) -> [NSLayoutConstraint]
    {
        var constraints: [NSLayoutConstraint] = []
        
        if let superview = superview
        {
            if top != nil
            {
                constraints.append(addTopConstraint(toView: superview, constant: top!))
            }
            if left != nil
            {
                constraints.append(addLeadingConstraint(toView: superview, constant: left!))
            }
            if bottom != nil
            {
                constraints.append(addBottomConstraint(toView: superview, constant: -bottom!))
            }
            if right != nil
            {
                constraints.append(addTrailingConstraint(toView: superview, constant: -right!))
            }
        }
        return constraints
    }

    @discardableResult
    public func fillSuperView(_ edges: UIEdgeInsets = UIEdgeInsets.zero) -> [NSLayoutConstraint] {
        
        var constraints: [NSLayoutConstraint] = []
        
        if let superview = superview {
            
            let topConstraint = addTopConstraint(toView: superview, constant: edges.top)
            let leadingConstraint = addLeadingConstraint(toView: superview, constant: edges.left)
            let bottomConstraint = addBottomConstraint(toView: superview, constant: -edges.bottom)
            let trailingConstraint = addTrailingConstraint(toView: superview, constant: -edges.right)
            
            constraints = [topConstraint, leadingConstraint, bottomConstraint, trailingConstraint]
        }
        
        return constraints
    }
    
    @discardableResult
    public func addLeadingConstraint(toView view: UIView?, attribute: NSLayoutConstraint.Attribute = .leading, relation: NSLayoutConstraint.Relation = .equal, constant: CGFloat = 0.0) -> NSLayoutConstraint {
        
        let constraint = createConstraint(attribute: .leading, toView: view, attribute: attribute, relation: relation, constant: constant)
        addConstraintToSuperview(constraint)
        
        return constraint
    }
    
    @discardableResult
    public func addTrailingConstraint(toView view: UIView?, attribute: NSLayoutConstraint.Attribute = .trailing, relation: NSLayoutConstraint.Relation = .equal, constant: CGFloat = 0.0) -> NSLayoutConstraint {
        
        let constraint = createConstraint(attribute: .trailing, toView: view, attribute: attribute, relation: relation, constant: constant)
        addConstraintToSuperview(constraint)
        
        return constraint
    }
    
    @discardableResult
    public func addLeftConstraint(toView view: UIView?, attribute: NSLayoutConstraint.Attribute = .left, relation: NSLayoutConstraint.Relation = .equal, constant: CGFloat = 0.0) -> NSLayoutConstraint {
        
        let constraint = createConstraint(attribute: .left, toView: view, attribute: attribute, relation: relation, constant: constant)
        addConstraintToSuperview(constraint)
        
        return constraint
    }
    
    @discardableResult
    public func addRightConstraint(toView view: UIView?, attribute: NSLayoutConstraint.Attribute = .right, relation: NSLayoutConstraint.Relation = .equal, constant: CGFloat = 0.0) -> NSLayoutConstraint {
        
        let constraint = createConstraint(attribute: .right, toView: view, attribute: attribute, relation: relation, constant: constant)
        addConstraintToSuperview(constraint)
        
        return constraint
    }
    
    @discardableResult
    public func addTopConstraint(toView view: UIView?, attribute: NSLayoutConstraint.Attribute = .top, relation: NSLayoutConstraint.Relation = .equal, constant: CGFloat = 0.0) -> NSLayoutConstraint {
        
        let constraint = createConstraint(attribute: .top, toView: view, attribute: attribute, relation: relation, constant: constant)
        addConstraintToSuperview(constraint)
        
        return constraint
    }
    
    @discardableResult
    public func addBottomConstraint(toView view: UIView?, attribute: NSLayoutConstraint.Attribute = .bottom, relation: NSLayoutConstraint.Relation = .equal, constant: CGFloat = 0.0) -> NSLayoutConstraint {
        
        let constraint = createConstraint(attribute: .bottom, toView: view, attribute: attribute, relation: relation, constant: constant)
        addConstraintToSuperview(constraint)
        
        return constraint
    }
    
    @discardableResult
    public func addCenterXConstraint(toView view: UIView?, relation: NSLayoutConstraint.Relation = .equal, constant: CGFloat = 0.0) -> NSLayoutConstraint {
        
        let constraint = createConstraint(attribute: .centerX, toView: view, attribute: .centerX, relation: relation, constant: constant)
        addConstraintToSuperview(constraint)
        
        return constraint
    }
    
    @discardableResult
    public func addCenterYConstraint(toView view: UIView?, relation: NSLayoutConstraint.Relation = .equal, constant: CGFloat = 0.0) -> NSLayoutConstraint {
        
        let constraint = createConstraint(attribute: .centerY, toView: view, attribute: .centerY, relation: relation, constant: constant)
        addConstraintToSuperview(constraint)
        
        return constraint
    }
    
    @discardableResult
    public func addWidthConstraint(toView view: UIView?, relation: NSLayoutConstraint.Relation = .equal, constant: CGFloat = 0.0) -> NSLayoutConstraint {
        
        let constraint = createConstraint(attribute: .width, toView: view, attribute: .width, relation: relation, constant: constant)
        addConstraintToSuperview(constraint)
        
        return constraint
    }
    
    @discardableResult
    public func addHeightConstraint(toView view: UIView?, relation: NSLayoutConstraint.Relation = .equal, constant: CGFloat = 0.0) -> NSLayoutConstraint {
        
        let constraint = createConstraint(attribute: .height, toView: view, attribute: .height, relation: relation, constant: constant)
        addConstraintToSuperview(constraint)
        
        return constraint
    }
    
    
    @discardableResult
    public func addLeftHorizontalConstraint(toView view: UIView?, relation: NSLayoutConstraint.Relation = .equal, constant: CGFloat = 0.0) -> NSLayoutConstraint {
        
        let constraint = createConstraint(attribute: .left, toView: view, attribute: .right, relation: .equal, constant: constant)
        NSLayoutConstraint.activate([constraint])
        return constraint
    }

    @discardableResult
    public func addRightHorizontalConstraint(toView view: UIView?, relation: NSLayoutConstraint.Relation = .equal, constant: CGFloat = 0.0) -> NSLayoutConstraint {
        
        let constraint = createConstraint(attribute: .right, toView: view, attribute: .left, relation: .equal, constant: constant)
        NSLayoutConstraint.activate([constraint])
        return constraint
    }

    @discardableResult
    public func addTopVerticalConstraint(toView view: UIView?, relation: NSLayoutConstraint.Relation = .equal, constant: CGFloat = 0.0) -> NSLayoutConstraint {
        
        let constraint = createConstraint(attribute: .top, toView: view, attribute: .bottom, relation: .equal, constant: constant)
        NSLayoutConstraint.activate([constraint])
        return constraint
    }

    @discardableResult
    public func addBottomVerticalConstraint(toView view: UIView?, relation: NSLayoutConstraint.Relation = .equal, constant: CGFloat = 0.0) -> NSLayoutConstraint {
        
        let constraint = createConstraint(attribute: .bottom, toView: view, attribute: .top, relation: .equal, constant: constant)
        NSLayoutConstraint.activate([constraint])
        return constraint
    }
    
    // MARK: - Private
    /// Adds an NSLayoutConstraint to the superview
    fileprivate func addConstraintToSuperview(_ constraint: NSLayoutConstraint) {
        
        translatesAutoresizingMaskIntoConstraints = false
        superview?.addConstraint(constraint)
    }
    
    fileprivate func createConstraint(attribute attr1: NSLayoutConstraint.Attribute, toView: UIView?, attribute attr2: NSLayoutConstraint.Attribute, relation: NSLayoutConstraint.Relation, constant: CGFloat) -> NSLayoutConstraint {
        
        let constraint = NSLayoutConstraint(
            item: self,
            attribute: attr1,
            relatedBy: relation,
            toItem: toView,
            attribute: attr2,
            multiplier: 1.0,
            constant: constant)
        
        return constraint
    }
}
