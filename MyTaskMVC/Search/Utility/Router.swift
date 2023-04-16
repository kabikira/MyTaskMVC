//
//  File.swift
//  MyTaskMVC
//
//  Created by koala panda on 2023/04/16.
//

import UIKit

final class Router {
    static let shared: Router =  .init()
    private init() {}

    private var window: UIWindow?
    func showRoot(window: UIWindow?) {
        guard let vc = UIStoryboard.init(name: "Search", bundle: nil).instantiateInitialViewController() else {
            return
        }
        let nav = UINavigationController(rootViewController: vc)
        window?.rootViewController = nav
        window?.makeKeyAndVisible()
        self.window = window
    }

    func showWeb(from: UIViewController, gitHubModel: GitHubModel) {
        guard let web = UIStoryboard.init(name: "WebView", bundle: nil).instantiateInitialViewController() as? WebViewController else {
            return
        }
        web.configure(gitHubModel: gitHubModel)
        show(from: from, to: web)
    }
}
private func show(from: UIViewController, to: UIViewController, completion:(() -> Void)? = nil) {
    if let nav = from.navigationController {
        nav.pushViewController(to, animated: true)
        completion?()
    } else {
        from.present(to, animated: true, completion: completion)
    }


}
