//
//  ClientAnimView.swift
//  Burb
//
//  Created by Pavel Bukharov on 24.07.2018.
//  Copyright © 2018 Pavel Bukharov. All rights reserved.
//

import UIKit

import UIKit

@IBDesignable
class ClientAnimView: UIView, CAAnimationDelegate {
    
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
        self.extraDarkGray = UIColor(red:0.664, green: 0.664, blue:0.664, alpha:1)
    }
    
    func setupLayers(){
        let client = CALayer()
        self.layer.addSublayer(client)
        layers["client"] = client
        let client_a = CALayer()
        client.addSublayer(client_a)
        layers["client_a"] = client_a
        let path = CAShapeLayer()
        client_a.addSublayer(path)
        layers["path"] = path
        let Ellipse_2_копия_ = CAShapeLayer()
        client_a.addSublayer(Ellipse_2_копия_)
        layers["Ellipse_2_копия_"] = Ellipse_2_копия_
        let Ellipse_2_копия_2 = CAShapeLayer()
        client_a.addSublayer(Ellipse_2_копия_2)
        layers["Ellipse_2_копия_2"] = Ellipse_2_копия_2
        let leftEye = CAShapeLayer()
        client_a.addSublayer(leftEye)
        layers["leftEye"] = leftEye
        let Ellipse_2_копия_3 = CAShapeLayer()
        client_a.addSublayer(Ellipse_2_копия_3)
        layers["Ellipse_2_копия_3"] = Ellipse_2_копия_3
        let Ellipse_2_копия_4 = CAShapeLayer()
        client_a.addSublayer(Ellipse_2_копия_4)
        layers["Ellipse_2_копия_4"] = Ellipse_2_копия_4
        let rightEye = CAShapeLayer()
        client_a.addSublayer(rightEye)
        layers["rightEye"] = rightEye
        let CombinedShape = CAShapeLayer()
        client_a.addSublayer(CombinedShape)
        layers["CombinedShape"] = CombinedShape
        let Ellipse_2_копия_5 = CAShapeLayer()
        client_a.addSublayer(Ellipse_2_копия_5)
        layers["Ellipse_2_копия_5"] = Ellipse_2_копия_5
        
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
            Ellipse_2_копия_.fillColor   = UIColor(red:0.316, green: 0.266, blue:0.371, alpha:1).cgColor
            Ellipse_2_копия_.strokeColor = UIColor.black.cgColor
            Ellipse_2_копия_.lineWidth   = 0
        }
        if layerIds == nil || layerIds.contains("Ellipse_2_копия_2"){
            let Ellipse_2_копия_2 = layers["Ellipse_2_копия_2"] as! CAShapeLayer
            Ellipse_2_копия_2.fillColor   = UIColor(red:1.00, green: 1.00, blue:1.00, alpha:1.0).cgColor
            Ellipse_2_копия_2.strokeColor = UIColor.black.cgColor
            Ellipse_2_копия_2.lineWidth   = 0
        }
        if layerIds == nil || layerIds.contains("leftEye"){
            let leftEye = layers["leftEye"] as! CAShapeLayer
            leftEye.fillColor   = UIColor(red:0.316, green: 0.266, blue:0.371, alpha:1).cgColor
            leftEye.strokeColor = UIColor.black.cgColor
            leftEye.lineWidth   = 0
        }
        if layerIds == nil || layerIds.contains("Ellipse_2_копия_3"){
            let Ellipse_2_копия_3 = layers["Ellipse_2_копия_3"] as! CAShapeLayer
            Ellipse_2_копия_3.fillColor   = UIColor(red:0.848, green: 0.43, blue:0.415, alpha:1).cgColor
            Ellipse_2_копия_3.strokeColor = UIColor.black.cgColor
            Ellipse_2_копия_3.lineWidth   = 0
        }
        if layerIds == nil || layerIds.contains("Ellipse_2_копия_4"){
            let Ellipse_2_копия_4 = layers["Ellipse_2_копия_4"] as! CAShapeLayer
            Ellipse_2_копия_4.fillColor   = UIColor(red:0.848, green: 0.43, blue:0.415, alpha:1).cgColor
            Ellipse_2_копия_4.strokeColor = UIColor.black.cgColor
            Ellipse_2_копия_4.lineWidth   = 0
        }
        if layerIds == nil || layerIds.contains("rightEye"){
            let rightEye = layers["rightEye"] as! CAShapeLayer
            rightEye.fillColor   = UIColor(red:0.316, green: 0.266, blue:0.371, alpha:1).cgColor
            rightEye.strokeColor = UIColor.black.cgColor
            rightEye.lineWidth   = 0
        }
        if layerIds == nil || layerIds.contains("CombinedShape"){
            let CombinedShape = layers["CombinedShape"] as! CAShapeLayer
            CombinedShape.fillColor   = UIColor(red:0.848, green: 0.43, blue:0.415, alpha:1).cgColor
            CombinedShape.strokeColor = UIColor.black.cgColor
            CombinedShape.lineWidth   = 0
        }
        if layerIds == nil || layerIds.contains("Ellipse_2_копия_5"){
            let Ellipse_2_копия_5 = layers["Ellipse_2_копия_5"] as! CAShapeLayer
            Ellipse_2_копия_5.fillColor   = UIColor(red:0.316, green: 0.266, blue:0.371, alpha:1).cgColor
            Ellipse_2_копия_5.strokeColor = UIColor.black.cgColor
            Ellipse_2_копия_5.lineWidth   = 0
        }
        
        CATransaction.commit()
    }
    
    func setupLayerFrames(){
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        
        if let client = layers["client"]{
            client.frame = CGRect(x: 0, y: 0, width:  client.superlayer!.bounds.width, height:  client.superlayer!.bounds.height)
        }
        
        if let client_a = layers["client_a"]{
            client_a.frame = CGRect(x: 0, y: 0, width:  client_a.superlayer!.bounds.width, height:  client_a.superlayer!.bounds.height)
        }
        
        if let path = layers["path"] as? CAShapeLayer{
            path.frame = CGRect(x: 0, y: 0, width:  path.superlayer!.bounds.width, height:  path.superlayer!.bounds.height)
            path.path  = pathPath(bounds: layers["path"]!.bounds).cgPath
        }
        
        if let Ellipse_2_копия_ = layers["Ellipse_2_копия_"] as? CAShapeLayer{
            Ellipse_2_копия_.frame = CGRect(x: 0.03125 * Ellipse_2_копия_.superlayer!.bounds.width, y: 0.03125 * Ellipse_2_копия_.superlayer!.bounds.height, width: 0.9375 * Ellipse_2_копия_.superlayer!.bounds.width, height: 0.9375 * Ellipse_2_копия_.superlayer!.bounds.height)
            Ellipse_2_копия_.path  = Ellipse_2_копия_Path(bounds: layers["Ellipse_2_копия_"]!.bounds).cgPath
        }
        
        if let Ellipse_2_копия_2 = layers["Ellipse_2_копия_2"] as? CAShapeLayer{
            Ellipse_2_копия_2.frame = CGRect(x: 0.15625 * Ellipse_2_копия_2.superlayer!.bounds.width, y: 0.02813 * Ellipse_2_копия_2.superlayer!.bounds.height, width: 0.6875 * Ellipse_2_копия_2.superlayer!.bounds.width, height: 0.73454 * Ellipse_2_копия_2.superlayer!.bounds.height)
            Ellipse_2_копия_2.path  = Ellipse_2_копия_2Path(bounds: layers["Ellipse_2_копия_2"]!.bounds).cgPath
        }
        
        if let leftEye = layers["leftEye"] as? CAShapeLayer{
            leftEye.frame = CGRect(x: 0.34375 * leftEye.superlayer!.bounds.width, y: 0.2625 * leftEye.superlayer!.bounds.height, width: 0.08125 * leftEye.superlayer!.bounds.width, height: 0.08125 * leftEye.superlayer!.bounds.height)
            leftEye.path  = leftEyePath(bounds: layers["leftEye"]!.bounds).cgPath
        }
        
        if let Ellipse_2_копия_3 = layers["Ellipse_2_копия_3"] as? CAShapeLayer{
            Ellipse_2_копия_3.frame = CGRect(x: 0.34375 * Ellipse_2_копия_3.superlayer!.bounds.width, y: 0.19688 * Ellipse_2_копия_3.superlayer!.bounds.height, width: 0.03438 * Ellipse_2_копия_3.superlayer!.bounds.width, height: 0.03438 * Ellipse_2_копия_3.superlayer!.bounds.height)
            Ellipse_2_копия_3.path  = Ellipse_2_копия_3Path(bounds: layers["Ellipse_2_копия_3"]!.bounds).cgPath
        }
        
        if let Ellipse_2_копия_4 = layers["Ellipse_2_копия_4"] as? CAShapeLayer{
            Ellipse_2_копия_4.frame = CGRect(x: 0.61875 * Ellipse_2_копия_4.superlayer!.bounds.width, y: 0.19688 * Ellipse_2_копия_4.superlayer!.bounds.height, width: 0.03438 * Ellipse_2_копия_4.superlayer!.bounds.width, height: 0.03438 * Ellipse_2_копия_4.superlayer!.bounds.height)
            Ellipse_2_копия_4.path  = Ellipse_2_копия_4Path(bounds: layers["Ellipse_2_копия_4"]!.bounds).cgPath
        }
        
        if let rightEye = layers["rightEye"] as? CAShapeLayer{
            rightEye.frame = CGRect(x: 0.56562 * rightEye.superlayer!.bounds.width, y: 0.2625 * rightEye.superlayer!.bounds.height, width: 0.08125 * rightEye.superlayer!.bounds.width, height: 0.08125 * rightEye.superlayer!.bounds.height)
            rightEye.path  = rightEyePath(bounds: layers["rightEye"]!.bounds).cgPath
        }
        
        if let CombinedShape = layers["CombinedShape"] as? CAShapeLayer{
            CombinedShape.frame = CGRect(x: 0.425 * CombinedShape.superlayer!.bounds.width, y: 0.59846 * CombinedShape.superlayer!.bounds.height, width: 0.15726 * CombinedShape.superlayer!.bounds.width, height: 0.10468 * CombinedShape.superlayer!.bounds.height)
            CombinedShape.path  = CombinedShapePath(bounds: layers["CombinedShape"]!.bounds).cgPath
        }
        
        if let Ellipse_2_копия_5 = layers["Ellipse_2_копия_5"] as? CAShapeLayer{
            Ellipse_2_копия_5.frame = CGRect(x: 0.3875 * Ellipse_2_копия_5.superlayer!.bounds.width, y: 0.02813 * Ellipse_2_копия_5.superlayer!.bounds.height, width: 0.22814 * Ellipse_2_копия_5.superlayer!.bounds.width, height: 0.16873 * Ellipse_2_копия_5.superlayer!.bounds.height)
            Ellipse_2_копия_5.path  = Ellipse_2_копия_5Path(bounds: layers["Ellipse_2_копия_5"]!.bounds).cgPath
        }
        
        CATransaction.commit()
    }
    
    //MARK: - Animation Setup
    
    func addSelectAnimation(completionBlock: ((_ finished: Bool) -> Void)? = nil){
        if completionBlock != nil{
            let completionAnim = CABasicAnimation(keyPath:"completionAnim")
            completionAnim.duration = 0.566
            completionAnim.delegate = self
            completionAnim.setValue("select", forKey:"animId")
            completionAnim.setValue(false, forKey:"needEndAnim")
            layer.add(completionAnim, forKey:"select")
            if let anim = layer.animation(forKey: "select"){
                completionBlocks[anim] = completionBlock
            }
        }
        
        let fillMode : String = CAMediaTimingFillMode.forwards.rawValue
        
        let client_a = layers["client_a"]!
        
        ////Client_a animation
        let client_aTransformAnim      = CAKeyframeAnimation(keyPath:"transform")
        client_aTransformAnim.values   = [NSValue(caTransform3D: CATransform3DMakeScale(0.9, 0.9, 1)),
                                          NSValue(caTransform3D: CATransform3DIdentity)]
        client_aTransformAnim.keyTimes = [0, 1]
        client_aTransformAnim.duration = 0.4
        
        let client_aSelectAnim : CAAnimationGroup = QCMethod.group(animations: [client_aTransformAnim], fillMode:fillMode)
        client_a.add(client_aSelectAnim, forKey:"client_aSelectAnim")
        
        ////Path animation
        let pathStrokeStartAnim            = CAKeyframeAnimation(keyPath:"strokeStart")
        pathStrokeStartAnim.values         = [1, 0]
        pathStrokeStartAnim.keyTimes       = [0, 1]
        pathStrokeStartAnim.duration       = 0.4
        pathStrokeStartAnim.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeIn)
        
        let pathSelectAnim : CAAnimationGroup = QCMethod.group(animations: [pathStrokeStartAnim], fillMode:fillMode)
        layers["path"]?.add(pathSelectAnim, forKey:"pathSelectAnim")
        
        ////Ellipse_2_копия_ animation
        let Ellipse_2_копия_FillColorAnim      = CAKeyframeAnimation(keyPath:"fillColor")
        Ellipse_2_копия_FillColorAnim.values   = [self.gray.cgColor,
                                                       UIColor(red:0.316, green: 0.266, blue:0.371, alpha:1).cgColor]
        Ellipse_2_копия_FillColorAnim.keyTimes = [0, 1]
        Ellipse_2_копия_FillColorAnim.duration = 0.4
        
        let Ellipse_2_копия_SelectAnim : CAAnimationGroup = QCMethod.group(animations: [Ellipse_2_копия_FillColorAnim], fillMode:fillMode)
        layers["Ellipse_2_копия_"]?.add(Ellipse_2_копия_SelectAnim, forKey:"Ellipse_2_копия_SelectAnim")
        
        ////LeftEye animation
        let leftEyeFillColorAnim      = CAKeyframeAnimation(keyPath:"fillColor")
        leftEyeFillColorAnim.values   = [UIColor(red:0.754, green: 0.754, blue:0.754, alpha:1).cgColor,
                                         UIColor(red:0.316, green: 0.266, blue:0.371, alpha:1).cgColor]
        leftEyeFillColorAnim.keyTimes = [0, 1]
        leftEyeFillColorAnim.duration = 0.4
        
        let leftEye = layers["leftEye"] as! CAShapeLayer
        
        let leftEyeTransformAnim      = CAKeyframeAnimation(keyPath:"transform.rotation.z")
        leftEyeTransformAnim.values   = [0,
                                         30 * CGFloat.pi/180,
                                         0]
        leftEyeTransformAnim.keyTimes = [0, 0.495, 1]
        leftEyeTransformAnim.duration = 0.566
        
        let leftEyeSelectAnim : CAAnimationGroup = QCMethod.group(animations: [leftEyeFillColorAnim, leftEyeTransformAnim], fillMode:fillMode)
        leftEye.add(leftEyeSelectAnim, forKey:"leftEyeSelectAnim")
        
        ////Ellipse_2_копия_3 animation
        let Ellipse_2_копия_3FillColorAnim    = CAKeyframeAnimation(keyPath:"fillColor")
        Ellipse_2_копия_3FillColorAnim.values = [self.extraDarkGray.cgColor,
                                                      UIColor(red:0.848, green: 0.43, blue:0.415, alpha:1).cgColor]
        Ellipse_2_копия_3FillColorAnim.keyTimes = [0, 1]
        Ellipse_2_копия_3FillColorAnim.duration = 0.4
        
        let Ellipse_2_копия_3SelectAnim : CAAnimationGroup = QCMethod.group(animations: [Ellipse_2_копия_3FillColorAnim], fillMode:fillMode)
        layers["Ellipse_2_копия_3"]?.add(Ellipse_2_копия_3SelectAnim, forKey:"Ellipse_2_копия_3SelectAnim")
        
        ////Ellipse_2_копия_4 animation
        let Ellipse_2_копия_4FillColorAnim    = CAKeyframeAnimation(keyPath:"fillColor")
        Ellipse_2_копия_4FillColorAnim.values = [self.extraDarkGray.cgColor,
                                                      UIColor(red:0.848, green: 0.43, blue:0.415, alpha:1).cgColor]
        Ellipse_2_копия_4FillColorAnim.keyTimes = [0, 1]
        Ellipse_2_копия_4FillColorAnim.duration = 0.4
        
        let Ellipse_2_копия_4SelectAnim : CAAnimationGroup = QCMethod.group(animations: [Ellipse_2_копия_4FillColorAnim], fillMode:fillMode)
        layers["Ellipse_2_копия_4"]?.add(Ellipse_2_копия_4SelectAnim, forKey:"Ellipse_2_копия_4SelectAnim")
        
        ////RightEye animation
        let rightEyeFillColorAnim      = CAKeyframeAnimation(keyPath:"fillColor")
        rightEyeFillColorAnim.values   = [self.darkGray.cgColor,
                                          UIColor(red:0.316, green: 0.266, blue:0.371, alpha:1).cgColor]
        rightEyeFillColorAnim.keyTimes = [0, 1]
        rightEyeFillColorAnim.duration = 0.4
        
        let rightEye = layers["rightEye"] as! CAShapeLayer
        
        let rightEyeTransformAnim      = CAKeyframeAnimation(keyPath:"transform.rotation.z")
        rightEyeTransformAnim.values   = [0,
                                          30 * CGFloat.pi/180,
                                          0]
        rightEyeTransformAnim.keyTimes = [0, 0.495, 1]
        rightEyeTransformAnim.duration = 0.566
        
        let rightEyeSelectAnim : CAAnimationGroup = QCMethod.group(animations: [rightEyeFillColorAnim, rightEyeTransformAnim], fillMode:fillMode)
        rightEye.add(rightEyeSelectAnim, forKey:"rightEyeSelectAnim")
        
        ////CombinedShape animation
        let CombinedShapeFillColorAnim      = CAKeyframeAnimation(keyPath:"fillColor")
        CombinedShapeFillColorAnim.values   = [self.extraDarkGray.cgColor,
                                               UIColor(red:0.848, green: 0.43, blue:0.415, alpha:1).cgColor]
        CombinedShapeFillColorAnim.keyTimes = [0, 1]
        CombinedShapeFillColorAnim.duration = 0.4
        
        let CombinedShapeSelectAnim : CAAnimationGroup = QCMethod.group(animations: [CombinedShapeFillColorAnim], fillMode:fillMode)
        layers["CombinedShape"]?.add(CombinedShapeSelectAnim, forKey:"CombinedShapeSelectAnim")
        
        ////Ellipse_2_копия_5 animation
        let Ellipse_2_копия_5FillColorAnim    = CAKeyframeAnimation(keyPath:"fillColor")
        Ellipse_2_копия_5FillColorAnim.values = [self.gray.cgColor,
                                                      UIColor(red:0.316, green: 0.266, blue:0.371, alpha:1).cgColor]
        Ellipse_2_копия_5FillColorAnim.keyTimes = [0, 1]
        Ellipse_2_копия_5FillColorAnim.duration = 0.4
        
        let Ellipse_2_копия_5SelectAnim : CAAnimationGroup = QCMethod.group(animations: [Ellipse_2_копия_5FillColorAnim], fillMode:fillMode)
        layers["Ellipse_2_копия_5"]?.add(Ellipse_2_копия_5SelectAnim, forKey:"Ellipse_2_копия_5SelectAnim")
    }
    
    func addDeselectAnimation(completionBlock: ((_ finished: Bool) -> Void)? = nil){
        if completionBlock != nil{
            let completionAnim = CABasicAnimation(keyPath:"completionAnim")
            completionAnim.duration = 0.309
            completionAnim.delegate = self
            completionAnim.setValue("deselect", forKey:"animId")
            completionAnim.setValue(false, forKey:"needEndAnim")
            layer.add(completionAnim, forKey:"deselect")
            if let anim = layer.animation(forKey: "deselect"){
                completionBlocks[anim] = completionBlock
            }
        }
        
        let fillMode : String = CAMediaTimingFillMode.forwards.rawValue
        
        let client_a = layers["client_a"]!
        
        ////Client_a animation
        let client_aTransformAnim      = CAKeyframeAnimation(keyPath:"transform")
        client_aTransformAnim.values   = [NSValue(caTransform3D: CATransform3DIdentity),
                                          NSValue(caTransform3D: CATransform3DMakeScale(0.9, 0.9, 1))]
        client_aTransformAnim.keyTimes = [0, 1]
        client_aTransformAnim.duration = 0.3
        
        let client_aDeselectAnim : CAAnimationGroup = QCMethod.group(animations: [client_aTransformAnim], fillMode:fillMode)
        client_a.add(client_aDeselectAnim, forKey:"client_aDeselectAnim")
        
        ////Path animation
        let pathStrokeStartAnim            = CAKeyframeAnimation(keyPath:"strokeStart")
        pathStrokeStartAnim.values         = [0, 1]
        pathStrokeStartAnim.keyTimes       = [0, 1]
        pathStrokeStartAnim.duration       = 0.3
        pathStrokeStartAnim.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeOut)
        
        let pathDeselectAnim : CAAnimationGroup = QCMethod.group(animations: [pathStrokeStartAnim], fillMode:fillMode)
        layers["path"]?.add(pathDeselectAnim, forKey:"pathDeselectAnim")
        
        ////Ellipse_2_копия_ animation
        let Ellipse_2_копия_FillColorAnim      = CAKeyframeAnimation(keyPath:"fillColor")
        Ellipse_2_копия_FillColorAnim.values   = [UIColor(red:0.316, green: 0.266, blue:0.371, alpha:1).cgColor,
                                                       self.gray.cgColor]
        Ellipse_2_копия_FillColorAnim.keyTimes = [0, 1]
        Ellipse_2_копия_FillColorAnim.duration = 0.3
        
        let Ellipse_2_копия_DeselectAnim : CAAnimationGroup = QCMethod.group(animations: [Ellipse_2_копия_FillColorAnim], fillMode:fillMode)
        layers["Ellipse_2_копия_"]?.add(Ellipse_2_копия_DeselectAnim, forKey:"Ellipse_2_копия_DeselectAnim")
        
        ////LeftEye animation
        let leftEyeFillColorAnim      = CAKeyframeAnimation(keyPath:"fillColor")
        leftEyeFillColorAnim.values   = [UIColor(red:0.316, green: 0.266, blue:0.371, alpha:1).cgColor,
                                         self.darkGray.cgColor]
        leftEyeFillColorAnim.keyTimes = [0, 1]
        leftEyeFillColorAnim.duration = 0.3
        
        let leftEyeDeselectAnim : CAAnimationGroup = QCMethod.group(animations: [leftEyeFillColorAnim], fillMode:fillMode)
        layers["leftEye"]?.add(leftEyeDeselectAnim, forKey:"leftEyeDeselectAnim")
        
        ////Ellipse_2_копия_3 animation
        let Ellipse_2_копия_3FillColorAnim    = CAKeyframeAnimation(keyPath:"fillColor")
        Ellipse_2_копия_3FillColorAnim.values = [UIColor(red:0.848, green: 0.43, blue:0.415, alpha:1).cgColor,
                                                      self.extraDarkGray.cgColor]
        Ellipse_2_копия_3FillColorAnim.keyTimes = [0, 1]
        Ellipse_2_копия_3FillColorAnim.duration = 0.3
        
        let Ellipse_2_копия_3DeselectAnim : CAAnimationGroup = QCMethod.group(animations: [Ellipse_2_копия_3FillColorAnim], fillMode:fillMode)
        layers["Ellipse_2_копия_3"]?.add(Ellipse_2_копия_3DeselectAnim, forKey:"Ellipse_2_копия_3DeselectAnim")
        
        ////Ellipse_2_копия_4 animation
        let Ellipse_2_копия_4FillColorAnim    = CAKeyframeAnimation(keyPath:"fillColor")
        Ellipse_2_копия_4FillColorAnim.values = [UIColor(red:0.848, green: 0.43, blue:0.415, alpha:1).cgColor,
                                                      self.extraDarkGray.cgColor]
        Ellipse_2_копия_4FillColorAnim.keyTimes = [0, 1]
        Ellipse_2_копия_4FillColorAnim.duration = 0.3
        
        let Ellipse_2_копия_4DeselectAnim : CAAnimationGroup = QCMethod.group(animations: [Ellipse_2_копия_4FillColorAnim], fillMode:fillMode)
        layers["Ellipse_2_копия_4"]?.add(Ellipse_2_копия_4DeselectAnim, forKey:"Ellipse_2_копия_4DeselectAnim")
        
        ////RightEye animation
        let rightEyeFillColorAnim      = CAKeyframeAnimation(keyPath:"fillColor")
        rightEyeFillColorAnim.values   = [UIColor(red:0.316, green: 0.266, blue:0.371, alpha:1).cgColor,
                                          self.darkGray.cgColor]
        rightEyeFillColorAnim.keyTimes = [0, 1]
        rightEyeFillColorAnim.duration = 0.3
        
        let rightEyeDeselectAnim : CAAnimationGroup = QCMethod.group(animations: [rightEyeFillColorAnim], fillMode:fillMode)
        layers["rightEye"]?.add(rightEyeDeselectAnim, forKey:"rightEyeDeselectAnim")
        
        ////CombinedShape animation
        let CombinedShapeFillColorAnim      = CAKeyframeAnimation(keyPath:"fillColor")
        CombinedShapeFillColorAnim.values   = [UIColor(red:0.848, green: 0.43, blue:0.415, alpha:1).cgColor,
                                               self.extraDarkGray.cgColor]
        CombinedShapeFillColorAnim.keyTimes = [0, 1]
        CombinedShapeFillColorAnim.duration = 0.3
        
        let CombinedShapeDeselectAnim : CAAnimationGroup = QCMethod.group(animations: [CombinedShapeFillColorAnim], fillMode:fillMode)
        layers["CombinedShape"]?.add(CombinedShapeDeselectAnim, forKey:"CombinedShapeDeselectAnim")
        
        ////Ellipse_2_копия_5 animation
        let Ellipse_2_копия_5FillColorAnim    = CAKeyframeAnimation(keyPath:"fillColor")
        Ellipse_2_копия_5FillColorAnim.values = [UIColor(red:0.316, green: 0.266, blue:0.371, alpha:1).cgColor,
                                                      self.gray.cgColor]
        Ellipse_2_копия_5FillColorAnim.keyTimes = [0, 1]
        Ellipse_2_копия_5FillColorAnim.duration = 0.3
        
        let Ellipse_2_копия_5DeselectAnim : CAAnimationGroup = QCMethod.group(animations: [Ellipse_2_копия_5FillColorAnim], fillMode:fillMode)
        layers["Ellipse_2_копия_5"]?.add(Ellipse_2_копия_5DeselectAnim, forKey:"Ellipse_2_копия_5DeselectAnim")
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
            QCMethod.updateValueFromPresentationLayer(forAnimation: layers["client_a"]!.animation(forKey: "client_aSelectAnim"), theLayer:layers["client_a"]!)
            QCMethod.updateValueFromPresentationLayer(forAnimation: layers["path"]!.animation(forKey: "pathSelectAnim"), theLayer:layers["path"]!)
            QCMethod.updateValueFromPresentationLayer(forAnimation: layers["Ellipse_2_копия_"]!.animation(forKey: "Ellipse_2_копия_SelectAnim"), theLayer:layers["Ellipse_2_копия_"]!)
            QCMethod.updateValueFromPresentationLayer(forAnimation: layers["leftEye"]!.animation(forKey: "leftEyeSelectAnim"), theLayer:layers["leftEye"]!)
            QCMethod.updateValueFromPresentationLayer(forAnimation: layers["Ellipse_2_копия_3"]!.animation(forKey: "Ellipse_2_копия_3SelectAnim"), theLayer:layers["Ellipse_2_копия_3"]!)
            QCMethod.updateValueFromPresentationLayer(forAnimation: layers["Ellipse_2_копия_4"]!.animation(forKey: "Ellipse_2_копия_4SelectAnim"), theLayer:layers["Ellipse_2_копия_4"]!)
            QCMethod.updateValueFromPresentationLayer(forAnimation: layers["rightEye"]!.animation(forKey: "rightEyeSelectAnim"), theLayer:layers["rightEye"]!)
            QCMethod.updateValueFromPresentationLayer(forAnimation: layers["CombinedShape"]!.animation(forKey: "CombinedShapeSelectAnim"), theLayer:layers["CombinedShape"]!)
            QCMethod.updateValueFromPresentationLayer(forAnimation: layers["Ellipse_2_копия_5"]!.animation(forKey: "Ellipse_2_копия_5SelectAnim"), theLayer:layers["Ellipse_2_копия_5"]!)
        }
        else if identifier == "deselect"{
            QCMethod.updateValueFromPresentationLayer(forAnimation: layers["client_a"]!.animation(forKey: "client_aDeselectAnim"), theLayer:layers["client_a"]!)
            QCMethod.updateValueFromPresentationLayer(forAnimation: layers["path"]!.animation(forKey: "pathDeselectAnim"), theLayer:layers["path"]!)
            QCMethod.updateValueFromPresentationLayer(forAnimation: layers["Ellipse_2_копия_"]!.animation(forKey: "Ellipse_2_копия_DeselectAnim"), theLayer:layers["Ellipse_2_копия_"]!)
            QCMethod.updateValueFromPresentationLayer(forAnimation: layers["leftEye"]!.animation(forKey: "leftEyeDeselectAnim"), theLayer:layers["leftEye"]!)
            QCMethod.updateValueFromPresentationLayer(forAnimation: layers["Ellipse_2_копия_3"]!.animation(forKey: "Ellipse_2_копия_3DeselectAnim"), theLayer:layers["Ellipse_2_копия_3"]!)
            QCMethod.updateValueFromPresentationLayer(forAnimation: layers["Ellipse_2_копия_4"]!.animation(forKey: "Ellipse_2_копия_4DeselectAnim"), theLayer:layers["Ellipse_2_копия_4"]!)
            QCMethod.updateValueFromPresentationLayer(forAnimation: layers["rightEye"]!.animation(forKey: "rightEyeDeselectAnim"), theLayer:layers["rightEye"]!)
            QCMethod.updateValueFromPresentationLayer(forAnimation: layers["CombinedShape"]!.animation(forKey: "CombinedShapeDeselectAnim"), theLayer:layers["CombinedShape"]!)
            QCMethod.updateValueFromPresentationLayer(forAnimation: layers["Ellipse_2_копия_5"]!.animation(forKey: "Ellipse_2_копия_5DeselectAnim"), theLayer:layers["Ellipse_2_копия_5"]!)
        }
    }
    
    func removeAnimations(forAnimationId identifier: String){
        if identifier == "select"{
            layers["client_a"]?.removeAnimation(forKey: "client_aSelectAnim")
            layers["path"]?.removeAnimation(forKey: "pathSelectAnim")
            layers["Ellipse_2_копия_"]?.removeAnimation(forKey: "Ellipse_2_копия_SelectAnim")
            layers["leftEye"]?.removeAnimation(forKey: "leftEyeSelectAnim")
            layers["Ellipse_2_копия_3"]?.removeAnimation(forKey: "Ellipse_2_копия_3SelectAnim")
            layers["Ellipse_2_копия_4"]?.removeAnimation(forKey: "Ellipse_2_копия_4SelectAnim")
            layers["rightEye"]?.removeAnimation(forKey: "rightEyeSelectAnim")
            layers["CombinedShape"]?.removeAnimation(forKey: "CombinedShapeSelectAnim")
            layers["Ellipse_2_копия_5"]?.removeAnimation(forKey: "Ellipse_2_копия_5SelectAnim")
        }
        else if identifier == "deselect"{
            layers["client_a"]?.removeAnimation(forKey: "client_aDeselectAnim")
            layers["path"]?.removeAnimation(forKey: "pathDeselectAnim")
            layers["Ellipse_2_копия_"]?.removeAnimation(forKey: "Ellipse_2_копия_DeselectAnim")
            layers["leftEye"]?.removeAnimation(forKey: "leftEyeDeselectAnim")
            layers["Ellipse_2_копия_3"]?.removeAnimation(forKey: "Ellipse_2_копия_3DeselectAnim")
            layers["Ellipse_2_копия_4"]?.removeAnimation(forKey: "Ellipse_2_копия_4DeselectAnim")
            layers["rightEye"]?.removeAnimation(forKey: "rightEyeDeselectAnim")
            layers["CombinedShape"]?.removeAnimation(forKey: "CombinedShapeDeselectAnim")
            layers["Ellipse_2_копия_5"]?.removeAnimation(forKey: "Ellipse_2_копия_5DeselectAnim")
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
        
        Ellipse_2_копия_2Path.move(to: CGPoint(x:minX, y: minY + 0.38289 * h))
        Ellipse_2_копия_2Path.addCurve(to: CGPoint(x:minX + 0.07136 * w, y: minY + 0.14193 * h), controlPoint1:CGPoint(x:minX + -0.00013 * w, y: minY + 0.29798 * h), controlPoint2:CGPoint(x:minX + 0.02455 * w, y: minY + 0.21466 * h))
        Ellipse_2_копия_2Path.addCurve(to: CGPoint(x:minX + 0.92864 * w, y: minY + 0.14193 * h), controlPoint1:CGPoint(x:minX + 0.32136 * w, y: minY + -0.04731 * h), controlPoint2:CGPoint(x:minX + 0.67864 * w, y: minY + -0.04731 * h))
        Ellipse_2_копия_2Path.addCurve(to: CGPoint(x:minX + 0.97054 * w, y: minY + 0.54116 * h), controlPoint1:CGPoint(x:minX + 1.00592 * w, y: minY + 0.26237 * h), controlPoint2:CGPoint(x:minX + 1.0213 * w, y: minY + 0.40894 * h))
        Ellipse_2_копия_2Path.addCurve(to: CGPoint(x:minX + 0.66673 * w, y: minY + 0.82411 * h), controlPoint1:CGPoint(x:minX + 0.91978 * w, y: minY + 0.67338 * h), controlPoint2:CGPoint(x:minX + 0.80824 * w, y: minY + 0.77726 * h))
        Ellipse_2_копия_2Path.addCurve(to: CGPoint(x:minX + 0.66818 * w, y: minY + 0.84449 * h), controlPoint1:CGPoint(x:minX + 0.66767 * w, y: minY + 0.83087 * h), controlPoint2:CGPoint(x:minX + 0.66816 * w, y: minY + 0.83768 * h))
        Ellipse_2_копия_2Path.addCurve(to: CGPoint(x:minX + 0.57936 * w, y: minY + 0.98222 * h), controlPoint1:CGPoint(x:minX + 0.66827 * w, y: minY + 0.9023 * h), controlPoint2:CGPoint(x:minX + 0.63405 * w, y: minY + 0.95536 * h))
        Ellipse_2_копия_2Path.addCurve(to: CGPoint(x:minX + 0.40781 * w, y: minY + 0.97237 * h), controlPoint1:CGPoint(x:minX + 0.52468 * w, y: minY + 1.00908 * h), controlPoint2:CGPoint(x:minX + 0.45858 * w, y: minY + 1.00528 * h))
        Ellipse_2_копия_2Path.addCurve(to: CGPoint(x:minX + 0.33764 * w, y: minY + 0.82552 * h), controlPoint1:CGPoint(x:minX + 0.35704 * w, y: minY + 0.93946 * h), controlPoint2:CGPoint(x:minX + 0.33 * w, y: minY + 0.88288 * h))
        Ellipse_2_копия_2Path.addCurve(to: CGPoint(x:minX, y: minY + 0.38289 * h), controlPoint1:CGPoint(x:minX + 0.13567 * w, y: minY + 0.76057 * h), controlPoint2:CGPoint(x:minX + 0.00005 * w, y: minY + 0.58277 * h))
        Ellipse_2_копия_2Path.addLine(to: CGPoint(x:minX, y: minY + 0.38289 * h))
        Ellipse_2_копия_2Path.close()
        Ellipse_2_копия_2Path.move(to: CGPoint(x:minX, y: minY + 0.38289 * h))
        
        return Ellipse_2_копия_2Path
    }
    
    func leftEyePath(bounds: CGRect) -> UIBezierPath{
        let leftEyePath = UIBezierPath()
        let minX = CGFloat(bounds.minX), minY = bounds.minY, w = bounds.width, h = bounds.height;
        
        leftEyePath.move(to: CGPoint(x:minX + 0.92211 * w, y: minY + 0.23189 * h))
        leftEyePath.addCurve(to: CGPoint(x:minX + w, y: minY + 0.5 * h), controlPoint1:CGPoint(x:minX + 0.97143 * w, y: minY + 0.30937 * h), controlPoint2:CGPoint(x:minX + w, y: minY + 0.40135 * h))
        leftEyePath.addCurve(to: CGPoint(x:minX + 0.5 * w, y: minY + h), controlPoint1:CGPoint(x:minX + w, y: minY + 0.77614 * h), controlPoint2:CGPoint(x:minX + 0.77614 * w, y: minY + h))
        leftEyePath.addCurve(to: CGPoint(x:minX, y: minY + 0.5 * h), controlPoint1:CGPoint(x:minX + 0.22386 * w, y: minY + h), controlPoint2:CGPoint(x:minX, y: minY + 0.77614 * h))
        leftEyePath.addCurve(to: CGPoint(x:minX + 0.5 * w, y: minY), controlPoint1:CGPoint(x:minX, y: minY + 0.22386 * h), controlPoint2:CGPoint(x:minX + 0.22386 * w, y: minY))
        leftEyePath.addCurve(to: CGPoint(x:minX + 0.62887 * w, y: minY + 0.01676 * h), controlPoint1:CGPoint(x:minX + 0.54456 * w, y: minY), controlPoint2:CGPoint(x:minX + 0.58775 * w, y: minY + 0.00583 * h))
        leftEyePath.addCurve(to: CGPoint(x:minX + 0.5 * w, y: minY + 0.21154 * h), controlPoint1:CGPoint(x:minX + 0.55312 * w, y: minY + 0.04896 * h), controlPoint2:CGPoint(x:minX + 0.5 * w, y: minY + 0.12404 * h))
        leftEyePath.addCurve(to: CGPoint(x:minX + 0.71154 * w, y: minY + 0.42308 * h), controlPoint1:CGPoint(x:minX + 0.5 * w, y: minY + 0.32837 * h), controlPoint2:CGPoint(x:minX + 0.59471 * w, y: minY + 0.42308 * h))
        leftEyePath.addCurve(to: CGPoint(x:minX + 0.92211 * w, y: minY + 0.23189 * h), controlPoint1:CGPoint(x:minX + 0.8215 * w, y: minY + 0.42308 * h), controlPoint2:CGPoint(x:minX + 0.91187 * w, y: minY + 0.33917 * h))
        leftEyePath.close()
        leftEyePath.move(to: CGPoint(x:minX + 0.92211 * w, y: minY + 0.23189 * h))
        
        return leftEyePath
    }
    
    func Ellipse_2_копия_3Path(bounds: CGRect) -> UIBezierPath{
        let Ellipse_2_копия_3Path = UIBezierPath()
        let minX = CGFloat(bounds.minX), minY = bounds.minY, w = bounds.width, h = bounds.height;
        
        Ellipse_2_копия_3Path.move(to: CGPoint(x:minX + w, y: minY + 0.5 * h))
        Ellipse_2_копия_3Path.addCurve(to: CGPoint(x:minX + 0.5 * w, y: minY + h), controlPoint1:CGPoint(x:minX + w, y: minY + 0.77614 * h), controlPoint2:CGPoint(x:minX + 0.77614 * w, y: minY + h))
        Ellipse_2_копия_3Path.addCurve(to: CGPoint(x:minX, y: minY + 0.5 * h), controlPoint1:CGPoint(x:minX + 0.22386 * w, y: minY + h), controlPoint2:CGPoint(x:minX, y: minY + 0.77614 * h))
        Ellipse_2_копия_3Path.addCurve(to: CGPoint(x:minX + 0.5 * w, y: minY), controlPoint1:CGPoint(x:minX, y: minY + 0.22386 * h), controlPoint2:CGPoint(x:minX + 0.22386 * w, y: minY))
        Ellipse_2_копия_3Path.addCurve(to: CGPoint(x:minX + w, y: minY + 0.5 * h), controlPoint1:CGPoint(x:minX + 0.77614 * w, y: minY), controlPoint2:CGPoint(x:minX + w, y: minY + 0.22386 * h))
        Ellipse_2_копия_3Path.close()
        Ellipse_2_копия_3Path.move(to: CGPoint(x:minX + w, y: minY + 0.5 * h))
        
        return Ellipse_2_копия_3Path
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
    
    func rightEyePath(bounds: CGRect) -> UIBezierPath{
        let rightEyePath = UIBezierPath()
        let minX = CGFloat(bounds.minX), minY = bounds.minY, w = bounds.width, h = bounds.height;
        
        rightEyePath.move(to: CGPoint(x:minX + 0.92211 * w, y: minY + 0.23189 * h))
        rightEyePath.addCurve(to: CGPoint(x:minX + w, y: minY + 0.5 * h), controlPoint1:CGPoint(x:minX + 0.97143 * w, y: minY + 0.30937 * h), controlPoint2:CGPoint(x:minX + w, y: minY + 0.40135 * h))
        rightEyePath.addCurve(to: CGPoint(x:minX + 0.5 * w, y: minY + h), controlPoint1:CGPoint(x:minX + w, y: minY + 0.77614 * h), controlPoint2:CGPoint(x:minX + 0.77614 * w, y: minY + h))
        rightEyePath.addCurve(to: CGPoint(x:minX, y: minY + 0.5 * h), controlPoint1:CGPoint(x:minX + 0.22386 * w, y: minY + h), controlPoint2:CGPoint(x:minX, y: minY + 0.77614 * h))
        rightEyePath.addCurve(to: CGPoint(x:minX + 0.5 * w, y: minY), controlPoint1:CGPoint(x:minX, y: minY + 0.22386 * h), controlPoint2:CGPoint(x:minX + 0.22386 * w, y: minY))
        rightEyePath.addCurve(to: CGPoint(x:minX + 0.62887 * w, y: minY + 0.01676 * h), controlPoint1:CGPoint(x:minX + 0.54456 * w, y: minY), controlPoint2:CGPoint(x:minX + 0.58775 * w, y: minY + 0.00583 * h))
        rightEyePath.addCurve(to: CGPoint(x:minX + 0.5 * w, y: minY + 0.21154 * h), controlPoint1:CGPoint(x:minX + 0.55312 * w, y: minY + 0.04896 * h), controlPoint2:CGPoint(x:minX + 0.5 * w, y: minY + 0.12404 * h))
        rightEyePath.addCurve(to: CGPoint(x:minX + 0.71154 * w, y: minY + 0.42308 * h), controlPoint1:CGPoint(x:minX + 0.5 * w, y: minY + 0.32837 * h), controlPoint2:CGPoint(x:minX + 0.59471 * w, y: minY + 0.42308 * h))
        rightEyePath.addCurve(to: CGPoint(x:minX + 0.92211 * w, y: minY + 0.23189 * h), controlPoint1:CGPoint(x:minX + 0.8215 * w, y: minY + 0.42308 * h), controlPoint2:CGPoint(x:minX + 0.91187 * w, y: minY + 0.33917 * h))
        rightEyePath.close()
        rightEyePath.move(to: CGPoint(x:minX + 0.92211 * w, y: minY + 0.23189 * h))
        
        return rightEyePath
    }
    
    func CombinedShapePath(bounds: CGRect) -> UIBezierPath{
        let CombinedShapePath = UIBezierPath()
        let minX = CGFloat(bounds.minX), minY = bounds.minY, w = bounds.width, h = bounds.height;
        
        CombinedShapePath.move(to: CGPoint(x:minX + 0.97176 * w, y: minY))
        CombinedShapePath.addCurve(to: CGPoint(x:minX + 0.85467 * w, y: minY + 0.77827 * h), controlPoint1:CGPoint(x:minX + 1.035 * w, y: minY + 0.27037 * h), controlPoint2:CGPoint(x:minX + 0.99035 * w, y: minY + 0.57313 * h))
        CombinedShapePath.addCurve(to: CGPoint(x:minX + 0.30939 * w, y: minY + 0.94325 * h), controlPoint1:CGPoint(x:minX + 0.71192 * w, y: minY + 0.9941 * h), controlPoint2:CGPoint(x:minX + 0.49661 * w, y: minY + 1.05924 * h))
        CombinedShapePath.addCurve(to: CGPoint(x:minX + 0 * w, y: minY + 0.2488 * h), controlPoint1:CGPoint(x:minX + 0.12216 * w, y: minY + 0.82727 * h), controlPoint2:CGPoint(x:minX + -0 * w, y: minY + 0.55306 * h))
        CombinedShapePath.addCurve(to: CGPoint(x:minX + 0.02469 * w, y: minY + 0.01355 * h), controlPoint1:CGPoint(x:minX + -0.00018 * w, y: minY + 0.16815 * h), controlPoint2:CGPoint(x:minX + 0.00831 * w, y: minY + 0.0888 * h))
        CombinedShapePath.addCurve(to: CGPoint(x:minX + 0.49679 * w, y: minY + 0.52689 * h), controlPoint1:CGPoint(x:minX + 0.08984 * w, y: minY + 0.31164 * h), controlPoint2:CGPoint(x:minX + 0.27658 * w, y: minY + 0.52689 * h))
        CombinedShapePath.addCurve(to: CGPoint(x:minX + 0.97176 * w, y: minY), controlPoint1:CGPoint(x:minX + 0.72033 * w, y: minY + 0.52689 * h), controlPoint2:CGPoint(x:minX + 0.90938 * w, y: minY + 0.3051 * h))
        CombinedShapePath.close()
        CombinedShapePath.move(to: CGPoint(x:minX + 0.97176 * w, y: minY))
        
        return CombinedShapePath
    }
    
    func Ellipse_2_копия_5Path(bounds: CGRect) -> UIBezierPath{
        let Ellipse_2_копия_5Path = UIBezierPath()
        let minX = CGFloat(bounds.minX), minY = bounds.minY, w = bounds.width, h = bounds.height;
        
        Ellipse_2_копия_5Path.move(to: CGPoint(x:minX + 0.97144 * w, y: minY + 0.0989 * h))
        Ellipse_2_копия_5Path.addCurve(to: CGPoint(x:minX + 0.79867 * w, y: minY + 0.86612 * h), controlPoint1:CGPoint(x:minX + 1.04438 * w, y: minY + 0.3782 * h), controlPoint2:CGPoint(x:minX + 0.97435 * w, y: minY + 0.68918 * h))
        Ellipse_2_копия_5Path.addCurve(to: CGPoint(x:minX + 0.20554 * w, y: minY + 0.87031 * h), controlPoint1:CGPoint(x:minX + 0.62299 * w, y: minY + 1.04307 * h), controlPoint2:CGPoint(x:minX + 0.38257 * w, y: minY + 1.04476 * h))
        Ellipse_2_копия_5Path.addCurve(to: CGPoint(x:minX + 0.02685 * w, y: minY + 0.10557 * h), controlPoint1:CGPoint(x:minX + 0.0285 * w, y: minY + 0.69586 * h), controlPoint2:CGPoint(x:minX + -0.04393 * w, y: minY + 0.38589 * h))
        Ellipse_2_копия_5Path.addCurve(to: CGPoint(x:minX + 0.97144 * w, y: minY + 0.0989 * h), controlPoint1:CGPoint(x:minX + 0.33312 * w, y: minY + -0.03287 * h), controlPoint2:CGPoint(x:minX + 0.66412 * w, y: minY + -0.03521 * h))
        Ellipse_2_копия_5Path.addLine(to: CGPoint(x:minX + 0.97144 * w, y: minY + 0.0989 * h))
        Ellipse_2_копия_5Path.close()
        Ellipse_2_копия_5Path.move(to: CGPoint(x:minX + 0.97144 * w, y: minY + 0.0989 * h))
        
        return Ellipse_2_копия_5Path
    }
    
    
}
