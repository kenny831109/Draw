//
//  AppDelegate.swift
//  Draw
//
//  Created by 逸唐陳 on 2019/1/31.
//  Copyright © 2019 逸唐陳. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()
        let vc = ViewController()
        let navgationContro = UINavigationController(rootViewController: vc)
        window?.rootViewController = navgationContro
        window?.makeKeyAndVisible()
        return true
    }

}

