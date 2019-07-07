//
//  SubViewController.swift
//  Dashboard
//
//  Created by Saad Durrani on 5/10/18.
//  Copyright © 2018 Khan and Mike Org. All rights reserved.
//

import Foundation
import UIKit
import WebKit

class SubViewController : UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let urlToView:String = (lightOpen.lighturl)
        if urlToView != "" {
            let urlw = URL(string: urlToView)
            let request = URLRequest(url: urlw!)
            webView.load(request)
        }
    }
    
    var lightOpen:Lights = Lights()

}
