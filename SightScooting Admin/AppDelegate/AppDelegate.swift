//
//  AppDelegate.swift
//  SightScooting Admin
//
//  Created by Sarmad Ishfaq on 19/06/2021.
//

import UIKit
import GoogleMaps
import Firebase
import IQKeyboardManagerSwift
@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        GMSServices.provideAPIKey(Constant.gooleApiKey)
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        window = UIWindow(frame: UIScreen.main.bounds)
        FirebaseApp.configure()
        window?.makeKeyAndVisible()
        window?.rootViewController = UINavigationController(rootViewController: HomeController())
        return true
    }

}

