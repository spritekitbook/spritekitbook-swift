//
//  PickupController.swift
//  SpaceRunner
//
//  Created by Jeremy Novak on 9/19/16.
//  Copyright © 2016 Spritekit Book. All rights reserved.
//

import SpriteKit

class PickupController: SKNode {
    
    // MARK: - Private class constants
    private let shield = Shield()
    private let silverStar = SilverStar()
    
    // MARK: - Private class variables
    private var pickupArray = [SKSpriteNode]()
    private var frameCount:TimeInterval = 0.0
    
    // MARK: - Init
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init() {
        super.init()
        
        self.setup()
    }
    
    // MARK: - Setup
    private func setup() {
        pickupArray.append(shield)
        pickupArray.append(silverStar)
    }
    
    // MARK: - Update
    func update(delta: TimeInterval) {
        self.frameCount += delta
        
        if self.frameCount >= 12.0 {
            // Spawn a star
            self.spawnPickup()
            
            // Reset the frame counter
            self.frameCount = 0.0
        }
        
        for node in self.children {
            if let thisShield = node as? Shield {
                thisShield.update(delta: delta)
            }
            
            if let thisSilverStar = node as? SilverStar {
                thisSilverStar.update(delta: delta)
            }
        }
    }
    
    // MARK: - Spawn 
    private func spawnPickup() {
        let randomIndex = RandomIntegerBetween(min: 0, max: pickupArray.count - 1)
        let randomDrift = RandomFloatRange(min: -0.3, max: 0.3)
        
        let startX = RandomFloatRange(min: 0, max: kViewSize.width)
        let startY = kViewSize.height * 1.25
        
        if let thisShield = pickupArray[randomIndex].copy() as? Shield {
            thisShield.drift = randomDrift
            thisShield.position = CGPoint(x: startX, y: startY)
            self.addChild(thisShield)
        }
        
        if let thisSilverStar = pickupArray[randomIndex].copy() as? SilverStar {
            thisSilverStar.drift = randomDrift
            thisSilverStar.position = CGPoint(x: startX, y: startY)
            self.addChild(thisSilverStar)
        }
    }
    
    // MARK: - Game Over
    func gameOver() {
        for node in self.children {
            if let thisShield = node as? Shield {
                thisShield.gameOver()
            }
            
            if let thisSilverStar = node as? SilverStar {
                thisSilverStar.gameOver()
            }
        }
    }
}
