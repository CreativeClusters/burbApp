//
//  PhotoView.swift
//  Burb
//
//  Created by Eugene on 09.04.2020.
//  Copyright © 2020 CC_Eugene. All rights reserved.
//

import UIKit

class PhotoView: UIView, NiBLoadable {

    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var plusImageView: UIImageView!
    
    
    
    var clicked: VoidClosure?

    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        addPlusView()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        clicked?()
    }
    
    func set(image: UIImage?) {
        imageView.image = image
        plusImageView.isHidden = image == nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        Decorator.layoutSubviews(self)
    }
    
    private func addPlusView() {
        if let image = UIImage(named: "add_512.png") {
        plusImageView.image = image
        }
    }
    
}

extension PhotoView {
    fileprivate final class Decorator {
        static func decorate(_ view: PhotoView) {

        }
        
        
        static func layoutSubviews(_ view: PhotoView) {
            
        }
    }
    
}
