//
//  MapViewTableViewCell.swift
//  Burb
//
//  Created by Eugene on 08.02.2020.
//  Copyright © 2020 CC_Eugene. All rights reserved.
//

import UIKit
import MapKit

class MapViewTableViewCell: UITableViewCell, NiBLoadable {

    @IBOutlet weak var mapView: MKMapView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }


    
}

