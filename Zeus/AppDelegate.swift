//
//  AppDelegate.swift
//  Zeus
//
//  Created by Priyanshu Verma on 29/12/22.
//

import UIKit
import GoogleMaps

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        GMSServices.provideAPIKey(Secrets.GMSapiKey.rawValue)
        
        NetworkMonitor.shared.startMonitoring()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let navigationController = NavigationController(rootViewController: TabBarController())
        navigationController.navigationBar.isHidden = true
        window?.rootViewController = navigationController

        window?.makeKeyAndVisible()
        
        return true
    }
}

