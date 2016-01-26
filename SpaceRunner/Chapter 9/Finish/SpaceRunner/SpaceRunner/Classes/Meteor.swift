//
//  Meteor.swift
//  SpaceRunner
//
//  Created by Jeremy Novak on 1/23/16.
//  Copyright © 2016 Jeremy Novak. All rights reserved.
//

import SpriteKit

class Meteor:SKSpriteNode {
    
    // MARK: - Public enum
    internal enum MeteorType:Int {
        case Huge
        case Large
        case Medium
        case Small
    }
    
    // MARK: - Public class variables
    internal var drift = CGFloat()
    
    // MARK: - Init
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }

    convenience init(type: MeteorType) {
        var texture = SKTexture()
        
        
        switch type {
        case MeteorType.Huge:
            texture = GameTextures.sharedInstance.textureWithName(name: SpriteName.MeteorHuge)
            break
            
        case MeteorType.Large:
            texture = GameTextures.sharedInstance.textureWithName(name: SpriteName.MeteorLarge)
            break
            
        case MeteorType.Medium:
            texture = GameTextures.sharedInstance.textureWithName(name: SpriteName.MeteorMedium)
            break
            
        case MeteorType.Small:
            texture = GameTextures.sharedInstance.textureWithName(name: SpriteName.MeteorSmall)
            break
            
        }
        
        self.init(texture: texture, color: SKColor.whiteColor(), size: texture.size())
        
        self.setupMeteor()
        self.setupMeteorPhysics()
    }
    
    // MARK: - Setup
    private func setupMeteor() {
        
    }
    
    private func setupMeteorPhysics() {
        self.physicsBody = SKPhysicsBody(circleOfRadius: self.size.width / 2, center: self.anchorPoint)
        self.physicsBody?.categoryBitMask = Contact.Meteor
        self.physicsBody?.collisionBitMask = 0x0    // Ignore collisions
        self.physicsBody?.contactTestBitMask = 0x0  // Ignore contact
    }
    
    // MARK: - Update
    func update(delta delta: NSTimeInterval) {
        // Move vertically down the screen based on device type
        self.position.y = kDeviceTablet ? self.position.y - CGFloat(delta * 60 * 4) : self.position.y - CGFloat(delta * 60 * 2)
        
        // Add the drift to the X position
        self.position.x = self.position.x + self.drift
        
        // If the meteor is completely off screen at the bottom remove from parent
        if self.position.y < (0 - self.size.height) {
            self.removeFromParent()
        }
        
        // If the meteor is completley off screen left or right remove from parent
        if self.position.x < (0 - self.size.width) || self.position.x > (kViewSize.width + self.size.width) {
            self.removeFromParent()
        }
    }
    
    // MARK: - Action functions
    func hitMeteor() {
        self.removeFromParent()
    }
    
    func gameOver() {
    }
}
