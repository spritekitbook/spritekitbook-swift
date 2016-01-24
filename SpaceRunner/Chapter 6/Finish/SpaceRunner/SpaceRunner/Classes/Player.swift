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
    
    // MARK: - Public class variables
    internal var score:Int = 0
    internal var lives:Int = 3
    internal var immune = false
    
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
        self.physicsBody?.contactTestBitMask = Contact.Meteor
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
    
    // MARK: - Update Score
    func updatePlayerScore(score score: Int) {
        self.score += score
    }
    
    // MARK: - Update Lives
    private func updatePlayerLives() {
        self.lives--
    }
    
    // MARK: - Actions
    private func blinkPlayer() {
        let blink = SKAction.sequence([SKAction.fadeOutWithDuration(0.15), SKAction.fadeInWithDuration(0.15)])
        self.runAction(SKAction.repeatActionForever(blink), withKey: "Blink")
    }
    
    // MARK: - Contact
    func hitMeteor() {
        // Subtract from lives
        self.updatePlayerLives()
        
        // Does the player have any lives left?
        if self.lives > 0 {
            // Make the player immune
            self.immune = true
            
            // Blink the player to show immunity
            self.blinkPlayer()
            
            // In 3 seconds, remove the immunity and the blink action
            self.runAction(SKAction.waitForDuration(3.0), completion: {
                self.immune = false
                self.removeActionForKey("Blink")
            })
        }
        
    }
}
