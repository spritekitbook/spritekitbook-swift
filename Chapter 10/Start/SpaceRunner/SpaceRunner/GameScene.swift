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
    
    // MARK: - Private class variables
    private var lastUpdateTime:TimeInterval = 0.0
    private var state:State = .waiting
    private var frameCount:TimeInterval = 0.0
    
    
    // MARK: - Init
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(size: CGSize) {
        super.init(size: size)
    }
    
    override func didMove(to view: SKView) {
        self.setup()
    }
    
    // MARK: - Setup
    private func setup() {
        self.backgroundColor = Colors.colorFromRGB(rgbvalue: Colors.background)
        
        // Physics
        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        self.physicsWorld.contactDelegate = self
        
        self.addChild(background)
        self.addChild(player)
        self.addChild(meteorController)
        self.addChild(starController)
        self.addChild(startButton)
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
            
        case .running:
            player.updateTargetPosition(position: touchLocation)
            
        case .paused:
            return
            
        case .gameOver:
            return
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
        // Addressed in later chapter on pausing
    }
    
    func stateResume() {
        // Addressed in later chapter on pausing
    }
    
    func stateGameOver() {
        state = .gameOver
        
        background.stopBackground()
    }
    
    // MARK: - Load Scene
    private func loadScene() {
        let scene = GameOverScene(size: kViewSize)
        let transition = SKTransition.fade(with: SKColor.black, duration: 0.5)
        
        self.view?.presentScene(scene, transition: transition)
    }

}
