//
//  MenuScene.swift
//  SpaceRunner
//
//  Created by Jeremy Novak on 1/19/16.
//  Copyright © 2016 Jeremy Novak. All rights reserved.
//

import SpriteKit

class MenuScene:SKScene {
    
    // MARK: - Private class variables
    private var sceneLabel = SKLabelNode()
    
    // MARK: - Init
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(size: CGSize) {
        super.init(size: size)
    }
    
    override func didMoveToView(view: SKView) {
        self.setupMenuScene()
    }
    
    // MARK: - Setup
    private func setupMenuScene() {
        // Set the background color to Black
        self.backgroundColor = SKColor.blackColor()
        
        // Initialize the temporary label and add it to the scene
        self.sceneLabel.fontName = "Chalkduster"
        self.sceneLabel.fontColor = SKColor.whiteColor()
        self.sceneLabel.fontSize = kViewSize.width * 0.1
        self.sceneLabel.text = "Menu Scene"
        self.sceneLabel.position = CGPoint(x: kViewSize.width / 2, y: kViewSize.height / 2)
        
        self.addChild(self.sceneLabel)
    }
    
    // MARK: - Update
    override func update(currentTime: NSTimeInterval) {
    }
    
    // MARK: Touch Events
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch:UITouch = touches.first! as UITouch
        let touchLocation = touch.locationInNode(self)
        
        if self.sceneLabel.containsPoint(touchLocation) {
            if kDebug {
                print("MenuScene: Loading Game Scene.")
            }
            
            self.loadGameScene()
        }
    }
    
    // MARK: - Load Scene
    private func loadGameScene() {
        let gameScene = GameScene(size: kViewSize)
        let transition = SKTransition.fadeWithColor(SKColor.blackColor(), duration: 0.25)
        
        self.view?.presentScene(gameScene, transition: transition)
    }
}
