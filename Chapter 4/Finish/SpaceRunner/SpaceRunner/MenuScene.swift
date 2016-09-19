//
//  MenuScene.swift
//  SpaceRunner
//
//  Created by Jeremy Novak on 8/19/16.
//  Copyright © 2016 Spritekit Book. All rights reserved.
//

import SpriteKit

class MenuScene: SKScene {
    
    private let logo = GameLogo()
    private let title = GameTitle()
    private let playButton = PlayButton()
    private let background = Background()
    
    
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
        
        self.addChild(background)
        self.addChild(logo)
        self.addChild(title)
        self.addChild(playButton)
    }
    
    // MARK: - Update
    override func update(_ currentTime: TimeInterval) {
    }
    
    // MARK: - Touch Handling
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch:UITouch = touches.first! as UITouch
        let touchLocation = touch.location(in: self)
        
        if playButton.contains(touchLocation) {
            loadScene()
        }
    }
    
    // MARK: - Load Scene
    private func loadScene() {
        let scene = GameScene(size: kViewSize)
        let transition = SKTransition.fade(with: SKColor.black, duration: 0.5)
        
        self.view?.presentScene(scene, transition: transition)
    }
}
