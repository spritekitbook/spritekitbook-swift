//
//  GameScene.swift
//  SpaceRunner
//
//  Created by Jeremy Novak on 1/19/16.
//  Copyright (c) 2016 Jeremy Novak. All rights reserved.
//

import SpriteKit

class GameScene:SKScene, SKPhysicsContactDelegate {
    
    // MARK: - Private class constants
    private let gameNode = SKNode()
    private let interfaceNode = SKNode()
    private let background = Background()
    private let startButton = StartButton()
    private let player = Player()
    
    // MARK: - Private class variables
    //private var sceneLabel = SKLabelNode()
    
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
        
        // Add the player to the game node
        self.gameNode.addChild(self.player)
        
        // Add the interfaceNode to the scene
        self.addChild(self.interfaceNode)
    }
    
    // MARK: - Update
    override func update(currentTime: NSTimeInterval) {
        self.player.update()
    }
    
    // MARK: Touch Events
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch:UITouch = touches.first! as UITouch
        let touchLocation = touch.locationInNode(self)
        
        if self.startButton.containsPoint(touchLocation) {
            if kDebug {
                print("Game Scene: Loading Game Over Scene.")
            }
            
            self.loadGameOverScene()
        }
        
        self.player.updateTargetLocation(newLocation: touchLocation)
    }
    
    // MARK: - Load Scene
    private func loadGameOverScene() {
        let gameOverScene = GameOverScene(size: kViewSize)
        let transition = SKTransition.fadeWithColor(SKColor.blackColor(), duration: 0.25)
        
        self.view?.presentScene(gameOverScene, transition: transition)
    }
}
