//
//  WebViewController.swift
//  MyTaskMVC
//
//  Created by koala panda on 2023/04/16.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    @IBOutlet private weak var webView: WKWebView!

    private var gitHubModel: GitHubModel?

    func configure(gitHubModel: GitHubModel) {
        self.gitHubModel = gitHubModel
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let gitHubModel = gitHubModel,
              let url = URL(string: gitHubModel.urlStr) else {
            return
        }
        webView.load(URLRequest(url: url))
    }

}
