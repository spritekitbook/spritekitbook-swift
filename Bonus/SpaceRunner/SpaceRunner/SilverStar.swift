//
//  SilverStar.swift
//  SpaceRunner
//
//  Created by Jeremy Novak on 9/19/16.
//  Copyright © 2016 Spritekit Book. All rights reserved.
//

import SpriteKit

class SilverStar: SKSpriteNode {
    
    // MARK: - Private class constants
    private let emitter = GameParticles.sharedInstance.createParticles(particles: .bonus)
    
    // MARK: - Class variables
    var drift:CGFloat = 0.0
    
    // MARK: - Init
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    
    convenience init() {
        let texture = GameTextures.sharedInstance.texture(name: SpriteName.silverStar)
        self.init(texture: texture, color: SKColor.white, size: texture.size())
        
        setup()
        setupPhysics()
    }
    
    // MARK: - Setup
    private func setup() {
        emitter.zPosition = self.zPosition - 1
        self.addChild(emitter)
    }
    
    private func setupPhysics() {
        self.physicsBody = SKPhysicsBody(circleOfRadius: self.size.width / 2, center: self.anchorPoint)
        self.physicsBody?.categoryBitMask = Contact.silverStar
        self.physicsBody?.collisionBitMask = 0x0
        self.physicsBody?.contactTestBitMask = 0x0
    }
    
    // MARK: - Update
    func update(delta: TimeInterval) {
        
        self.position.y = self.position.y - CGFloat(delta * 60 * 2.5)
        
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
    
    // MARK: - Contact
    func contact() {
        self.removeFromParent()
    }
    
    // MARK: - Game Over
    func gameOver() {
        self.shader = SKShader(fileNamed: kGrayShader)
    }
}
