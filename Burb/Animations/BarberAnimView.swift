//
//  BarberAnimView.swift
//  Burb
//
//  Created by Pavel Bukharov on 24.07.2018.
//  Copyright © 2018 Pavel Bukharov. All rights reserved.
//

import UIKit

@IBDesignable
class BarberAnimView: UIView, CAAnimationDelegate {
    
    var isSelected = false {
        didSet {
            if oldValue != isSelected {
                if isSelected {
                    addSelectAnimation()
                } else {
                    addDeselectAnimation()
                }
            }
        }
    }
    
    var layers = [String: CALayer]()
    var completionBlocks = [CAAnimation: (Bool) -> Void]()
    var updateLayerValueForCompletedAnimation : Bool = false
    
    var purple : UIColor!
    var red : UIColor!
    var white : UIColor!
    var gray : UIColor!
    var darkGray : UIColor!
    var extraDarkGray : UIColor!
    
    //MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupProperties()
        setupLayers()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        setupProperties()
        setupLayers()
    }
    
    override var frame: CGRect{
        didSet{
            setupLayerFrames()
        }
    }
    
    override var bounds: CGRect{
        didSet{
            setupLayerFrames()
        }
    }
    
    func setupProperties(){
        self.purple = UIColor(red:0.316, green: 0.266, blue:0.371, alpha:1)
        self.red = UIColor(red:0.848, green: 0.43, blue:0.415, alpha:1)
        self.white = UIColor(red:1.00, green: 1.00, blue:1.00, alpha:1.0)
        self.gray = UIColor(red:0.921, green: 0.921, blue:0.921, alpha:1)
        self.darkGray = UIColor(red:0.754, green: 0.754, blue:0.754, alpha:1)
        self.extraDarkGray = UIColor(red:0.574, green: 0.574, blue:0.574, alpha:1)
    }
    
    func setupLayers(){
        self.backgroundColor = UIColor(red:1.00, green: 1.00, blue:1.00, alpha:0.0)
        
        let barber = CALayer()
        self.layer.addSublayer(barber)
        layers["barber"] = barber
        let barber_a = CALayer()
        barber.addSublayer(barber_a)
        layers["barber_a"] = barber_a
        let path = CAShapeLayer()
        barber_a.addSublayer(path)
        layers["path"] = path
        let Ellipse_2_копия_ = CAShapeLayer()
        barber_a.addSublayer(Ellipse_2_копия_)
        layers["Ellipse_2_копия_"] = Ellipse_2_копия_
        let Ellipse_2_копия_2 = CAShapeLayer()
        barber_a.addSublayer(Ellipse_2_копия_2)
        layers["Ellipse_2_копия_2"] = Ellipse_2_копия_2
        let Ellipse_2_копия_3 = CAShapeLayer()
        barber_a.addSublayer(Ellipse_2_копия_3)
        layers["Ellipse_2_копия_3"] = Ellipse_2_копия_3
        let leftEye = CAShapeLayer()
        barber_a.addSublayer(leftEye)
        layers["leftEye"] = leftEye
        let rightEye = CAShapeLayer()
        barber_a.addSublayer(rightEye)
        layers["rightEye"] = rightEye
        let Ellipse_2_копия_4 = CAShapeLayer()
        barber_a.addSublayer(Ellipse_2_копия_4)
        layers["Ellipse_2_копия_4"] = Ellipse_2_копия_4
        let Ellipse_2_копия_5 = CAShapeLayer()
        barber_a.addSublayer(Ellipse_2_копия_5)
        layers["Ellipse_2_копия_5"] = Ellipse_2_копия_5
        let CombinedShape = CAShapeLayer()
        barber_a.addSublayer(CombinedShape)
        layers["CombinedShape"] = CombinedShape
        
        resetLayerProperties(forLayerIdentifiers: nil)
        setupLayerFrames()
    }
    
    func resetLayerProperties(forLayerIdentifiers layerIds: [String]!){
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        
        if layerIds == nil || layerIds.contains("path"){
            let path = layers["path"] as! CAShapeLayer
            path.fillColor   = nil
            path.strokeColor = UIColor(red:0.848, green: 0.43, blue:0.415, alpha:1).cgColor
            path.lineWidth   = 2
        }
        if layerIds == nil || layerIds.contains("Ellipse_2_копия_"){
            let Ellipse_2_копия_ = layers["Ellipse_2_копия_"] as! CAShapeLayer
            Ellipse_2_копия_.fillColor   = self.gray.cgColor
            Ellipse_2_копия_.strokeColor = UIColor.black.cgColor
            Ellipse_2_копия_.lineWidth   = 0
        }
        if layerIds == nil || layerIds.contains("Ellipse_2_копия_2"){
            let Ellipse_2_копия_2 = layers["Ellipse_2_копия_2"] as! CAShapeLayer
            Ellipse_2_копия_2.fillColor   = self.white.cgColor
            Ellipse_2_копия_2.strokeColor = UIColor.black.cgColor
            Ellipse_2_копия_2.lineWidth   = 0
        }
        if layerIds == nil || layerIds.contains("Ellipse_2_копия_3"){
            let Ellipse_2_копия_3 = layers["Ellipse_2_копия_3"] as! CAShapeLayer
            Ellipse_2_копия_3.fillColor   = UIColor(red:0.316, green: 0.266, blue:0.371, alpha:1).cgColor
            Ellipse_2_копия_3.strokeColor = UIColor.black.cgColor
            Ellipse_2_копия_3.lineWidth   = 0
        }
        if layerIds == nil || layerIds.contains("leftEye"){
            let leftEye = layers["leftEye"] as! CAShapeLayer
            leftEye.fillColor   = self.purple.cgColor
            leftEye.strokeColor = UIColor.black.cgColor
            leftEye.lineWidth   = 0
        }
        if layerIds == nil || layerIds.contains("rightEye"){
            let rightEye = layers["rightEye"] as! CAShapeLayer
            rightEye.fillColor   = UIColor(red:0.316, green: 0.266, blue:0.371, alpha:1).cgColor
            rightEye.strokeColor = UIColor.black.cgColor
            rightEye.lineWidth   = 0
        }
        if layerIds == nil || layerIds.contains("Ellipse_2_копия_4"){
            let Ellipse_2_копия_4 = layers["Ellipse_2_копия_4"] as! CAShapeLayer
            Ellipse_2_копия_4.fillColor   = UIColor(red:0.848, green: 0.43, blue:0.415, alpha:1).cgColor
            Ellipse_2_копия_4.strokeColor = UIColor.black.cgColor
            Ellipse_2_копия_4.lineWidth   = 0
        }
        if layerIds == nil || layerIds.contains("Ellipse_2_копия_5"){
            let Ellipse_2_копия_5 = layers["Ellipse_2_копия_5"] as! CAShapeLayer
            Ellipse_2_копия_5.fillColor   = self.red.cgColor
            Ellipse_2_копия_5.strokeColor = UIColor.black.cgColor
            Ellipse_2_копия_5.lineWidth   = 0
        }
        if layerIds == nil || layerIds.contains("CombinedShape"){
            let CombinedShape = layers["CombinedShape"] as! CAShapeLayer
            CombinedShape.fillColor   = UIColor(red:0.848, green: 0.43, blue:0.415, alpha:1).cgColor
            CombinedShape.strokeColor = UIColor.black.cgColor
            CombinedShape.lineWidth   = 0
        }
        
        CATransaction.commit()
    }
    
    func setupLayerFrames(){
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        
        if let barber = layers["barber"]{
            barber.frame = CGRect(x: 0, y: 0, width:  barber.superlayer!.bounds.width, height:  barber.superlayer!.bounds.height)
        }
        
        if let barber_a = layers["barber_a"]{
            barber_a.frame = CGRect(x: 0, y: 0, width:  barber_a.superlayer!.bounds.width, height:  barber_a.superlayer!.bounds.height)
        }
        
        if let path = layers["path"] as? CAShapeLayer{
            path.frame = CGRect(x: 0, y: 0, width:  path.superlayer!.bounds.width, height:  path.superlayer!.bounds.height)
            path.path  = pathPath(bounds: layers["path"]!.bounds).cgPath
        }
        
        if let Ellipse_2_копия_ = layers["Ellipse_2_копия_"] as? CAShapeLayer{
            Ellipse_2_копия_.frame = CGRect(x: 0.03125 * Ellipse_2_копия_.superlayer!.bounds.width, y: 0.03086 * Ellipse_2_копия_.superlayer!.bounds.height, width: 0.9375 * Ellipse_2_копия_.superlayer!.bounds.width, height: 0.9375 * Ellipse_2_копия_.superlayer!.bounds.height)
            Ellipse_2_копия_.path  = Ellipse_2_копия_Path(bounds: layers["Ellipse_2_копия_"]!.bounds).cgPath
        }
        
        if let Ellipse_2_копия_2 = layers["Ellipse_2_копия_2"] as? CAShapeLayer{
            Ellipse_2_копия_2.frame = CGRect(x: 0.1445 * Ellipse_2_копия_2.superlayer!.bounds.width, y: 0.04566 * Ellipse_2_копия_2.superlayer!.bounds.height, width: 0.71491 * Ellipse_2_копия_2.superlayer!.bounds.width, height: 0.92562 * Ellipse_2_копия_2.superlayer!.bounds.height)
            Ellipse_2_копия_2.path  = Ellipse_2_копия_2Path(bounds: layers["Ellipse_2_копия_2"]!.bounds).cgPath
        }
        
        if let Ellipse_2_копия_3 = layers["Ellipse_2_копия_3"] as? CAShapeLayer{
            Ellipse_2_копия_3.frame = CGRect(x: 0.228 * Ellipse_2_копия_3.superlayer!.bounds.width, y: 0.03416 * Ellipse_2_копия_3.superlayer!.bounds.height, width: 0.54644 * Ellipse_2_копия_3.superlayer!.bounds.width, height: 0.21478 * Ellipse_2_копия_3.superlayer!.bounds.height)
            Ellipse_2_копия_3.path  = Ellipse_2_копия_3Path(bounds: layers["Ellipse_2_копия_3"]!.bounds).cgPath
        }
        
        if let leftEye = layers["leftEye"] as? CAShapeLayer{
            leftEye.frame = CGRect(x: 0.22266 * leftEye.superlayer!.bounds.width, y: 0.37852 * leftEye.superlayer!.bounds.height, width: 0.14453 * leftEye.superlayer!.bounds.width, height: 0.14453 * leftEye.superlayer!.bounds.height)
            leftEye.path  = leftEyePath(bounds: layers["leftEye"]!.bounds).cgPath
        }
        
        if let rightEye = layers["rightEye"] as? CAShapeLayer{
            rightEye.frame = CGRect(x: 0.625 * rightEye.superlayer!.bounds.width, y: 0.37852 * rightEye.superlayer!.bounds.height, width: 0.14453 * rightEye.superlayer!.bounds.width, height: 0.14453 * rightEye.superlayer!.bounds.height)
            rightEye.path  = rightEyePath(bounds: layers["rightEye"]!.bounds).cgPath
        }
        
        if let Ellipse_2_копия_4 = layers["Ellipse_2_копия_4"] as? CAShapeLayer{
            Ellipse_2_копия_4.frame = CGRect(x: 0.30469 * Ellipse_2_копия_4.superlayer!.bounds.width, y: 0.31222 * Ellipse_2_копия_4.superlayer!.bounds.height, width: 0.04297 * Ellipse_2_копия_4.superlayer!.bounds.width, height: 0.04297 * Ellipse_2_копия_4.superlayer!.bounds.height)
            Ellipse_2_копия_4.path  = Ellipse_2_копия_4Path(bounds: layers["Ellipse_2_копия_4"]!.bounds).cgPath
        }
        
        if let Ellipse_2_копия_5 = layers["Ellipse_2_копия_5"] as? CAShapeLayer{
            Ellipse_2_копия_5.frame = CGRect(x: 0.64844 * Ellipse_2_копия_5.superlayer!.bounds.width, y: 0.31222 * Ellipse_2_копия_5.superlayer!.bounds.height, width: 0.04297 * Ellipse_2_копия_5.superlayer!.bounds.width, height: 0.04297 * Ellipse_2_копия_5.superlayer!.bounds.height)
            Ellipse_2_копия_5.path  = Ellipse_2_копия_5Path(bounds: layers["Ellipse_2_копия_5"]!.bounds).cgPath
        }
        
        if let CombinedShape = layers["CombinedShape"] as? CAShapeLayer{
            CombinedShape.frame = CGRect(x: 0.42187 * CombinedShape.superlayer!.bounds.width, y: 0.67514 * CombinedShape.superlayer!.bounds.height, width: 0.17351 * CombinedShape.superlayer!.bounds.width, height: 0.1134 * CombinedShape.superlayer!.bounds.height)
            CombinedShape.path  = CombinedShapePath(bounds: layers["CombinedShape"]!.bounds).cgPath
        }
        
        CATransaction.commit()
    }
    
    //MARK: - Animation Setup
    
    func addSelectAnimation(completionBlock: ((_ finished: Bool) -> Void)? = nil){
        if completionBlock != nil{
            let completionAnim = CABasicAnimation(keyPath:"completionAnim")
            completionAnim.duration = 0.622
            completionAnim.delegate = self
            completionAnim.setValue("select", forKey:"animId")
            completionAnim.setValue(false, forKey:"needEndAnim")
            layer.add(completionAnim, forKey:"select")
            if let anim = layer.animation(forKey: "select"){
                completionBlocks[anim] = completionBlock
            }
        }
        
        let fillMode : String = CAMediaTimingFillMode.forwards.rawValue
        
        let barber_a = layers["barber_a"]!
        
        ////Barber_a animation
        let barber_aTransformAnim      = CAKeyframeAnimation(keyPath:"transform")
        barber_aTransformAnim.values   = [NSValue(caTransform3D: CATransform3DMakeScale(0.9, 0.9, 1)),
                                          NSValue(caTransform3D: CATransform3DIdentity)]
        barber_aTransformAnim.keyTimes = [0, 1]
        barber_aTransformAnim.duration = 0.4
        
        let barber_aSelectAnim : CAAnimationGroup = QCMethod.group(animations: [barber_aTransformAnim], fillMode:fillMode)
        barber_a.add(barber_aSelectAnim, forKey:"barber_aSelectAnim")
        
        ////Path animation
        let pathStrokeStartAnim            = CAKeyframeAnimation(keyPath:"strokeStart")
        pathStrokeStartAnim.values         = [1, 0]
        pathStrokeStartAnim.keyTimes       = [0, 1]
        pathStrokeStartAnim.duration       = 0.4
        pathStrokeStartAnim.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeIn)
        
        let pathStrokeColorAnim      = CAKeyframeAnimation(keyPath:"strokeColor")
        pathStrokeColorAnim.values   = [self.gray.cgColor,
                                        UIColor(red:0.848, green: 0.43, blue:0.415, alpha:1).cgColor]
        pathStrokeColorAnim.keyTimes = [0, 1]
        pathStrokeColorAnim.duration = 0.4
        
        let pathSelectAnim : CAAnimationGroup = QCMethod.group(animations: [pathStrokeStartAnim, pathStrokeColorAnim], fillMode:fillMode)
        layers["path"]?.add(pathSelectAnim, forKey:"pathSelectAnim")
        
        ////Ellipse_2_копия_ animation
        let Ellipse_2_копия_FillColorAnim      = CAKeyframeAnimation(keyPath:"fillColor")
        Ellipse_2_копия_FillColorAnim.values   = [self.gray.cgColor,
                                                       self.purple.cgColor]
        Ellipse_2_копия_FillColorAnim.keyTimes = [0, 1]
        Ellipse_2_копия_FillColorAnim.duration = 0.4
        
        let Ellipse_2_копия_SelectAnim : CAAnimationGroup = QCMethod.group(animations: [Ellipse_2_копия_FillColorAnim], fillMode:fillMode)
        layers["Ellipse_2_копия_"]?.add(Ellipse_2_копия_SelectAnim, forKey:"Ellipse_2_копия_SelectAnim")
        
        ////Ellipse_2_копия_3 animation
        let Ellipse_2_копия_3FillColorAnim    = CAKeyframeAnimation(keyPath:"fillColor")
        Ellipse_2_копия_3FillColorAnim.values = [self.gray.cgColor,
                                                      UIColor(red:0.316, green: 0.266, blue:0.371, alpha:1).cgColor]
        Ellipse_2_копия_3FillColorAnim.keyTimes = [0, 1]
        Ellipse_2_копия_3FillColorAnim.duration = 0.4
        
        let Ellipse_2_копия_3SelectAnim : CAAnimationGroup = QCMethod.group(animations: [Ellipse_2_копия_3FillColorAnim], fillMode:fillMode)
        layers["Ellipse_2_копия_3"]?.add(Ellipse_2_копия_3SelectAnim, forKey:"Ellipse_2_копия_3SelectAnim")
        
        ////LeftEye animation
        let leftEyeFillColorAnim      = CAKeyframeAnimation(keyPath:"fillColor")
        leftEyeFillColorAnim.values   = [self.darkGray.cgColor,
                                         UIColor(red:0.316, green: 0.266, blue:0.371, alpha:1).cgColor]
        leftEyeFillColorAnim.keyTimes = [0, 1]
        leftEyeFillColorAnim.duration = 0.4
        
        let leftEye = layers["leftEye"] as! CAShapeLayer
        
        let leftEyeTransformAnim      = CAKeyframeAnimation(keyPath:"transform.rotation.z")
        leftEyeTransformAnim.values   = [0,
                                         30 * CGFloat.pi/180,
                                         0]
        leftEyeTransformAnim.keyTimes = [0, 0.513, 1]
        leftEyeTransformAnim.duration = 0.622
        
        let leftEyeSelectAnim : CAAnimationGroup = QCMethod.group(animations: [leftEyeFillColorAnim, leftEyeTransformAnim], fillMode:fillMode)
        leftEye.add(leftEyeSelectAnim, forKey:"leftEyeSelectAnim")
        
        ////RightEye animation
        let rightEyeFillColorAnim      = CAKeyframeAnimation(keyPath:"fillColor")
        rightEyeFillColorAnim.values   = [self.darkGray.cgColor,
                                          UIColor(red:0.316, green: 0.266, blue:0.371, alpha:1).cgColor]
        rightEyeFillColorAnim.keyTimes = [0, 1]
        rightEyeFillColorAnim.duration = 0.5
        
        let rightEye = layers["rightEye"] as! CAShapeLayer
        
        let rightEyeTransformAnim      = CAKeyframeAnimation(keyPath:"transform.rotation.z")
        rightEyeTransformAnim.values   = [0,
                                          30 * CGFloat.pi/180,
                                          0]
        rightEyeTransformAnim.keyTimes = [0, 0.513, 1]
        rightEyeTransformAnim.duration = 0.622
        
        let rightEyeSelectAnim : CAAnimationGroup = QCMethod.group(animations: [rightEyeFillColorAnim, rightEyeTransformAnim], fillMode:fillMode)
        rightEye.add(rightEyeSelectAnim, forKey:"rightEyeSelectAnim")
        
        ////Ellipse_2_копия_4 animation
        let Ellipse_2_копия_4FillColorAnim    = CAKeyframeAnimation(keyPath:"fillColor")
        Ellipse_2_копия_4FillColorAnim.values = [self.extraDarkGray.cgColor,
                                                      UIColor(red:0.848, green: 0.43, blue:0.415, alpha:1).cgColor]
        Ellipse_2_копия_4FillColorAnim.keyTimes = [0, 1]
        Ellipse_2_копия_4FillColorAnim.duration = 0.5
        
        let Ellipse_2_копия_4SelectAnim : CAAnimationGroup = QCMethod.group(animations: [Ellipse_2_копия_4FillColorAnim], fillMode:fillMode)
        layers["Ellipse_2_копия_4"]?.add(Ellipse_2_копия_4SelectAnim, forKey:"Ellipse_2_копия_4SelectAnim")
        
        ////Ellipse_2_копия_5 animation
        let Ellipse_2_копия_5FillColorAnim    = CAKeyframeAnimation(keyPath:"fillColor")
        Ellipse_2_копия_5FillColorAnim.values = [self.extraDarkGray.cgColor,
                                                      UIColor(red:0.848, green: 0.43, blue:0.415, alpha:1).cgColor]
        Ellipse_2_копия_5FillColorAnim.keyTimes = [0, 1]
        Ellipse_2_копия_5FillColorAnim.duration = 0.5
        
        let Ellipse_2_копия_5SelectAnim : CAAnimationGroup = QCMethod.group(animations: [Ellipse_2_копия_5FillColorAnim], fillMode:fillMode)
        layers["Ellipse_2_копия_5"]?.add(Ellipse_2_копия_5SelectAnim, forKey:"Ellipse_2_копия_5SelectAnim")
        
        ////CombinedShape animation
        let CombinedShapeFillColorAnim      = CAKeyframeAnimation(keyPath:"fillColor")
        CombinedShapeFillColorAnim.values   = [self.extraDarkGray.cgColor,
                                               self.red.cgColor]
        CombinedShapeFillColorAnim.keyTimes = [0, 1]
        CombinedShapeFillColorAnim.duration = 0.5
        
        let CombinedShapeSelectAnim : CAAnimationGroup = QCMethod.group(animations: [CombinedShapeFillColorAnim], fillMode:fillMode)
        layers["CombinedShape"]?.add(CombinedShapeSelectAnim, forKey:"CombinedShapeSelectAnim")
    }
    
    func addDeselectAnimation(completionBlock: ((_ finished: Bool) -> Void)? = nil){
        if completionBlock != nil{
            let completionAnim = CABasicAnimation(keyPath:"completionAnim")
            completionAnim.duration = 0.3
            completionAnim.delegate = self
            completionAnim.setValue("deselect", forKey:"animId")
            completionAnim.setValue(false, forKey:"needEndAnim")
            layer.add(completionAnim, forKey:"deselect")
            if let anim = layer.animation(forKey: "deselect"){
                completionBlocks[anim] = completionBlock
            }
        }
        
        let fillMode : String = CAMediaTimingFillMode.forwards.rawValue
        
        let barber_a = layers["barber_a"]!
        
        ////Barber_a animation
        let barber_aTransformAnim      = CAKeyframeAnimation(keyPath:"transform")
        barber_aTransformAnim.values   = [NSValue(caTransform3D: CATransform3DIdentity),
                                          NSValue(caTransform3D: CATransform3DMakeScale(0.9, 0.9, 1))]
        barber_aTransformAnim.keyTimes = [0, 1]
        barber_aTransformAnim.duration = 0.3
        
        let barber_aDeselectAnim : CAAnimationGroup = QCMethod.group(animations: [barber_aTransformAnim], fillMode:fillMode)
        barber_a.add(barber_aDeselectAnim, forKey:"barber_aDeselectAnim")
        
        ////Path animation
        let pathStrokeStartAnim            = CAKeyframeAnimation(keyPath:"strokeStart")
        pathStrokeStartAnim.values         = [0, 1]
        pathStrokeStartAnim.keyTimes       = [0, 1]
        pathStrokeStartAnim.duration       = 0.3
        pathStrokeStartAnim.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeIn)
        
        let pathStrokeColorAnim      = CAKeyframeAnimation(keyPath:"strokeColor")
        pathStrokeColorAnim.values   = [UIColor(red:0.848, green: 0.43, blue:0.415, alpha:1).cgColor,
                                        self.extraDarkGray.cgColor]
        pathStrokeColorAnim.keyTimes = [0, 1]
        pathStrokeColorAnim.duration = 0.3
        
        let pathDeselectAnim : CAAnimationGroup = QCMethod.group(animations: [pathStrokeStartAnim, pathStrokeColorAnim], fillMode:fillMode)
        layers["path"]?.add(pathDeselectAnim, forKey:"pathDeselectAnim")
        
        ////Ellipse_2_копия_ animation
        let Ellipse_2_копия_FillColorAnim      = CAKeyframeAnimation(keyPath:"fillColor")
        Ellipse_2_копия_FillColorAnim.values   = [UIColor(red:0.316, green: 0.266, blue:0.371, alpha:1).cgColor,
                                                       self.gray.cgColor]
        Ellipse_2_копия_FillColorAnim.keyTimes = [0, 1]
        Ellipse_2_копия_FillColorAnim.duration = 0.3
        
        let Ellipse_2_копия_DeselectAnim : CAAnimationGroup = QCMethod.group(animations: [Ellipse_2_копия_FillColorAnim], fillMode:fillMode)
        layers["Ellipse_2_копия_"]?.add(Ellipse_2_копия_DeselectAnim, forKey:"Ellipse_2_копия_DeselectAnim")
        
        ////Ellipse_2_копия_3 animation
        let Ellipse_2_копия_3FillColorAnim    = CAKeyframeAnimation(keyPath:"fillColor")
        Ellipse_2_копия_3FillColorAnim.values = [UIColor(red:0.316, green: 0.266, blue:0.371, alpha:1).cgColor,
                                                      self.gray.cgColor]
        Ellipse_2_копия_3FillColorAnim.keyTimes = [0, 1]
        Ellipse_2_копия_3FillColorAnim.duration = 0.3
        
        let Ellipse_2_копия_3DeselectAnim : CAAnimationGroup = QCMethod.group(animations: [Ellipse_2_копия_3FillColorAnim], fillMode:fillMode)
        layers["Ellipse_2_копия_3"]?.add(Ellipse_2_копия_3DeselectAnim, forKey:"Ellipse_2_копия_3DeselectAnim")
        
        ////LeftEye animation
        let leftEyeFillColorAnim      = CAKeyframeAnimation(keyPath:"fillColor")
        leftEyeFillColorAnim.values   = [UIColor(red:0.316, green: 0.266, blue:0.371, alpha:1).cgColor,
                                         self.darkGray.cgColor]
        leftEyeFillColorAnim.keyTimes = [0, 1]
        leftEyeFillColorAnim.duration = 0.3
        
        let leftEyeDeselectAnim : CAAnimationGroup = QCMethod.group(animations: [leftEyeFillColorAnim], fillMode:fillMode)
        layers["leftEye"]?.add(leftEyeDeselectAnim, forKey:"leftEyeDeselectAnim")
        
        ////RightEye animation
        let rightEyeFillColorAnim      = CAKeyframeAnimation(keyPath:"fillColor")
        rightEyeFillColorAnim.values   = [UIColor(red:0.316, green: 0.266, blue:0.371, alpha:1).cgColor,
                                          self.darkGray.cgColor]
        rightEyeFillColorAnim.keyTimes = [0, 1]
        rightEyeFillColorAnim.duration = 0.3
        
        let rightEyeDeselectAnim : CAAnimationGroup = QCMethod.group(animations: [rightEyeFillColorAnim], fillMode:fillMode)
        layers["rightEye"]?.add(rightEyeDeselectAnim, forKey:"rightEyeDeselectAnim")
        
        ////Ellipse_2_копия_4 animation
        let Ellipse_2_копия_4FillColorAnim    = CAKeyframeAnimation(keyPath:"fillColor")
        Ellipse_2_копия_4FillColorAnim.values = [UIColor(red:0.848, green: 0.43, blue:0.415, alpha:1).cgColor,
                                                      self.extraDarkGray.cgColor]
        Ellipse_2_копия_4FillColorAnim.keyTimes = [0, 1]
        Ellipse_2_копия_4FillColorAnim.duration = 0.3
        
        let Ellipse_2_копия_4DeselectAnim : CAAnimationGroup = QCMethod.group(animations: [Ellipse_2_копия_4FillColorAnim], fillMode:fillMode)
        layers["Ellipse_2_копия_4"]?.add(Ellipse_2_копия_4DeselectAnim, forKey:"Ellipse_2_копия_4DeselectAnim")
        
        ////Ellipse_2_копия_5 animation
        let Ellipse_2_копия_5FillColorAnim    = CAKeyframeAnimation(keyPath:"fillColor")
        Ellipse_2_копия_5FillColorAnim.values = [UIColor(red:0.848, green: 0.43, blue:0.415, alpha:1).cgColor,
                                                      self.extraDarkGray.cgColor]
        Ellipse_2_копия_5FillColorAnim.keyTimes = [0, 1]
        Ellipse_2_копия_5FillColorAnim.duration = 0.3
        
        let Ellipse_2_копия_5DeselectAnim : CAAnimationGroup = QCMethod.group(animations: [Ellipse_2_копия_5FillColorAnim], fillMode:fillMode)
        layers["Ellipse_2_копия_5"]?.add(Ellipse_2_копия_5DeselectAnim, forKey:"Ellipse_2_копия_5DeselectAnim")
        
        ////CombinedShape animation
        let CombinedShapeFillColorAnim      = CAKeyframeAnimation(keyPath:"fillColor")
        CombinedShapeFillColorAnim.values   = [UIColor(red:0.848, green: 0.43, blue:0.415, alpha:1).cgColor,
                                               self.extraDarkGray.cgColor]
        CombinedShapeFillColorAnim.keyTimes = [0, 1]
        CombinedShapeFillColorAnim.duration = 0.3
        
        let CombinedShapeDeselectAnim : CAAnimationGroup = QCMethod.group(animations: [CombinedShapeFillColorAnim], fillMode:fillMode)
        layers["CombinedShape"]?.add(CombinedShapeDeselectAnim, forKey:"CombinedShapeDeselectAnim")
    }
    
    //MARK: - Animation Cleanup
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool){
        if let completionBlock = completionBlocks[anim]{
            completionBlocks.removeValue(forKey: anim)
            if (flag && updateLayerValueForCompletedAnimation) || anim.value(forKey: "needEndAnim") as! Bool{
                updateLayerValues(forAnimationId: anim.value(forKey: "animId") as! String)
                removeAnimations(forAnimationId: anim.value(forKey: "animId") as! String)
            }
            completionBlock(flag)
        }
    }
    
    func updateLayerValues(forAnimationId identifier: String){
        if identifier == "select"{
            QCMethod.updateValueFromPresentationLayer(forAnimation: layers["barber_a"]!.animation(forKey: "barber_aSelectAnim"), theLayer:layers["barber_a"]!)
            QCMethod.updateValueFromPresentationLayer(forAnimation: layers["path"]!.animation(forKey: "pathSelectAnim"), theLayer:layers["path"]!)
            QCMethod.updateValueFromPresentationLayer(forAnimation: layers["Ellipse_2_копия_"]!.animation(forKey: "Ellipse_2_копия_SelectAnim"), theLayer:layers["Ellipse_2_копия_"]!)
            QCMethod.updateValueFromPresentationLayer(forAnimation: layers["Ellipse_2_копия_3"]!.animation(forKey: "Ellipse_2_копия_3SelectAnim"), theLayer:layers["Ellipse_2_копия_3"]!)
            QCMethod.updateValueFromPresentationLayer(forAnimation: layers["leftEye"]!.animation(forKey: "leftEyeSelectAnim"), theLayer:layers["leftEye"]!)
            QCMethod.updateValueFromPresentationLayer(forAnimation: layers["rightEye"]!.animation(forKey: "rightEyeSelectAnim"), theLayer:layers["rightEye"]!)
            QCMethod.updateValueFromPresentationLayer(forAnimation: layers["Ellipse_2_копия_4"]!.animation(forKey: "Ellipse_2_копия_4SelectAnim"), theLayer:layers["Ellipse_2_копия_4"]!)
            QCMethod.updateValueFromPresentationLayer(forAnimation: layers["Ellipse_2_копия_5"]!.animation(forKey: "Ellipse_2_копия_5SelectAnim"), theLayer:layers["Ellipse_2_копия_5"]!)
            QCMethod.updateValueFromPresentationLayer(forAnimation: layers["CombinedShape"]!.animation(forKey: "CombinedShapeSelectAnim"), theLayer:layers["CombinedShape"]!)
        }
        else if identifier == "deselect"{
            QCMethod.updateValueFromPresentationLayer(forAnimation: layers["barber_a"]!.animation(forKey: "barber_aDeselectAnim"), theLayer:layers["barber_a"]!)
            QCMethod.updateValueFromPresentationLayer(forAnimation: layers["path"]!.animation(forKey: "pathDeselectAnim"), theLayer:layers["path"]!)
            QCMethod.updateValueFromPresentationLayer(forAnimation: layers["Ellipse_2_копия_"]!.animation(forKey: "Ellipse_2_копия_DeselectAnim"), theLayer:layers["Ellipse_2_копия_"]!)
            QCMethod.updateValueFromPresentationLayer(forAnimation: layers["Ellipse_2_копия_3"]!.animation(forKey: "Ellipse_2_копия_3DeselectAnim"), theLayer:layers["Ellipse_2_копия_3"]!)
            QCMethod.updateValueFromPresentationLayer(forAnimation: layers["leftEye"]!.animation(forKey: "leftEyeDeselectAnim"), theLayer:layers["leftEye"]!)
            QCMethod.updateValueFromPresentationLayer(forAnimation: layers["rightEye"]!.animation(forKey: "rightEyeDeselectAnim"), theLayer:layers["rightEye"]!)
            QCMethod.updateValueFromPresentationLayer(forAnimation: layers["Ellipse_2_копия_4"]!.animation(forKey: "Ellipse_2_копия_4DeselectAnim"), theLayer:layers["Ellipse_2_копия_4"]!)
            QCMethod.updateValueFromPresentationLayer(forAnimation: layers["Ellipse_2_копия_5"]!.animation(forKey: "Ellipse_2_копия_5DeselectAnim"), theLayer:layers["Ellipse_2_копия_5"]!)
            QCMethod.updateValueFromPresentationLayer(forAnimation: layers["CombinedShape"]!.animation(forKey: "CombinedShapeDeselectAnim"), theLayer:layers["CombinedShape"]!)
        }
    }
    
    func removeAnimations(forAnimationId identifier: String){
        if identifier == "select"{
            layers["barber_a"]?.removeAnimation(forKey: "barber_aSelectAnim")
            layers["path"]?.removeAnimation(forKey: "pathSelectAnim")
            layers["Ellipse_2_копия_"]?.removeAnimation(forKey: "Ellipse_2_копия_SelectAnim")
            layers["Ellipse_2_копия_3"]?.removeAnimation(forKey: "Ellipse_2_копия_3SelectAnim")
            layers["leftEye"]?.removeAnimation(forKey: "leftEyeSelectAnim")
            layers["rightEye"]?.removeAnimation(forKey: "rightEyeSelectAnim")
            layers["Ellipse_2_копия_4"]?.removeAnimation(forKey: "Ellipse_2_копия_4SelectAnim")
            layers["Ellipse_2_копия_5"]?.removeAnimation(forKey: "Ellipse_2_копия_5SelectAnim")
            layers["CombinedShape"]?.removeAnimation(forKey: "CombinedShapeSelectAnim")
        }
        else if identifier == "deselect"{
            layers["barber_a"]?.removeAnimation(forKey: "barber_aDeselectAnim")
            layers["path"]?.removeAnimation(forKey: "pathDeselectAnim")
            layers["Ellipse_2_копия_"]?.removeAnimation(forKey: "Ellipse_2_копия_DeselectAnim")
            layers["Ellipse_2_копия_3"]?.removeAnimation(forKey: "Ellipse_2_копия_3DeselectAnim")
            layers["leftEye"]?.removeAnimation(forKey: "leftEyeDeselectAnim")
            layers["rightEye"]?.removeAnimation(forKey: "rightEyeDeselectAnim")
            layers["Ellipse_2_копия_4"]?.removeAnimation(forKey: "Ellipse_2_копия_4DeselectAnim")
            layers["Ellipse_2_копия_5"]?.removeAnimation(forKey: "Ellipse_2_копия_5DeselectAnim")
            layers["CombinedShape"]?.removeAnimation(forKey: "CombinedShapeDeselectAnim")
        }
    }
    
    func removeAllAnimations(){
        for layer in layers.values{
            layer.removeAllAnimations()
        }
    }
    
    //MARK: - Bezier Path
    
    func pathPath(bounds: CGRect) -> UIBezierPath{
        let pathPath = UIBezierPath()
        let minX = CGFloat(bounds.minX), minY = bounds.minY, w = bounds.width, h = bounds.height;
        
        pathPath.move(to: CGPoint(x:minX + w, y: minY + 0.5 * h))
        pathPath.addCurve(to: CGPoint(x:minX + 0.5 * w, y: minY + h), controlPoint1:CGPoint(x:minX + w, y: minY + 0.77614 * h), controlPoint2:CGPoint(x:minX + 0.77614 * w, y: minY + h))
        pathPath.addCurve(to: CGPoint(x:minX, y: minY + 0.5 * h), controlPoint1:CGPoint(x:minX + 0.22386 * w, y: minY + h), controlPoint2:CGPoint(x:minX, y: minY + 0.77614 * h))
        pathPath.addCurve(to: CGPoint(x:minX + 0.5 * w, y: minY), controlPoint1:CGPoint(x:minX, y: minY + 0.22386 * h), controlPoint2:CGPoint(x:minX + 0.22386 * w, y: minY))
        pathPath.addCurve(to: CGPoint(x:minX + w, y: minY + 0.5 * h), controlPoint1:CGPoint(x:minX + 0.77614 * w, y: minY), controlPoint2:CGPoint(x:minX + w, y: minY + 0.22386 * h))
        pathPath.close()
        pathPath.move(to: CGPoint(x:minX + w, y: minY + 0.5 * h))
        
        return pathPath
    }
    
    func Ellipse_2_копия_Path(bounds: CGRect) -> UIBezierPath{
        let Ellipse_2_копия_Path = UIBezierPath()
        let minX = CGFloat(bounds.minX), minY = bounds.minY, w = bounds.width, h = bounds.height;
        
        Ellipse_2_копия_Path.move(to: CGPoint(x:minX + w, y: minY + 0.5 * h))
        Ellipse_2_копия_Path.addCurve(to: CGPoint(x:minX + 0.5 * w, y: minY + h), controlPoint1:CGPoint(x:minX + w, y: minY + 0.77614 * h), controlPoint2:CGPoint(x:minX + 0.77614 * w, y: minY + h))
        Ellipse_2_копия_Path.addCurve(to: CGPoint(x:minX, y: minY + 0.5 * h), controlPoint1:CGPoint(x:minX + 0.22386 * w, y: minY + h), controlPoint2:CGPoint(x:minX, y: minY + 0.77614 * h))
        Ellipse_2_копия_Path.addCurve(to: CGPoint(x:minX + 0.5 * w, y: minY), controlPoint1:CGPoint(x:minX, y: minY + 0.22386 * h), controlPoint2:CGPoint(x:minX + 0.22386 * w, y: minY))
        Ellipse_2_копия_Path.addCurve(to: CGPoint(x:minX + w, y: minY + 0.5 * h), controlPoint1:CGPoint(x:minX + 0.77614 * w, y: minY), controlPoint2:CGPoint(x:minX + w, y: minY + 0.22386 * h))
        Ellipse_2_копия_Path.close()
        Ellipse_2_копия_Path.move(to: CGPoint(x:minX + w, y: minY + 0.5 * h))
        
        return Ellipse_2_копия_Path
    }
    
    func Ellipse_2_копия_2Path(bounds: CGRect) -> UIBezierPath{
        let Ellipse_2_копия_2Path = UIBezierPath()
        let minX = CGFloat(bounds.minX), minY = bounds.minY, w = bounds.width, h = bounds.height;
        
        Ellipse_2_копия_2Path.move(to: CGPoint(x:minX + 0.49727 * w, y: minY + h))
        Ellipse_2_копия_2Path.addCurve(to: CGPoint(x:minX + 0.08782 * w, y: minY + 0.88916 * h), controlPoint1:CGPoint(x:minX + 0.34842 * w, y: minY + 1.00017 * h), controlPoint2:CGPoint(x:minX + 0.20396 * w, y: minY + 0.96107 * h))
        Ellipse_2_копия_2Path.addCurve(to: CGPoint(x:minX + 0.32168 * w, y: minY + 0.74689 * h), controlPoint1:CGPoint(x:minX + 0.14534 * w, y: minY + 0.82455 * h), controlPoint2:CGPoint(x:minX + 0.22688 * w, y: minY + 0.77495 * h))
        Ellipse_2_копия_2Path.addCurve(to: CGPoint(x:minX + 0.00834 * w, y: minY + 0.31612 * h), controlPoint1:CGPoint(x:minX + 0.09639 * w, y: minY + 0.68046 * h), controlPoint2:CGPoint(x:minX + -0.03539 * w, y: minY + 0.49928 * h))
        Ellipse_2_копия_2Path.addCurve(to: CGPoint(x:minX + 0.5 * w, y: minY), controlPoint1:CGPoint(x:minX + 0.05207 * w, y: minY + 0.13295 * h), controlPoint2:CGPoint(x:minX + 0.25885 * w, y: minY))
        Ellipse_2_копия_2Path.addCurve(to: CGPoint(x:minX + 0.99166 * w, y: minY + 0.31612 * h), controlPoint1:CGPoint(x:minX + 0.74115 * w, y: minY), controlPoint2:CGPoint(x:minX + 0.94793 * w, y: minY + 0.13295 * h))
        Ellipse_2_копия_2Path.addCurve(to: CGPoint(x:minX + 0.67832 * w, y: minY + 0.74689 * h), controlPoint1:CGPoint(x:minX + 1.03539 * w, y: minY + 0.49928 * h), controlPoint2:CGPoint(x:minX + 0.90361 * w, y: minY + 0.68046 * h))
        Ellipse_2_копия_2Path.addCurve(to: CGPoint(x:minX + 0.91026 * w, y: minY + 0.88697 * h), controlPoint1:CGPoint(x:minX + 0.77204 * w, y: minY + 0.7746 * h), controlPoint2:CGPoint(x:minX + 0.85284 * w, y: minY + 0.8234 * h))
        Ellipse_2_копия_2Path.addCurve(to: CGPoint(x:minX + 0.49727 * w, y: minY + h), controlPoint1:CGPoint(x:minX + 0.79355 * w, y: minY + 0.96025 * h), controlPoint2:CGPoint(x:minX + 0.64767 * w, y: minY + 1.00017 * h))
        Ellipse_2_копия_2Path.addLine(to: CGPoint(x:minX + 0.49727 * w, y: minY + h))
        Ellipse_2_копия_2Path.close()
        Ellipse_2_копия_2Path.move(to: CGPoint(x:minX + 0.49727 * w, y: minY + h))
        
        return Ellipse_2_копия_2Path
    }
    
    func Ellipse_2_копия_3Path(bounds: CGRect) -> UIBezierPath{
        let Ellipse_2_копия_3Path = UIBezierPath()
        let minX = CGFloat(bounds.minX), minY = bounds.minY, w = bounds.width, h = bounds.height;
        
        Ellipse_2_копия_3Path.move(to: CGPoint(x:minX + 0.50137 * w, y: minY + h))
        Ellipse_2_копия_3Path.addCurve(to: CGPoint(x:minX, y: minY + 0.40477 * h), controlPoint1:CGPoint(x:minX + 0.30783 * w, y: minY + 1.00048 * h), controlPoint2:CGPoint(x:minX + 0.12418 * w, y: minY + 0.78245 * h))
        Ellipse_2_копия_3Path.addCurve(to: CGPoint(x:minX + w, y: minY + 0.41292 * h), controlPoint1:CGPoint(x:minX + 0.29959 * w, y: minY + -0.13791 * h), controlPoint2:CGPoint(x:minX + 0.70178 * w, y: minY + -0.13463 * h))
        Ellipse_2_копия_3Path.addCurve(to: CGPoint(x:minX + 0.50137 * w, y: minY + h), controlPoint1:CGPoint(x:minX + 0.87583 * w, y: minY + 0.7857 * h), controlPoint2:CGPoint(x:minX + 0.69343 * w, y: minY + 1.00044 * h))
        Ellipse_2_копия_3Path.addLine(to: CGPoint(x:minX + 0.50137 * w, y: minY + h))
        Ellipse_2_копия_3Path.close()
        Ellipse_2_копия_3Path.move(to: CGPoint(x:minX + 0.50137 * w, y: minY + h))
        
        return Ellipse_2_копия_3Path
    }
    
    func leftEyePath(bounds: CGRect) -> UIBezierPath{
        let leftEyePath = UIBezierPath()
        let minX = CGFloat(bounds.minX), minY = bounds.minY, w = bounds.width, h = bounds.height;
        
        leftEyePath.move(to: CGPoint(x:minX + 0.91436 * w, y: minY + 0.22008 * h))
        leftEyePath.addCurve(to: CGPoint(x:minX + w, y: minY + 0.5 * h), controlPoint1:CGPoint(x:minX + 0.96842 * w, y: minY + 0.29995 * h), controlPoint2:CGPoint(x:minX + w, y: minY + 0.39629 * h))
        leftEyePath.addCurve(to: CGPoint(x:minX + 0.5 * w, y: minY + h), controlPoint1:CGPoint(x:minX + w, y: minY + 0.77614 * h), controlPoint2:CGPoint(x:minX + 0.77614 * w, y: minY + h))
        leftEyePath.addCurve(to: CGPoint(x:minX, y: minY + 0.5 * h), controlPoint1:CGPoint(x:minX + 0.22386 * w, y: minY + h), controlPoint2:CGPoint(x:minX, y: minY + 0.77614 * h))
        leftEyePath.addCurve(to: CGPoint(x:minX + 0.5 * w, y: minY), controlPoint1:CGPoint(x:minX, y: minY + 0.22386 * h), controlPoint2:CGPoint(x:minX + 0.22386 * w, y: minY))
        leftEyePath.addCurve(to: CGPoint(x:minX + 0.82175 * w, y: minY + 0.11727 * h), controlPoint1:CGPoint(x:minX + 0.62255 * w, y: minY), controlPoint2:CGPoint(x:minX + 0.7348 * w, y: minY + 0.04409 * h))
        leftEyePath.addCurve(to: CGPoint(x:minX + 0.77027 * w, y: minY + 0.10811 * h), controlPoint1:CGPoint(x:minX + 0.80571 * w, y: minY + 0.11134 * h), controlPoint2:CGPoint(x:minX + 0.78837 * w, y: minY + 0.10811 * h))
        leftEyePath.addCurve(to: CGPoint(x:minX + 0.62162 * w, y: minY + 0.25676 * h), controlPoint1:CGPoint(x:minX + 0.68817 * w, y: minY + 0.10811 * h), controlPoint2:CGPoint(x:minX + 0.62162 * w, y: minY + 0.17466 * h))
        leftEyePath.addCurve(to: CGPoint(x:minX + 0.77027 * w, y: minY + 0.40541 * h), controlPoint1:CGPoint(x:minX + 0.62162 * w, y: minY + 0.33885 * h), controlPoint2:CGPoint(x:minX + 0.68817 * w, y: minY + 0.40541 * h))
        leftEyePath.addCurve(to: CGPoint(x:minX + 0.91892 * w, y: minY + 0.25676 * h), controlPoint1:CGPoint(x:minX + 0.85237 * w, y: minY + 0.40541 * h), controlPoint2:CGPoint(x:minX + 0.91892 * w, y: minY + 0.33885 * h))
        leftEyePath.addCurve(to: CGPoint(x:minX + 0.91436 * w, y: minY + 0.22008 * h), controlPoint1:CGPoint(x:minX + 0.91892 * w, y: minY + 0.2441 * h), controlPoint2:CGPoint(x:minX + 0.91734 * w, y: minY + 0.23181 * h))
        leftEyePath.addLine(to: CGPoint(x:minX + 0.91436 * w, y: minY + 0.22008 * h))
        leftEyePath.close()
        leftEyePath.move(to: CGPoint(x:minX + 0.91436 * w, y: minY + 0.22008 * h))
        
        return leftEyePath
    }
    
    func rightEyePath(bounds: CGRect) -> UIBezierPath{
        let rightEyePath = UIBezierPath()
        let minX = CGFloat(bounds.minX), minY = bounds.minY, w = bounds.width, h = bounds.height;
        
        rightEyePath.move(to: CGPoint(x:minX + 0.91392 * w, y: minY + 0.21942 * h))
        rightEyePath.addCurve(to: CGPoint(x:minX + w, y: minY + 0.5 * h), controlPoint1:CGPoint(x:minX + 0.96825 * w, y: minY + 0.29942 * h), controlPoint2:CGPoint(x:minX + w, y: minY + 0.396 * h))
        rightEyePath.addCurve(to: CGPoint(x:minX + 0.5 * w, y: minY + h), controlPoint1:CGPoint(x:minX + w, y: minY + 0.77614 * h), controlPoint2:CGPoint(x:minX + 0.77614 * w, y: minY + h))
        rightEyePath.addCurve(to: CGPoint(x:minX, y: minY + 0.5 * h), controlPoint1:CGPoint(x:minX + 0.22386 * w, y: minY + h), controlPoint2:CGPoint(x:minX, y: minY + 0.77614 * h))
        rightEyePath.addCurve(to: CGPoint(x:minX + 0.5 * w, y: minY), controlPoint1:CGPoint(x:minX, y: minY + 0.22386 * h), controlPoint2:CGPoint(x:minX + 0.22386 * w, y: minY))
        rightEyePath.addCurve(to: CGPoint(x:minX + 0.82254 * w, y: minY + 0.11793 * h), controlPoint1:CGPoint(x:minX + 0.62292 * w, y: minY), controlPoint2:CGPoint(x:minX + 0.73548 * w, y: minY + 0.04435 * h))
        rightEyePath.addCurve(to: CGPoint(x:minX + 0.77016 * w, y: minY + 0.10843 * h), controlPoint1:CGPoint(x:minX + 0.80625 * w, y: minY + 0.11179 * h), controlPoint2:CGPoint(x:minX + 0.7886 * w, y: minY + 0.10843 * h))
        rightEyePath.addCurve(to: CGPoint(x:minX + 0.62162 * w, y: minY + 0.25697 * h), controlPoint1:CGPoint(x:minX + 0.68813 * w, y: minY + 0.10844 * h), controlPoint2:CGPoint(x:minX + 0.62163 * w, y: minY + 0.17494 * h))
        rightEyePath.addCurve(to: CGPoint(x:minX + 0.77016 * w, y: minY + 0.40551 * h), controlPoint1:CGPoint(x:minX + 0.62162 * w, y: minY + 0.33901 * h), controlPoint2:CGPoint(x:minX + 0.68813 * w, y: minY + 0.40551 * h))
        rightEyePath.addCurve(to: CGPoint(x:minX + 0.9187 * w, y: minY + 0.25697 * h), controlPoint1:CGPoint(x:minX + 0.8522 * w, y: minY + 0.40551 * h), controlPoint2:CGPoint(x:minX + 0.9187 * w, y: minY + 0.33901 * h))
        rightEyePath.addCurve(to: CGPoint(x:minX + 0.91392 * w, y: minY + 0.21942 * h), controlPoint1:CGPoint(x:minX + 0.9187 * w, y: minY + 0.244 * h), controlPoint2:CGPoint(x:minX + 0.91704 * w, y: minY + 0.23142 * h))
        rightEyePath.addLine(to: CGPoint(x:minX + 0.91392 * w, y: minY + 0.21942 * h))
        rightEyePath.close()
        rightEyePath.move(to: CGPoint(x:minX + 0.91392 * w, y: minY + 0.21942 * h))
        
        return rightEyePath
    }
    
    func Ellipse_2_копия_4Path(bounds: CGRect) -> UIBezierPath{
        let Ellipse_2_копия_4Path = UIBezierPath()
        let minX = CGFloat(bounds.minX), minY = bounds.minY, w = bounds.width, h = bounds.height;
        
        Ellipse_2_копия_4Path.move(to: CGPoint(x:minX + w, y: minY + 0.5 * h))
        Ellipse_2_копия_4Path.addCurve(to: CGPoint(x:minX + 0.5 * w, y: minY + h), controlPoint1:CGPoint(x:minX + w, y: minY + 0.77614 * h), controlPoint2:CGPoint(x:minX + 0.77614 * w, y: minY + h))
        Ellipse_2_копия_4Path.addCurve(to: CGPoint(x:minX, y: minY + 0.5 * h), controlPoint1:CGPoint(x:minX + 0.22386 * w, y: minY + h), controlPoint2:CGPoint(x:minX, y: minY + 0.77614 * h))
        Ellipse_2_копия_4Path.addCurve(to: CGPoint(x:minX + 0.5 * w, y: minY), controlPoint1:CGPoint(x:minX, y: minY + 0.22386 * h), controlPoint2:CGPoint(x:minX + 0.22386 * w, y: minY))
        Ellipse_2_копия_4Path.addCurve(to: CGPoint(x:minX + w, y: minY + 0.5 * h), controlPoint1:CGPoint(x:minX + 0.77614 * w, y: minY), controlPoint2:CGPoint(x:minX + w, y: minY + 0.22386 * h))
        Ellipse_2_копия_4Path.close()
        Ellipse_2_копия_4Path.move(to: CGPoint(x:minX + w, y: minY + 0.5 * h))
        
        return Ellipse_2_копия_4Path
    }
    
    func Ellipse_2_копия_5Path(bounds: CGRect) -> UIBezierPath{
        let Ellipse_2_копия_5Path = UIBezierPath()
        let minX = CGFloat(bounds.minX), minY = bounds.minY, w = bounds.width, h = bounds.height;
        
        Ellipse_2_копия_5Path.move(to: CGPoint(x:minX + w, y: minY + 0.5 * h))
        Ellipse_2_копия_5Path.addCurve(to: CGPoint(x:minX + 0.5 * w, y: minY + h), controlPoint1:CGPoint(x:minX + w, y: minY + 0.77614 * h), controlPoint2:CGPoint(x:minX + 0.77614 * w, y: minY + h))
        Ellipse_2_копия_5Path.addCurve(to: CGPoint(x:minX, y: minY + 0.5 * h), controlPoint1:CGPoint(x:minX + 0.22386 * w, y: minY + h), controlPoint2:CGPoint(x:minX, y: minY + 0.77614 * h))
        Ellipse_2_копия_5Path.addCurve(to: CGPoint(x:minX + 0.5 * w, y: minY), controlPoint1:CGPoint(x:minX, y: minY + 0.22386 * h), controlPoint2:CGPoint(x:minX + 0.22386 * w, y: minY))
        Ellipse_2_копия_5Path.addCurve(to: CGPoint(x:minX + w, y: minY + 0.5 * h), controlPoint1:CGPoint(x:minX + 0.77614 * w, y: minY), controlPoint2:CGPoint(x:minX + w, y: minY + 0.22386 * h))
        Ellipse_2_копия_5Path.close()
        Ellipse_2_копия_5Path.move(to: CGPoint(x:minX + w, y: minY + 0.5 * h))
        
        return Ellipse_2_копия_5Path
    }
    
    func CombinedShapePath(bounds: CGRect) -> UIBezierPath{
        let CombinedShapePath = UIBezierPath()
        let minX = CGFloat(bounds.minX), minY = bounds.minY, w = bounds.width, h = bounds.height;
        
        CombinedShapePath.move(to: CGPoint(x:minX + 0.97623 * w, y: minY + 0.00189 * h))
        CombinedShapePath.addCurve(to: CGPoint(x:minX + 0.8552 * w, y: minY + 0.77335 * h), controlPoint1:CGPoint(x:minX + 1.03266 * w, y: minY + 0.27156 * h), controlPoint2:CGPoint(x:minX + 0.98717 * w, y: minY + 0.56952 * h))
        CombinedShapePath.addCurve(to: CGPoint(x:minX + 0.30975 * w, y: minY + 0.94243 * h), controlPoint1:CGPoint(x:minX + 0.71258 * w, y: minY + 0.99364 * h), controlPoint2:CGPoint(x:minX + 0.49716 * w, y: minY + 1.06042 * h))
        CombinedShapePath.addCurve(to: CGPoint(x:minX + 0.00001 * w, y: minY + 0.23495 * h), controlPoint1:CGPoint(x:minX + 0.12234 * w, y: minY + 0.82444 * h), controlPoint2:CGPoint(x:minX + 0.00001 * w, y: minY + 0.54503 * h))
        CombinedShapePath.addCurve(to: CGPoint(x:minX + 0.02353 * w, y: minY), controlPoint1:CGPoint(x:minX + -0.00024 * w, y: minY + 0.15448 * h), controlPoint2:CGPoint(x:minX + 0.00784 * w, y: minY + 0.07526 * h))
        CombinedShapePath.addCurve(to: CGPoint(x:minX + 0.30989 * w, y: minY + 0.47564 * h), controlPoint1:CGPoint(x:minX + 0.06759 * w, y: minY + 0.21181 * h), controlPoint2:CGPoint(x:minX + 0.17084 * w, y: minY + 0.38815 * h))
        CombinedShapePath.addCurve(to: CGPoint(x:minX + 0.85542 * w, y: minY + 0.30638 * h), controlPoint1:CGPoint(x:minX + 0.49734 * w, y: minY + 0.5936 * h), controlPoint2:CGPoint(x:minX + 0.7128 * w, y: minY + 0.52675 * h))
        CombinedShapePath.addCurve(to: CGPoint(x:minX + 0.97623 * w, y: minY + 0.00189 * h), controlPoint1:CGPoint(x:minX + 0.91199 * w, y: minY + 0.21897 * h), controlPoint2:CGPoint(x:minX + 0.95267 * w, y: minY + 0.11426 * h))
        CombinedShapePath.addLine(to: CGPoint(x:minX + 0.97623 * w, y: minY + 0.00189 * h))
        CombinedShapePath.close()
        CombinedShapePath.move(to: CGPoint(x:minX + 0.97623 * w, y: minY + 0.00189 * h))
        
        return CombinedShapePath
    }
    
    
}
