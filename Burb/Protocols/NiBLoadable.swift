//
//  NiBLoadable.swift
//  Burb
//
//  Created by Eugene on 30/09/2019.
//  Copyright © 2019 CC_Eugene. All rights reserved.
//

import UIKit

protocol NiBLoadable: class {
    
    static var nib: UINib { get }
    
}

extension NiBLoadable {
    
    static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: Bundle.init(for: self))
    }
    
    static var name: String {
        return String(describing: self)
    }
}


extension NiBLoadable where Self: UIView {
    static func loadFromNib() -> Self {
        guard let view = nib.instantiate(withOwner: nil, options: nil).first as? Self else {
            fatalError()
        }
        return view
    }
}
