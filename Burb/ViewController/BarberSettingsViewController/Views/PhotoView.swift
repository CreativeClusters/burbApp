//
//  PhotoView.swift
//  Burb
//
//  Created by Eugene on 30/09/2019.
//  Copyright © 2019 CC_Eugene. All rights reserved.
//

import UIKit

final class PhotoView: UIView {

    @IBOutlet weak var imageView: UIImageView!
    
     func didMoveToSuperView() {
        super.didMoveToSuperview()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        Decorator.decorate(self)
    }
}

extension PhotoView {
    
    fileprivate final class Decorator {
        static func decorate(_ view: PhotoView) {
            view.layer.borderColor = burbColor.cgColor
            view.layer.borderWidth = 2
            view.round(view: view)
        }
        
        static func layotSubviews(_ view: PhotoView) {
        }
    }
}
