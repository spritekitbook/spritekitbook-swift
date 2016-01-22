//
//  Player.swift
//  SpaceRunner
//
//  Created by Jeremy Novak on 1/21/16.
//  Copyright © 2016 Jeremy Novak. All rights reserved.
//

import SpriteKit

class Player:SKSpriteNode {
    
    // MARK: - Private class constants
    private let touchOffset:CGFloat = kDeviceTablet ? 64.0 : 32.0
    private let filter:CGFloat = 0.05 // Filter movement by 5%
    
    // MARK: - Private class variables
    private var targetPosition = CGPoint()
    private var canMove = false
    
    // MARK: - Init
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    
    convenience init() {
        let texture = GameTextures.sharedInstance.textureWithName(name: SpriteName.Player)
        self.init(texture: texture, color: SKColor.whiteColor(), size: texture.size())
        
        self.setupPlayer()
        self.setupPlayerPhysics()
    }
    
    // MARK: - Setup
    private func setupPlayer() {
        // Initial position is centered horizontally and 20% up the Y axis
        self.position = CGPoint(x: kViewSize.width / 2, y: kViewSize.height * 0.2)
        self.targetPosition = self.position
    }
    
    private func setupPlayerPhysics() {
        self.physicsBody = SKPhysicsBody(circleOfRadius: self.size.width / 2, center: self.anchorPoint)
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.categoryBitMask = Contact.Player
        self.physicsBody?.collisionBitMask = Contact.Scene
        self.physicsBody?.contactTestBitMask = 0x0
    }
    
    // MARK: - Update
    func update() {
        if self.canMove {
            self.move()
        }
    }
    
    // MARK: - Movement
    func updateTargetLocation(newLocation newLocation: CGPoint) {
        // Set the targetLocation to the newLocation with the Y position adjusted by touchOffset
        self.targetPosition = CGPoint(x: newLocation.x, y: newLocation.y + self.touchOffset)
        
        // Draw the touch circle
        let touchCircle = TouchCircle()
        self.parent?.addChild(touchCircle)
        touchCircle.animateTouchCircle(atPosition: self.targetPosition)
    }
    
    private func move() {
        let newX = Smooth(startPoint: self.position.x, endPoint: self.targetPosition.x, filter: self.filter)
        let newY = Smooth(startPoint: self.position.y, endPoint: self.targetPosition.y, filter: self.filter)
        
        self.position = CGPoint(x: newX, y: newY)
    }
    
    // MARK: - Enable/Disable Movement
    func enableMovement() {
        self.canMove = true
    }
    
    func disableMovement() {
        self.canMove = false
    }
}
