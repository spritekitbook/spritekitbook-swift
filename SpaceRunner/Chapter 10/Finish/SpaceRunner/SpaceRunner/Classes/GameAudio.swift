//
//  GameAudio.swift
//  SpaceRunner
//
//  Created by Jeremy Novak on 1/26/16.
//  Copyright © 2016 Jeremy Novak. All rights reserved.
//

import SpriteKit
import AVFoundation

class Music {
    class var Game:String          { return "GameMusic.mp3" }
}

private class SoundEffects {
    // Shields
    class var ShieldUp:String      { return "ShieldUp.caf" }
    class var ShieldDown:String    { return "ShieldDown.caf" }
    // Interface
    class var ButtonTap:String     { return "ButtonTap.caf" }
    // Explosion
    class var Explosion:String     { return "Explosion.caf" }
    // Scoring
    class var Pickup:String        { return "Pickup.caf" }
}

let GameAudioSharedInstance = GameAudio()

class GameAudio {
    
    class var sharedInstance:GameAudio {
        return GameAudioSharedInstance
    }
    
    // MARK: - Private class variables
    private var musicPlayer = AVAudioPlayer()
    
    // MARK: - Public class constants
    internal let soundShieldUp = SKAction.playSoundFileNamed(SoundEffects.ShieldUp, waitForCompletion: false)
    internal let soundShieldDown = SKAction.playSoundFileNamed(SoundEffects.ShieldDown, waitForCompletion: false)
    internal let soundButtonTap = SKAction.playSoundFileNamed(SoundEffects.ButtonTap, waitForCompletion: false)
    internal let soundExplosion = SKAction.playSoundFileNamed(SoundEffects.Explosion, waitForCompletion: false)
    internal let soundPickup = SKAction.playSoundFileNamed(SoundEffects.Pickup, waitForCompletion: false)
    
    // MARK: - Public class variables
    internal var initialized = false
    
    // MARK: - Music player
    func playBackgroundMusic(fileName fileName: String) {
        let music = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource(fileName, ofType: nil)!)
        
        do {
            self.musicPlayer = try AVAudioPlayer(contentsOfURL: music)
        } catch let error as NSError {
            if kDebug {
                print(error)
            }
        }
        
        self.musicPlayer.numberOfLoops = -1
        self.musicPlayer.volume = 0.25
        self.musicPlayer.prepareToPlay()
        self.musicPlayer.play()
        
        self.initialized = true
    }
    
    func stopBackgroundMusic () {
        if self.musicPlayer.playing {
            self.musicPlayer.stop()
        }
    }
    
    func pauseBackgroundMusic () {
        if self.musicPlayer.playing {
            self.musicPlayer.pause()
        }
    }
    
    func resumeBackgroundMusic () {
        if self.initialized {
            self.musicPlayer.play()
        }
    }
}

