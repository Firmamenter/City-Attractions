//
//  WebPageViewController.swift
//  McCollins
//
//  Created by Da Chen on 1/7/19.
//  Copyright © 2019 Da Chen. All rights reserved.
//

import UIKit

class WebPageViewController: UIViewController {
    var url: String?

    @IBOutlet weak var webView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()

        let webUrl = URL(string: url!)
        let request = URLRequest(url: webUrl!);
        webView.loadRequest(request);
    }
}
