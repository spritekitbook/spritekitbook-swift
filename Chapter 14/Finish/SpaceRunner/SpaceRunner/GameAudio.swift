//
//  GameAudio.swift
//  SpaceRunner
//
//  Created by Jeremy Novak on 9/13/16.
//  Copyright © 2016 Spritekit Book. All rights reserved.
//

import SpriteKit
import AVFoundation

enum Clip {
    case shieldUp, shieldDown, button, explosion, pickup
}

class GameAudio {
    
    static let sharedInstance = GameAudio()
    
    // MARK: - Private class constants
    private let music = "GameMusic.mp3"
    
    // MARK: - Private class variables
    private var player = AVAudioPlayer()
    private var initialized = false
    
    
    // MARK: - Music player
    func playMusic() {
        let url = URL(fileURLWithPath: Bundle.main.path(forResource: music, ofType: nil)!)
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
        } catch let error as NSError {
            NSLog("Error playing music: %@", error)
        }
        
        player.numberOfLoops = -1
        player.volume = 0.25
        player.prepareToPlay()
        player.play()
        
        initialized = true
    }
    
    func playMusic(name: String) {
        let url = URL(fileURLWithPath: Bundle.main.path(forResource: name, ofType: "mp3")!)
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
        } catch let error as NSError {
            NSLog("Error playing music: %@", error)
        }
        
        player.numberOfLoops = -1
        player.volume = 0.25
        player.prepareToPlay()
        player.play()
        
        initialized = true
    }
    
    func stopMusic() {
        if player.isPlaying {
            player.stop()
        }
    }
    
    func pauseMusic() {
        if player.isPlaying {
            player.pause()
        }
    }
    
    func resumeMusic() {
        if initialized {
            player.play()
        }
    }
    
    // MARK: - Clips
    func playClip(type: Clip) -> SKAction {
        var file = String()
        
        switch type {
        case .shieldDown:
            file = "ShieldDown.caf"
            
        case .shieldUp:
            file = "ShieldUp.caf"
            
        case .button:
            file = "ButtonTap.caf"
            
        case .explosion:
            file = "Explosion.caf"
            
        case .pickup:
            file = "Pickup.caf"
            
        }
        
        return SKAction.playSoundFileNamed(file, waitForCompletion: false)
    }
}
