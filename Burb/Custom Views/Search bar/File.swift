//
//  File.swift
//  Burb
//
//  Created by Eugene on 26.03.2020.
//  Copyright © 2020 CC_Eugene. All rights reserved.
//

import UIKit

class BUSearchBar: UISearchBar {
    
    var backgroundTextFieldColor: UIColor?
    
    internal lazy var searchTF: UITextField? = { [unowned self] in
        var textField: UITextField?
        self.subviews.forEach({ view in
            view.subviews.forEach({ view in
                if let view = view as? UITextField {
                    textField = view
                }
            })
        })
        return textField
    }()
    
    private func changeTextFieldBackgroundColor()
    {
        if let bgColor = backgroundTextFieldColor, let textField = self.searchTF
        {
            textField.backgroundColor = bgColor
        }
    }
    
    override func removeFromSuperview() {
        super.removeFromSuperview()
    }
    
    override func willMove(toWindow newWindow: UIWindow?) {
        super.willMove(toWindow: newWindow)
        changeTextFieldBackgroundColor()
    }
    
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        changeTextFieldBackgroundColor()
    }
}
