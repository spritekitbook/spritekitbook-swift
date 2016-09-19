//
//  StarController.swift
//  SpaceRunner
//
//  Created by Jeremy Novak on 9/7/16.
//  Copyright © 2016 Spritekit Book. All rights reserved.
//

import SpriteKit

class StarController: SKNode {
    
    // MARK: - Private class constants
    private let star = Star()
    
    // MARK: - Private class variables
    private var frameCount = 0.0
    
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
    }
    
    // MARK: - Spawn
    private func spawnStar() {
        let startX = RandomFloatRange(min: 0, max: kViewSize.width)
        let startY = kViewSize.height * 1.25
        
        let star = self.star.copy() as! Star
        star.position = CGPoint(x: startX, y: startY)
        star.drift = RandomFloatRange(min: -0.25, max: 0.25)
        self.addChild(star)
    }
    
    // MARK: - Update
    func update(delta: TimeInterval) {
        self.frameCount += delta
        
        if self.frameCount >= 3.0 {
            // Spawn a star
            self.spawnStar()
            
            // Reset the frame counter
            self.frameCount = 0.0
        }

        for node in self.children {
            if let star = node as? Star {
                star.update(delta: delta)
            }
        }
    }
    
    // MARK: - Game Over
    func gameOver() {
        for node in self.children {
            if let star = node as? Star {
                star.gameOver()
            }
        }
    }
    
}
