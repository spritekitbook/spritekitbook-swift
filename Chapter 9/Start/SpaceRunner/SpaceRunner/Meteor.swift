//
//  Meteor.swift
//  SpaceRunner
//
//  Created by Jeremy Novak on 9/6/16.
//  Copyright © 2016 Spritekit Book. All rights reserved.
//

import SpriteKit

class Meteor: SKSpriteNode {
    
    // MARK: - Enum
    enum MeteorType:Int {
        case huge, large, medium, small
    }
    
    // MARK: - Public instance variables
    var drift = CGFloat()
    
    // MARK: - Init
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    
    convenience init(type: MeteorType) {
        var  texture = SKTexture()
        
        
        switch type {
        case MeteorType.huge:
            texture = GameTextures.sharedInstance.texture(name: SpriteName.meteorHuge)
            
        case MeteorType.large:
            texture = GameTextures.sharedInstance.texture(name: SpriteName.meteorLarge)
            
        case MeteorType.medium:
            texture = GameTextures.sharedInstance.texture(name: SpriteName.meteorMedium)
            
        case MeteorType.small:
            texture = GameTextures.sharedInstance.texture(name: SpriteName.meteorSmall)
            
        }
        
        self.init(texture: texture, color: SKColor.white, size: texture.size())
        
        setup()
        setupPhysics()
        
        self.name = "Meteor"
    }
    
    // MARK: - Setup
    private func setup() {
    }
    
    private func setupPhysics() {
        self.physicsBody = SKPhysicsBody(circleOfRadius: self.size.width / 2, center: self.anchorPoint)
        self.physicsBody?.categoryBitMask = Contact.meteor
        self.physicsBody?.collisionBitMask = 0x0
        self.physicsBody?.contactTestBitMask = 0x0
    }
    
    // MARK: - Update
    func update(delta: TimeInterval) {
        // Move down the screen on the Y axis
        self.position.y = self.position.y - CGFloat(delta * 60 * 2)
        
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
    
    // MARK: - Contact
    func contact(body: String) {
        print("Meteor made contact with \(body).")
        
        // Remove this meteor
        self.removeFromParent()
    }

}
