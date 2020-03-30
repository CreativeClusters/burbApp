//
//  Extension+TextView.swift
//  Burb
//
//  Created by Eugene on 27.02.2020.
//  Copyright © 2020 CC_Eugene. All rights reserved.
//

import UIKit

extension UITextView: UITextViewDelegate {
    
    override open var bounds: CGRect {
        didSet {
            self.resizePlaceholder()
        }
    }
    
    
    var placeholder: String? {
        get {
            var placeholderText: String?
            
            if let placeholderLabel = self.viewWithTag(100) as? UILabel {
                placeholderText = placeholderLabel.text
            }
            return placeholderText
        }
        set {
            if let placeholderLabel = self.viewWithTag(100) as! UILabel? {
                placeholderLabel.text = newValue
                placeholderLabel.sizeToFit()
            } else {
                self.addPlaceholder(newValue!)
        }
    }
}

    public func textViewDidChange(_ textView: UITextView) {
        if let placeholderLabel = self.viewWithTag(100) as? UILabel {
            placeholderLabel.isHidden = self.text.count > 0
        }
    }
}


private extension UITextView {
    
    func resizePlaceholder() {
        if let placeholderLabel = self.viewWithTag(100) as! UILabel? {
            let labelX = self.textContainer.lineFragmentPadding
            let labelY = self.textContainerInset.top - 2
            let labelWidth = self.frame.width - (labelX * 2)
            let labelHeight = placeholderLabel.frame.height
            
            placeholderLabel.frame = CGRect(x: labelX, y: labelY, width: labelWidth, height: labelHeight)
        }
    }
    
    func addPlaceholder(_ placeholderText: String) {
        let placegolderLabel = UILabel()
        
        placegolderLabel.text = placeholderText
        placegolderLabel.sizeToFit()
        
        placegolderLabel.font = self.font
        placegolderLabel.textColor = UIColor.lightGray
        placegolderLabel.tag = 100
        
        placegolderLabel.isHidden = self.text.count > 0
        
        self.addSubview(placegolderLabel)
        self.resizePlaceholder()
        self.delegate = self
        
    }
    
    
}
