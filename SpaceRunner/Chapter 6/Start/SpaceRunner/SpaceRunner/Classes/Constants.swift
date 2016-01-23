//
//  Constants.swift
//  SpaceRunner
//
//  Created by Jeremy Novak on 1/19/16.
//  Copyright © 2016 Jeremy Novak. All rights reserved.
//

import Foundation
import SpriteKit

// MARK: - Debug
let kDebug = true

// MARK: - Screen dimension convenience
let kViewSize = UIScreen.mainScreen().bounds.size
let kScreenCenter = CGPoint(x: kViewSize.width / 2, y: kViewSize.height / 2)

// MARK: - Device size convenience
let kDeviceTablet = (UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Pad)


// MARK: - Sprite Names
class SpriteName {
    
    // Button Sprite Names
    class var ButtonPlay:String         { return "PlayButton" }
    class var ButtonStart:String        { return "StartButton" }
    class var ButtonRetry:String        { return "RetryButton" }
    
    // Interface Title Names
    class var TitleGame:String          { return "GameTitle" }
    class var TitleGameShip:String      { return "GameTitleShip" }
    class var TitleGameOver:String      { return "GameOverTitle" }
    
    // Player
    class var Player:String             { return "Player" }
    class var TouchCircle:String        { return "TouchCircle" }
    
    // Particles
    class var Magic:String              { return "Magic" }
    
    // Meteors
    class var MeteorHuge:String         { return "MeteorHuge" }
    class var MeteorLarge:String        { return "MeteorLarge" }
    class var MeteorMedium:String       { return "MeteorMedium" }
    class var MeteorSmall:String        { return "MeteorSmall" }
}

// MARK: - Category Bitmasks
class Contact {
    class var Scene:UInt32      { return 1 << 0 }
    class var Meteor:UInt32     { return 1 << 1 }
    class var Star:UInt32       { return 1 << 2 }
    class var Player:UInt32     { return 1 << 3 }
}