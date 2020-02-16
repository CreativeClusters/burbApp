//
//  Extension+String.swift
//  Burb
//
//  Created by Eugene on 27.01.2020.
//  Copyright © 2020 CC_Eugene. All rights reserved.
//

import UIKit

extension String {
    
    func length() -> Int {
        return self.count
    }
    
    func matchPattern(_ patStr:String)->Bool {
        var isMatch:Bool = false
        do {
            let regex = try NSRegularExpression(pattern: patStr, options: [.caseInsensitive])
            let result = regex.firstMatch(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, count))
            
            if (result != nil) {
                isMatch = true
            }
        }
        catch {
            isMatch = false
        }
        return isMatch
    }
    
    static func correctSuffix(_ forValue: Int, first: String, second: String, third: String) -> String {
        if forValue > 10 && forValue <= 20
        {
            return third
        }
        let lastDigit = forValue % 10
        if lastDigit == 1
        {
            return first
        }
        else if lastDigit >= 2 && lastDigit <= 4
        {
            return second
        }
        return third
    }
    
    static func correctString(_ forValue: Int, first: String, second: String, third: String) -> String {
        return String(forValue) + " " + self.correctSuffix(forValue, first: first, second: second, third: third)
    }
    
    func isNumber() -> Bool {
        let numberCharacters = CharacterSet.decimalDigits.inverted
        return !self.isEmpty && self.rangeOfCharacter(from:numberCharacters) == nil
    }
    
    func size(_ withFont: UIFont, constrainedToSize: CGSize = CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)) -> CGSize {
        let attString = NSAttributedString(string: self, attributes: [NSAttributedString.Key.font : withFont])
        let rect = attString.boundingRect(with: constrainedToSize,
                                          options: .usesLineFragmentOrigin,
                                          context: nil)
        return CGSize(width: ceil(rect.width), height: ceil(rect.height))
    }
    
    func toDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH-mm"
        return dateFormatter.date(from: self) ?? nil
    }
    
    func firstCharacterUpperCase() -> String {
        if let firstCharacter = String(self).first
        {
            return replacingCharacters(in: startIndex..<index(after: startIndex), with: String(firstCharacter).uppercased())
        }
        return ""
    }
    
    func clearPredicate() -> String {
        var newString = self.replacingOccurrences(of: "[", with: "(")
        newString = newString.replacingOccurrences(of: "]", with: ")")
        newString = newString.replacingOccurrences(of: "\"", with: "'")
        return newString
    }
    
    func deletingPrefix(_ prefix: String?) -> String {
        guard let prefix = prefix, self.hasPrefix(prefix) else {return self}
        return String(self.dropFirst(prefix.count))
    }
}

extension NSAttributedString {
    func height(withConstrainedWidth width: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, context: nil)
        
        return ceil(boundingBox.height)
    }
    
    func width(withConstrainedHeight height: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, context: nil)
        
        return ceil(boundingBox.width)
    }
}
