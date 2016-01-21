//
//  GameScene.swift
//  SpaceRunner
//
//  Created by Jeremy Novak on 1/19/16.
//  Copyright (c) 2016 Jeremy Novak. All rights reserved.
//

import SpriteKit

class GameScene:SKScene {
    
    // MARK: - Private class constants
    private let background = Background()
    private let startButton = StartButton()
    
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
        // Set the background color to Colors.Background
        self.backgroundColor = Colors.colorFromRGB(rgbvalue: Colors.Background)
        self.addChild(self.background)
        
        // Initialize the temporary label and add it to the scene
//        self.sceneLabel.fontName = "Chalkduster"
//        self.sceneLabel.fontColor = SKColor.whiteColor()
//        self.sceneLabel.fontSize = kViewSize.width * 0.1
//        self.sceneLabel.text = "Game Scene"
//        self.sceneLabel.position = CGPoint(x: kViewSize.width / 2, y: kViewSize.height / 2)
        
        self.addChild(self.startButton)
    }
    
    // MARK: - Update
    override func update(currentTime: NSTimeInterval) {
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
    }
    
    // MARK: - Load Scene
    private func loadGameOverScene() {
        let gameOverScene = GameOverScene(size: kViewSize)
        let transition = SKTransition.fadeWithColor(SKColor.blackColor(), duration: 0.25)
        
        self.view?.presentScene(gameOverScene, transition: transition)
    }
}
