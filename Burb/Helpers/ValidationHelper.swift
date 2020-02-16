//
//  ValidationHelper.swift
//  Burb
//
//  Created by Eugene on 27.01.2020.
//  Copyright © 2020 CC_Eugene. All rights reserved.
//

import Foundation

class ValidationHelper {
    
    class func isLogin(_ str : String)->Bool {
        
        if (str.matchPattern("^[A-Z0-9]{0,16}$") == true) {
            return true
        } else {
            return false
        }
    }
    
    class func isNumber(_ str : String)->Bool {
        
        if (str.matchPattern("^[0-9]{0,1}$") == true) {
            return true
        } else {
            return false
        }
    }
    
    class func isAge(_ str : String)->Bool {
        
        if (str.matchPattern("^[0-9]{0,1}$") == true) {
            return true
        } else {
            return false
        }
    }
    
    class func isEmail(_ str : String)->Bool {
        
        if (str.matchPattern("^[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,4}$") == true) {
            return true
        } else {
            return false
        }
    }
    
    class func isPassword(_ str : String)->Bool {
        if (str.matchPattern("^[A-Z0-9]{0,16}$") == true) {
            return true
        } else {
            return false
        }
    }
    
    class func isName(_ str : String)->Bool {
        if (str.matchPattern("^[A-ZА-Я0-9 ]{0,16}$") == true) {
            return true
        } else {
            return false
        }
    }
}
