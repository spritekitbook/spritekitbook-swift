//
//  AppDelegate.swift
//  SpaceRunner
//
//  Created by Jeremy Novak on 8/18/16.
//  Copyright © 2016 Spritekit Book. All rights reserved.
//

import UIKit
import SpriteKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

//
//    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
//        // Override point for customization after application launch.
//        return true
//    }
    
    func applicationDidFinishLaunching(_ application: UIApplication) {
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Post message to Pause the game
        NotificationCenter.default.post(name: Notification.Name(rawValue: "Pause"), object: nil)
        
        // Pause the view
        let view = self.window?.rootViewController?.view as! SKView
        view.isPaused = true
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Resume the view
        let view = self.window?.rootViewController?.view as! SKView
        view.isPaused = false
        
        // Post message to Resume the game
        NotificationCenter.default.post(name: Notification.Name(rawValue: "Resume"), object: nil)
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

