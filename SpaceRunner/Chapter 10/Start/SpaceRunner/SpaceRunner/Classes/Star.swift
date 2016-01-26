//
//  Star.swift
//  SpaceRunner
//
//  Created by Jeremy Novak on 1/24/16.
//  Copyright © 2016 Jeremy Novak. All rights reserved.
//

import SpriteKit

class Star:SKSpriteNode {
    
    // MARK: - Public class properties
    internal var drift = CGFloat()
    
    // MARK: - Init
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    
    convenience init() {
        let texture = GameTextures.sharedInstance.textureWithName(name: SpriteName.Star)
        self.init(texture: texture, color: SKColor.whiteColor(), size: texture.size())
        
        self.setupStar()
        self.setupStarPhysics()
    }
    
    // MARK: - Setup
    private func setupStar() {
    }
    
    private func setupStarPhysics() {
        self.physicsBody = SKPhysicsBody(circleOfRadius: self.size.width / 2, center: self.anchorPoint)
        self.physicsBody?.categoryBitMask = Contact.Star
        self.physicsBody?.collisionBitMask = 0x0
        self.physicsBody?.contactTestBitMask = 0x0
    }
    
    // MARK: - Update
    func update(delta delta: NSTimeInterval) {
        
        self.position.y = kDeviceTablet ? self.position.y - CGFloat(delta * 60 * 4) : self.position.y - CGFloat(delta * 60 * 2)
        
        self.position.x = self.position.x + self.drift
        
        // Remove from parent if off the bottom of the screen
        if self.position.y < (0 - self.size.height) {
            self.removeFromParent()
        }
        
        // Remove from parent if off the screen to the left or right
        if self.position.x < (0 - self.size.width) || self.position.x > (kViewSize.width + self.size.width) {
            self.removeFromParent()
        }
        
        // Rotate slowly while moving down the screen
        self.zRotation = self.zRotation + CGFloat(delta)
    }
    
    // MARK: - Action functions
    func pickedUpStar() {
        self.runAction(GameAudio.sharedInstance.soundPickup, completion: {
            self.removeFromParent()
        })
    }
    
    func gameOver() {
    }
}

