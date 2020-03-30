//
//  BUTableView.swift
//  Burb
//
//  Created by Eugene on 27.03.2020.
//  Copyright © 2020 CC_Eugene. All rights reserved.
//

import UIKit

class BUTableView: UITableView {
    
    fileprivate var indicator: UIActivityIndicatorView?
    fileprivate var customRefreshControl: UIRefreshControl?
    
    public private(set) var emptyView: BUEmptyView?
    fileprivate var blockOfRefreshControl: (()->())?
    
     var bottomInset: CGFloat = 0
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
          super.init(coder: aDecoder)
          setup()
      }
    
    fileprivate func setup() {
        autoresizingMask = [.flexibleHeight, .flexibleWidth]
        setupIndicator()
    }
    
    func setupRefreshControl(_ withBlock: @escaping ()->()) {
        blockOfRefreshControl = withBlock
        customRefreshControl = UIRefreshControl()
        customRefreshControl!.addTarget(self, action: #selector(refreshControlHandler), for: .valueChanged)
        self.insertSubview(customRefreshControl!, at: 0)
    }
    
    fileprivate func setupIndicator() {
        indicator = UIActivityIndicatorView(style: .medium)
        indicator!.backgroundColor = UIColor.white
        indicator!.contentMode = .center
    }
    
    func launchIndicator() {
        self.indicator?.frame = self.bounds
        self.superview?.addSubview(indicator!)
        self.bringSubviewToFront(indicator!)
        self.indicator!.startAnimating()
    }
    
    func stopIndicator() {
         self.indicator!.stopAnimating()
         self.indicator!.removeFromSuperview()
     }
    
    func endRefreshing() {
        self.customRefreshControl?.endRefreshing()
    }

    @objc fileprivate func refreshControlHandler() {
        if let block = blockOfRefreshControl {
            block()
        }
    }
    
    // MARK: EMPTY_VIEW
    
    func setupEmptyView(with type: BUEmptyViewType) {
   //     emptyView = BUEmptyView(frame: self.bounds, type: type)
        emptyView!.isHidden = true
        self.addSubview(emptyView!)
    }
    
    func setupEmptyView(withImage name: String?, label title: String?) {
//        emptyView = BUEmptyView(frame: self.bounds, image: name, title: title)
        emptyView!.isHidden = true
        self.addSubview(emptyView!)
    }
    
    func setEmptyView(hidden: Bool) {
        emptyView?.isHidden = hidden
    }
    
}
