//
//  AppDelegate.swift
//  PDF Demo
//
//  Created by Sean Buttinger (Rocket Apes) on 17.10.24.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    private var appCoordinator: AppCoordinator!
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let navigationController = UINavigationController()
        
        appCoordinator = AppCoordinator(navigationController: navigationController)
        appCoordinator?.start()
        
        window = UIWindow()
        window?.rootViewController = appCoordinator.navigationController
        window?.makeKeyAndVisible()
        
        return true
    }
}
