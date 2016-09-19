//
//  GameScene.swift
//  SpaceRunner
//
//  Created by Jeremy Novak on 8/18/16.
//  Copyright © 2016 Spritekit Book. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    // MARK: - State enum
    private enum State {
        case waiting, running, paused, gameOver
    }
    
    // MARK: - Private instance constants
    private let background = Background()
    private let player = Player()
    private let meteorController = MeteorController()
    private let starController = StarController()
    private let startButton = StartButton()
    private let interfaceNode = SKNode()
    private let gameNode = SKNode()
    
    // MARK: - Private class variables
    private var lastUpdateTime:TimeInterval = 0.0
    private var state:State = .waiting
    private var frameCount:TimeInterval = 0.0
    private var statusBar = StatusBar()
    private var previousState:State = .waiting
    
    
    // MARK: - Init
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(size: CGSize) {
        super.init(size: size)
    }
    
    override func didMove(to view: SKView) {
        // Register notifications for "Pause"
        NotificationCenter.default.addObserver(self, selector: #selector(statePaused), name: NSNotification.Name(rawValue: "Pause"), object: nil)
        
        // Register notifications for "Resume"
         NotificationCenter.default.addObserver(self, selector: #selector(resumeGame), name: NSNotification.Name(rawValue: "Resume"), object: nil)
        
        self.setup()
    }
    
    // MARK: - Setup
    private func setup() {
        self.backgroundColor = Colors.colorFromRGB(rgbvalue: Colors.background)
        
        // Physics
        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        self.physicsWorld.contactDelegate = self
        
        // Add the gameNode as a child of the scene
        self.addChild(gameNode)
        
        // Make the other objects children of gameNode
        gameNode.addChild(background)
        gameNode.addChild(player)
        gameNode.addChild(meteorController)
        gameNode.addChild(starController)
        gameNode.addChild(startButton)
        
        self.addChild(interfaceNode)
        statusBar = StatusBar(lives: player.getLives(), score: player.getScore(), stars: player.getStars())
        interfaceNode.addChild(statusBar)
    }
    
    // MARK: - Update
    override func update(_ currentTime: TimeInterval) {
        let delta = currentTime - self.lastUpdateTime
        self.lastUpdateTime = currentTime
        
        
        if state != .running {
            return
        } else {
            if player.getLives() > 0 {
                player.update()
                
                frameCount += delta
                
                if frameCount >= 1.0 {
                    player.updateDistanceScore()
                    statusBar.updateScore(score: player.getScore())
                    
                    frameCount = 0.0
                }
                
                meteorController.update(delta: delta)
                starController.update(delta: delta)
            } else {
                stateGameOver()
            }
        }
    }
    
    // MARK: - Touch Handling
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch:UITouch = touches.first! as UITouch
        let touchLocation = touch.location(in: self)
        
        switch state {
        case .waiting:
            if startButton.contains(touchLocation) {
                stateRunning()
            }
            
            if statusBar.pauseButton.contains(touchLocation) {
                pauseButtonPressed()
            }
            
        case .running:
            if statusBar.pauseButton.contains(touchLocation) {
                pauseButtonPressed()
            } else {
                player.updateTargetPosition(position: touchLocation)
            }
            
            
        case .paused, .gameOver:
            if statusBar.pauseButton.contains(touchLocation) {
                pauseButtonPressed()
            }
        }
    }
    
    // MARK: - Contact
    func didBegin(_ contact: SKPhysicsContact) {
        if state != .running {
            return
        } else {
            // Which body is not the player?
            let other = contact.bodyA.categoryBitMask == Contact.player ? contact.bodyB : contact.bodyA
            
            if other.categoryBitMask == Contact.meteor {
                
                if !player.getImmunity() {
                    player.contact(body: (other.node?.name)!)
                    statusBar.updateLives(lives: player.getLives())
                    
                    if let meteor = other.node as? Meteor {
                        meteor.contact(body: player.name!)
                    }
                } else {
                    return
                }
            }
            
            if other.categoryBitMask == Contact.star {
                if let star = other.node as? Star {
                    star.contact()
                    player.pickup()
                    statusBar.updateStars(collected: player.getStars())
                }
            }
        }
    }
    
    // MARK: - State
    func stateRunning() {
        state = .running
        
        background.startBackground()
        
        player.updateTargetPosition(position: kScreenCenter)
        
        startButton.buttonTapped()
    }
    
    func statePaused() {
        previousState = state
        
        state = .paused
        
        gameNode.speed = 0.0
        
        if kDebug {
            print("Pausing")
        }
    }
    
    func stateResume() {
        state = previousState
        
        gameNode.speed = 1.0
        
        if kDebug {
            print("Resuming")
        }
    }
    
    func stateGameOver() {
        state = .gameOver
        
        background.stopBackground()
        
        player.gameOver()
        
        // Load the GameOverScene after two seconds
        self.run(SKAction.wait(forDuration: 2.0), completion: {
            [weak self] in
            self?.loadScene()
        })
    }
    
    // MARK: - Pause and Resume Game
    func resumeGame() {
        // Run a timer that resumes the game after 1 second
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(stateResume), userInfo: nil, repeats: false)
    }
    
    private func pauseButtonPressed() {
        // Flip the texture shown on the button
        statusBar.pauseButton.tapped()
        
        if statusBar.pauseButton.getPauseState() {
            // Set the state to paused
            statePaused()
            
            // Pause the gameNode
            gameNode.isPaused = true
        } else {
            // Resume the previous state
            stateResume()
            
            // Resume the gameNode
            gameNode.isPaused = false
        }
    }
    
    // MARK: - Load Scene
    private func loadScene() {
        let scene = GameOverScene(size: kViewSize, score: player.getScore(), stars: player.getStars(), streak: player.getStreak())
        let transition = SKTransition.fade(with: SKColor.black, duration: 0.5)
        
        self.view?.presentScene(scene, transition: transition)
    }
    
    // MARK: - Deinit
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

}
