//
//  MeteorController.swift
//  SpaceRunner
//
//  Created by Jeremy Novak on 9/6/16.
//  Copyright © 2016 Spritekit Book. All rights reserved.
//

import SpriteKit

class MeteorController: SKNode {
    
    // MARK: - Private class constants
    private let meteor0 = Meteor(type: .huge)
    private let meteor1 = Meteor(type: .large)
    private let meteor2 = Meteor(type: .medium)
    private let meteor3 = Meteor(type: .small)
    
    // MARK: - Private class variables
    private var frameCount = 0.0
    private var meteorArray = [SKSpriteNode]()

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
        meteorArray = [meteor0, meteor1, meteor2, meteor3]
    }
    
    // MARK: - Spawn
    private func spawnMeteors() {
        let randomCount = RandomIntegerBetween(min: 10, max: 14)
        
        for _ in 0...randomCount {
            let randomIndex = RandomIntegerBetween(min: 0, max: meteorArray.count - 1)
            
            let offsetX:CGFloat = randomIndex % 2 == 0 ? -72 : 72
            let startX = RandomFloatRange(min: 0, max: kViewSize.width) + offsetX
            
            let offsetY:CGFloat = randomIndex % 2 == 0 ? 72 : -72
            let startY = kViewSize.height * 1.25 + offsetY
            
            let meteor = self.meteorArray[randomIndex].copy() as! Meteor
            meteor.drift = RandomFloatRange(min: -0.5, max: 0.5)
            
            meteor.position = CGPoint(x: startX, y: startY)
            
            self.addChild(meteor)
        }
    }
    
    // MARK: - Update
    func update(delta: TimeInterval) {
        frameCount += delta
        
        if frameCount >= 3.0 {
            spawnMeteors()
            
            frameCount = 0.0
        }
        
        for node in self.children {
            if let meteor = node as? Meteor {
                meteor.update(delta: delta)
            }
        }
    }
}
