//
//  StarController.swift
//  SpaceRunner
//
//  Created by Jeremy Novak on 1/24/16.
//  Copyright © 2016 Jeremy Novak. All rights reserved.
//

import SpriteKit

class StarController:SKNode {
    
    // MARK: - Private class constants
    private let star = Star()
    
    // MARK: - Private class variables
    private var sendingStars = false
    private var movingStars = false
    private var frameCount = 0.0
    
    // MARK: - Init
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init() {
        super.init()
        
        self.setupStarController()
    }
    
    // MARK: - Setup
    private func setupStarController() {
        
    }
    
    // MARK: - Update
    func update(delta delta: NSTimeInterval) {
        // Is it time to send another star?
        if self.sendingStars {
            self.frameCount += delta
            
            if self.frameCount >= 3.0 {
                // Spawn a star
                self.spawnStar()
                
                // Reset the frame counter
                self.frameCount = 0.0
            }
        }
        
        // Move the stars on screen
        if self.movingStars {
            for node in self.children {
                if let star = node as? Star {
                    star.update(delta: delta)
                }
            }
        }
    }
    
    // MARK: - Spawn
    private func spawnStar() {
        if self.sendingStars {
            let startX = RandomFloatRange(min: 0, max: kViewSize.width)
            let startY = kViewSize.height * 1.25
            
            let star = self.star.copy() as! Star
            star.position = CGPoint(x: startX, y: startY)
            star.drift = RandomFloatRange(min: -0.25, max: 0.25)
            self.addChild(star)
        }
    }
    
    // MARK: - Actions
    func startSendingStars() {
        self.sendingStars = true
        self.movingStars = true
    }
    
    func stopSendingStars() {
        self.sendingStars = false
        self.movingStars = false
    }
    
    func gameOver() {
        for node in self.children {
            if let star = node as? Star {
                star.gameOver()
            }
        }
    }
}
