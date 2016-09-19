//
//  Player.swift
//  SpaceRunner
//
//  Created by Jeremy Novak on 8/31/16.
//  Copyright © 2016 Spritekit Book. All rights reserved.
//

import SpriteKit

class Player: SKSpriteNode {
    
    // MARK: - Private class constants
    private let touchOffset:CGFloat = 44.0
    private let moveFilter:CGFloat = 0.05 // Filter movement by 5%
    
    // MARK: - Private class variables
    private var targetPosition = CGPoint()
    private var score = 0
    private var streak = 0
    private var lives = 3
    private var immune = false
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    
    convenience init() {
        let texture = GameTextures.sharedInstance.texture(name: SpriteName.player)
        self.init(texture: texture, color: SKColor.white, size: texture.size())
        
        setup()
        setupPhysics()
        
        self.name = "Player"
    }
    
    private func setup() {
        // Initial position is centered horizontally and 20% up the Y axis
        self.position = CGPoint(x: kViewSize.width / 2, y: kViewSize.height * 0.2)
        
        targetPosition = self.position
    }
    
    private func setupPhysics() {
        self.physicsBody = SKPhysicsBody(circleOfRadius: self.size.width / 2, center: self.anchorPoint)
        self.physicsBody?.categoryBitMask = Contact.player
        self.physicsBody?.collisionBitMask = 0x0
        self.physicsBody?.contactTestBitMask = Contact.meteor | Contact.star
    }
    
    // MARK: - Update
    func update() {
        move()
    }
    
    // MARK: - Movement
    func updateTargetPosition(position: CGPoint) {
        targetPosition = CGPoint(x: position.x, y: position.y + touchOffset)
    }
    
    private func move() {
        let newX = Smooth(startPoint: self.position.x, endPoint: targetPosition.x, percentToMove: moveFilter)
        let newY = Smooth(startPoint: self.position.y, endPoint: targetPosition.y, percentToMove: moveFilter)
        
        // "Clamp" the minimum and maximum X value to allow half the ship to go offscreen horizontally
        let correctedX = Clamp(value: newX, min: 0 - self.size.width / 2, max: kViewSize.width + self.size.width / 2)
        
        // "Clamp" the minimum and maximum Y value to not allow the ship to go off screen vertically
        let correctedY = Clamp(value: newY, min: 0 + self.size.height, max: kViewSize.height - self.size.height)
        
        self.position = CGPoint(x: correctedX, y: correctedY)
        
        rotate()
    }
    
    private func rotate() {
        if DistanceBetweenPoints(firstPoint: self.position, secondPoint: targetPosition) > 25 {
            let angle = AngleBetweenPoints(targetPosition: targetPosition, currentPosition: self.position)
            self.run(SKAction.rotate(toAngle: angle, duration: 0.16, shortestUnitArc: true))
        } else {
            let angle:CGFloat = 0.0
            self.run(SKAction.rotate(toAngle: angle, duration: 0.16, shortestUnitArc: true))
        }
    }
    
    // MARK: - Actions
    private func blinkPlayer() {
        let blink = SKAction.sequence([SKAction.fadeOut(withDuration: 0.15), SKAction.fadeIn(withDuration: 0.15)])
        self.run(SKAction.repeatForever(blink), withKey: "Blink")
    }
    
    // MARK: - Contact
    func contact(body: String) {
        lives -= 1
        
        streak = 0
        
        if lives > 0 {
            immune = true
            
            blinkPlayer()
            
            self.run(SKAction.wait(forDuration: 3.0), completion: {
                [weak self] in
                self?.immune = false
                self?.removeAction(forKey: "Blink")
            })
        }
        
        if kDebug {
           print("Player made contact with \(body).")
        }
    }
    
    func getLives() -> Int {
        return lives
    }
    
    func getImmunity() -> Bool {
        return immune
    }
    
    
    // MARK: - Score
    private func increaseScore(bonus: Int) {
        score += bonus
        
        if kDebug {
            print("Score: \(score)")
        }
    }
    
    func pickup() {
        streak += 1
        
        switch streak {
        case 0...5:
            increaseScore(bonus: 250)
            
        case 6...10:
            increaseScore(bonus: 500)
            
        case 11...15:
            increaseScore(bonus: 750)
            
        case 16...20:
            increaseScore(bonus: 1000)
            
        default:
            increaseScore(bonus: 5000)
        }
    }
    
    
    func updateDistanceScore() {
        score += 1
        
        if kDebug {
            print("Score: \(score)")
        }
    }
}
