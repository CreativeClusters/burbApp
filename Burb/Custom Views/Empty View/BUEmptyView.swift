//
//  BUEmptyView.swift
//  Burb
//
//  Created by Eugene on 23.03.2020.
//  Copyright © 2020 CC_Eugene. All rights reserved.
//

import UIKit

enum BUEmptyViewType {
    case unknown
    case inboxOrders
    case acceptedOrders
}

class BUEmptyView: UIView {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descTextView: UITextView!
    
    private var type: BUEmptyViewType = .unknown
    private var imageURL: String?
    
    var distanceToImage: CGFloat = 120
    var distanceBetweenImageAndText: CGFloat = 20
    
    
    convenience init(frame: CGRect, type: BUEmptyViewType) {
        self.init(frame: frame)
        self.type = type
        handlerType()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    private func handlerType() {
        switch self.type {
        case .unknown:
            imageView.image = UIImage(named: "")
            titleLabel.text = ""
            descTextView.text = ""
        case .inboxOrders:
            imageView.image = UIImage(named: "")
            titleLabel.text = ""
            descTextView.text = ""
        case .acceptedOrders:
            imageView.image = UIImage(named: "")
            titleLabel.text = ""
            descTextView.text = ""
        }
    }
}
