//
//  PricingModel.swift
//  Burb
//
//  Created by Eugene on 25.03.2020.
//  Copyright © 2020 CC_Eugene. All rights reserved.
//
import UIKit

class PricingModel {
   
    var curency: Curency?
    var haircut: Int?
    var beardHaircur: Int?
    var babyHaircut: Int?
    var dangerousShave: Int?
    var clipper: Int?
    var stacking: Int?
    
    var pricingIsFilled: Bool {
        
      guard curency != nil,
            haircut != nil,
            beardHaircur != nil,
            babyHaircut != nil,
            dangerousShave != nil,
            clipper != nil,
            stacking != nil else {
            return false
        }
        return true
    }
    
    
    init(curency: Curency, haircut: Int,beardHaircur: Int, babyHaircut: Int, dangerousShave: Int, clipper: Int, stacking: Int) {
        
        self.curency = curency
        
        self.haircut = haircut
        self.beardHaircur = beardHaircur
        self.babyHaircut = babyHaircut
        self.dangerousShave = dangerousShave
        self.clipper = clipper
        self.stacking = stacking
    }
}
