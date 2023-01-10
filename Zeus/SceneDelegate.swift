//
//  SceneDelegate.swift
//  Zeus
//
//  Created by Priyanshu Verma on 29/12/22.
//

import UIKit
import Network

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    let navigationController = NavigationController(rootViewController: TabBarController())

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene

//        NetworkMonitor.shared.newtorkStatusHandlerDelegate = self
        NetworkMonitor.shared.startMonitoring()

        let navigationController = NavigationController(rootViewController: TabBarController())
        navigationController.navigationBar.isHidden = true
        window?.rootViewController = navigationController

        window?.makeKeyAndVisible()

        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            appDelegate.window = window
        }

    }

    func sceneDidDisconnect(_ scene: UIScene) {
        NetworkMonitor.shared.stopMonitoring()
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

//private typealias InternetConnectionCheck = SceneDelegate
//extension InternetConnectionCheck: NetworkStatusHandler {
//    func passNetworkStatus(status: NWPath.Status) {
//        print(status)
//        DispatchQueue.main.async {
//            if(status == .satisfied) {
//                self.window?.rootViewController = self.navigationController
//                self.window?.makeKeyAndVisible()
//            } else {
//                let noInternetScreen: NoResultsFound = {
//                    let view = NoResultsFound()
//                    view.setLabelText(toText: "No Internet Connection")
//                    return view
//                }()
//                self.window?.rootViewController = noInternetScreen
//                self.window?.makeKeyAndVisible()
//            }
//        }
//    }
//}
