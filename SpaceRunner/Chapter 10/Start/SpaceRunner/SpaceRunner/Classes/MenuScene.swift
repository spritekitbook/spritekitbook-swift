//
//  MenuScene.swift
//  SpaceRunner
//
//  Created by Jeremy Novak on 1/19/16.
//  Copyright © 2016 Jeremy Novak. All rights reserved.
//

import SpriteKit

class MenuScene:SKScene {
    
    // MARK: - Private class constants
    private let background = Background()
    private let playButton = PlayButton()
    private let gameTitle = GameTitle()
    private let gameTitleShip = GameTitleShip()
    
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
        GameAudio.sharedInstance.playBackgroundMusic(fileName: Music.Game)
        self.setupMenuScene()
    }
    
    // MARK: - Setup
    private func setupMenuScene() {
        // Set the background color to Colors.Background
        self.backgroundColor = Colors.colorFromRGB(rgbvalue: Colors.Background)
        self.addChild(self.background)
        
        self.addChild(self.playButton)
        
        self.addChild(self.gameTitle)
        self.addChild(self.gameTitleShip)
    }
    
    // MARK: - Update
    override func update(currentTime: NSTimeInterval) {
    }
    
    // MARK: Touch Events
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch:UITouch = touches.first! as UITouch
        let touchLocation = touch.locationInNode(self)
        
        if self.playButton.containsPoint(touchLocation) {
            
            self.playButton.tapped()
            
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
