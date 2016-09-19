//
//  GameScene.swift
//  SpaceRunner
//
//  Created by Jeremy Novak on 8/18/16.
//  Copyright © 2016 Spritekit Book. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    // MARK: - Private instance constants
    private let background = Background()
    private let player = Player()
    private let meteorController = MeteorController()
    
    // MARK: - Private class variables
    private var lastUpdateTime:TimeInterval = 0.0
    
    
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
    }
    
    // MARK: - Update
    override func update(_ currentTime: TimeInterval) {
        let delta = currentTime - self.lastUpdateTime
        self.lastUpdateTime = currentTime
        
        player.update()
        meteorController.update(delta: delta)
    }
    
    // MARK: - Touch Handling
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch:UITouch = touches.first! as UITouch
        let touchLocation = touch.location(in: self)
        
        player.updateTargetPosition(position: touchLocation)
    }
    
    // MARK: - Contact
    func didBegin(_ contact: SKPhysicsContact) {
        // Which body is not the player?
        let other = contact.bodyA.categoryBitMask == Contact.player ? contact.bodyB : contact.bodyA
        
        if other.categoryBitMask == Contact.meteor {
            player.contact(body: (other.node?.name)!)
            
            if let meteor = other.node as? Meteor {
                meteor.contact(body: player.name!)
            }
        }
        
        if other.categoryBitMask == Contact.star {
            // More on this in Chapter 8
            return
        }
    }
    
    // MARK: - Load Scene
    private func loadScene() {
        let scene = GameOverScene(size: kViewSize)
        let transition = SKTransition.fade(with: SKColor.black, duration: 0.5)
        
        self.view?.presentScene(scene, transition: transition)
    }

}
