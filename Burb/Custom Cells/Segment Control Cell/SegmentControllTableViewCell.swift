//
//  SegmentControllTableViewCell.swift
//  Burb
//
//  Created by Eugene on 25.03.2020.
//  Copyright © 2020 CC_Eugene. All rights reserved.
//

import UIKit

class SegmentControllTableViewCell: UITableViewCell, NiBLoadable {

    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    var indexChanged: ItemClosure<Int>?
    var index: Int? = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        Decorator.decorate(self)
        addTargets()
    }

    func set(titles: [String]) {
        segmentControl.removeAllSegments()

        titles.enumerated().forEach { i, title in
            segmentControl.insertSegment(withTitle: title, at: i, animated: true)
        }
        segmentControl.selectedSegmentIndex = index!
    }
    
    
    private func addTargets() {
        segmentControl.addTarget(self, action: #selector(segmentControlChangedIndex(sender:)), for: .valueChanged)
    }
    
    @objc private func segmentControlChangedIndex(sender: UISegmentedControl) {
        indexChanged?(sender.selectedSegmentIndex)
    }
}

 
extension SegmentControllTableViewCell {
    fileprivate class Decorator {
        private init() {}
        static func decorate(_ cell: SegmentControllTableViewCell) {
            cell.selectionStyle = .none
        }
    }
}
