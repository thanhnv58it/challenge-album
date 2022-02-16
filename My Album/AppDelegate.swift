//
//  AppDelegate.swift
//  My Album
//
//  Created by Thành Ngô Văn on 16/02/2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let movie = AlbumListVC(nibName: AlbumListVC.nibName, bundle: nil)
        self.window?.rootViewController = UINavigationController(rootViewController: movie)
        self.window?.overrideUserInterfaceStyle = .dark
        self.window?.makeKeyAndVisible()
        return true
    }
    
}

