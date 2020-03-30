//
//  BUTermsOfUseViewController.swift
//  Burb
//
//  Created by Eugene on 24.02.2020.
//  Copyright © 2020 CC_Eugene. All rights reserved.
//

import UIKit
import WebKit

class BUTermsOfUseViewController: UIViewController {
    

    @IBOutlet weak var webView: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Terms of use"
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }


}
