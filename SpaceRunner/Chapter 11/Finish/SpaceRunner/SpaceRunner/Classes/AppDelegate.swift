//
//  AppDelegate.swift
//  SpaceRunner
//
//  Created by Jeremy Novak on 1/19/16.
//  Copyright © 2016 Jeremy Novak. All rights reserved.
//

import UIKit
import SpriteKit
import AVFoundation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Post message to Pause the game
        NSNotificationCenter.defaultCenter().postNotificationName("PauseGame", object: nil)
        
        // Pause the music
        GameAudio.sharedInstance.pauseBackgroundMusic()
        
        // Pause the view
        let view = self.window?.rootViewController?.view as! SKView
        view.paused = true
    }

    func applicationDidEnterBackground(application: UIApplication) {
        
    }

    func applicationWillEnterForeground(application: UIApplication) {
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Resume the view
        let view = self.window?.rootViewController?.view as! SKView
        view.paused = false
        
        // Post message to Resume the game
        NSNotificationCenter.defaultCenter().postNotificationName("ResumeGame", object: nil)
        
        // Resume the music
        GameAudio.sharedInstance.resumeBackgroundMusic()
    }

    func applicationWillTerminate(application: UIApplication) {
    }


}

