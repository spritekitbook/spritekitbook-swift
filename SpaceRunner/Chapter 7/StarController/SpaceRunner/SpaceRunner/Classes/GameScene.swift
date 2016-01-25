//
//  GameScene.swift
//  SpaceRunner
//
//  Created by Jeremy Novak on 1/19/16.
//  Copyright (c) 2016 Jeremy Novak. All rights reserved.
//

import SpriteKit

class GameScene:SKScene, SKPhysicsContactDelegate {
    
    // MARK: - Private class enum
    private enum GameState:Int {
        case Tutorial
        case Running
        case Paused
        case GameOver
    }
    
    // MARK: - Private class constants
    private let gameNode = SKNode()
    private let interfaceNode = SKNode()
    private let background = Background()
    private let startButton = StartButton()
    private let player = Player()
    private let meteorController = MeteorController()
    private let starController = StarController()
    
    // MARK: - Private class variables
    private var state = GameState.Tutorial
    private var lastUpdateTime:NSTimeInterval = 0.0
    private var frameCount:NSTimeInterval = 0.0
    private var statusBar = StatusBar()

    
    // MARK: - Init
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(size: CGSize) {
        super.init(size: size)
    }
    
    override func didMoveToView(view: SKView) {
        self.setupGameScene()
    }
    
    // MARK: - Setup
    private func setupGameScene() {
        // Set the background color to Black
        self.backgroundColor = SKColor.blackColor()
        
        // Set up the physics for the world
        self.physicsWorld.gravity = CGVectorMake(0, 0)
        self.physicsWorld.contactDelegate = self
        
        // Create the physics body for gameNode
        let screenBounds = CGRectMake(-self.player.size.width / 2, 0, kViewSize.width + self.player.size.width, kViewSize.height)
        self.gameNode.physicsBody = SKPhysicsBody(edgeLoopFromRect: screenBounds) // Create a boundary using screenBounds
        self.gameNode.physicsBody?.categoryBitMask = Contact.Scene
        
        // Add gameNode to the scene
        self.addChild(self.gameNode)
        
        // Add the background node to game node
        self.gameNode.addChild(background)
        
        // Add the play button to the game node
        self.gameNode.addChild(self.startButton)
        
        // Add the meteor controller to the game node
        self.gameNode.addChild(self.meteorController)
        
        // Add the star controller to the game node
        self.gameNode.addChild(self.starController)
        
        // Add the player to the game node
        self.gameNode.addChild(self.player)
        
        // Add the interfaceNode to the scene
        self.addChild(self.interfaceNode)
        
        // Add the statusBar to the interface node
        self.statusBar = StatusBar(lives: self.player.lives, score: self.player.score)
        self.interfaceNode.addChild(self.statusBar)
    }
    
    // MARK: - Update
    override func update(currentTime: NSTimeInterval) {
        // Calculate "delta"
        let delta = currentTime - self.lastUpdateTime
        self.lastUpdateTime = currentTime
        
        // Switch on GameState
        switch self.state {
            
            case GameState.Tutorial:
                    return
                
                
            case GameState.Running:
                // Check if the player has more than 0 lives
                if self.player.lives > 0 {
                    // Manually run update on player
                    self.player.update()
                    
                    // Manually run update on meteorController
                    self.meteorController.update(delta: delta)
                    
                    // Manually run update on starController
                    self.starController.update(delta: delta)
                    
                    // Increase frameCount by delta
                    self.frameCount += delta
                    
                    // If frameCount is greater than 1.0, approximately 1 second has passed
                    if self.frameCount >= 1.0 {
                        // Increase the player's score by 1 point
                        self.updateDistanceTick()
                        
                        // Reset the frameCounter to 0
                        self.frameCount = 0.0
                    }
                } else {
                    // The player is out of lives
                    self.switchToGameOver()
                }
            
            case GameState.Paused:
                return
                
            case GameState.GameOver:
                return
            
        }
    }
    
    // MARK: - Contact
    func didBeginContact(contact: SKPhysicsContact) {
        if self.state == GameState.Tutorial || self.state == GameState.Paused || self.state == GameState.GameOver {
            return
        } else {
            // Which body is not the player?
            let other = contact.bodyA.categoryBitMask == Contact.Player ? contact.bodyB : contact.bodyA
            
            
            if other.categoryBitMask == Contact.Meteor {
                // Player is not immune
                if !self.player.immune {
                    
                    self.player.hitMeteor()
                    self.statusBar.updateLives(lives: self.player.lives)
                    
                    if let meteor = other.node as? Meteor {
                        meteor.hitMeteor()
                    }
                    
                } else {
                    // Player is immune
                    return
                }
            }
            
            
            if other.categoryBitMask == Contact.Star {
                // Update the player's score
                self.player.pickedUpStar()
                // Update the player's score on the status bar
                self.statusBar.updateScore(score: self.player.score)
                
                if let star = other.node as? Star {
                    star.pickedUpStar()
                }
            }

        }
    }
    
    // MARK: - Touch Events
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch:UITouch = touches.first! as UITouch
        let touchLocation = touch.locationInNode(self)
        
        switch state {
        case GameState.Tutorial:
            if self.startButton.containsPoint(touchLocation) {
                // Change the state to running
                self.startButton.tapped()
                self.switchToRunning()
            }
            
            return
            
        case GameState.Running:
            self.player.updateTargetLocation(newLocation: touchLocation)
        
            
        case GameState.Paused:
            return
            
        case GameState.GameOver:
            return
        }
    }
    
    // MARK: - State Functions
    private func switchToRunning() {
        self.state = GameState.Running
        
        // Enable Player movement
        self.player.enableMovement()
        
        // Move Player up to the StartButton location
        self.player.updateTargetLocation(newLocation: self.startButton.position)
        
        // Fade the StartButton out and remove it from the scene
        self.startButton.fadeStartButton()
        
        // Start the background
        self.background.startBackground()
        
        // Start sending meteors
        self.meteorController.startSendingMeteors()
        
        // Start sending stars
        self.starController.startSendingStars()
    }
    
    private func switchToPaused() {
        self.state = GameState.Paused
    }
    
    private func switchToResume() {
        self.state = GameState.Running
    }
    
    private func switchToGameOver() {
        self.state = GameState.GameOver
        
        // Disable Player movement
        self.player.disableMovement()
        
        // Run the gameOver function to check scores
        self.player.gameOver()
        
        // Stop the background
        self.background.stopBackground()
        
        // Stop sending meteors
        self.meteorController.stopSendingMeteors()
        
        // Stop sending stars
        self.starController.stopSendingStars()
        
        // Load the GameOverScene after a 1.5 second delay.
        self.runAction(SKAction.waitForDuration(1.5), completion: {
            self.loadGameOverScene()
        })
    }
    
    // MARK: - Load Scene
    private func loadGameOverScene() {
        let gameOverScene = GameOverScene(size: kViewSize)
        let transition = SKTransition.fadeWithColor(SKColor.blackColor(), duration: 0.25)
        
        self.view?.presentScene(gameOverScene, transition: transition)
    }
    
    // MARK: - Scoring functions
    private func updateDistanceTick() {
        self.player.updatePlayerScore(score: 1)
        self.statusBar.updateScore(score: self.player.score)
    }
}
