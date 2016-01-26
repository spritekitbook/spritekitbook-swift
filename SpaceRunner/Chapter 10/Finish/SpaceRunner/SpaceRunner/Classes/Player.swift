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
    private var streakCount:Int = 0
    
    // MARK: - Public class variables
    internal var score:Int = 0
    internal var lives:Int = 3
    internal var immune = false
    internal var starsCollected:Int = 0
    internal var highStreak:Int = 0
    
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
        self.physicsBody?.contactTestBitMask = Contact.Meteor | Contact.Star
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
        
        // Set the StreakCount back to 0
        self.streakCount = 0
        
        // Does the player have any lives left?
        if self.lives > 0 {
            // Make the player immune
            self.immune = true
            
            // Blink the player to show immunity
            self.blinkPlayer()
            
            // Play the shields up sound
            self.runAction(GameAudio.sharedInstance.soundShieldUp)
            
            // In 3 seconds, remove the immunity and the blink action
            self.runAction(SKAction.waitForDuration(3.0), completion: {
                self.immune = false
                self.removeActionForKey("Blink")
                self.runAction(GameAudio.sharedInstance.soundShieldDown)
            })
        }
    }
    
    // MARK: - Pickup
    private func checkStreak(streak streak: Int) {
        if streak > self.highStreak {
            self.highStreak = streak
        }
    }
    
    func pickedUpStar() {
        self.starsCollected++
        self.streakCount++
        
        self.checkStreak(streak: self.streakCount)
        
        var bonus = ""
        let bonusLabel = GameFonts.sharedInstance.createLabel(string: bonus, labelType: GameFonts.LabelType.Bonus)
        
        switch self.streakCount {
            case 0..<5:
                self.score += 250
                bonus = String(250)
                
            case 5..<10:
                self.score += 500
                bonus = String(500)
                
            case 10..<15:
                self.score += 750
                bonus = String(750)
                
            case 15..<20:
                self.score += 1000
                bonus = String(1000)
                
            case 20..<25:
                self.score += 1250
                bonus = String(1250)
                
            case 25..<30:
                self.score += 1500
                bonus = String(1500)
                
            case 30..<35:
                self.score += 1750
                bonus = String(1750)
                
            case 35..<40:
                self.score += 2000
                bonus = String(2000)
                
            case 40..<45:
                self.score += 2250
                bonus = String(2250)
                
            case 45..<50:
                self.score += 2500
                bonus = String(2500)
                
            default:
                self.score += 5000
                bonus = String(5000)
        }
        
        // Float the bonus on screen
        bonusLabel.position = self.position
        bonusLabel.text = bonus
        self.parent?.addChild(bonusLabel)
        bonusLabel.runAction(GameFonts.sharedInstance.animateFloatingLabel(node: bonusLabel))
    }
    
    // MARK: - Check and save best score
    func gameOver() {
        if self.score > GameSettings.sharedInstance.getBestScore() {
            GameSettings.sharedInstance.saveBestScore(score: self.score)
        }
        
        if self.starsCollected > GameSettings.sharedInstance.getBestStars() {
            GameSettings.sharedInstance.saveBestStars(stars: self.starsCollected)
        }
        
        if self.highStreak > GameSettings.sharedInstance.getBestStreak() {
            GameSettings.sharedInstance.saveBestStreak(streak: self.highStreak)
        }
    }
}
