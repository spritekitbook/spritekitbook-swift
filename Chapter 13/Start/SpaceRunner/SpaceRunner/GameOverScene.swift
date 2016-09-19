//
//  GameOverScene.swift
//  SpaceRunner
//
//  Created by Jeremy Novak on 8/19/16.
//  Copyright © 2016 Spritekit Book. All rights reserved.
//

import SpriteKit

class GameOverScene: SKScene {
    
    // MARK: - Private instance constants
    private let background = Background()
    private let retryButton = RetryButton()
    private let gameOverTitle = GameOverTitle()

    
    // MARK: - Init
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(size: CGSize) {
        super.init(size: size)
    }
    
    convenience init(size: CGSize, score: Int, stars: Int, streak: Int) {
        self.init(size: size)
        
        self.setup(score: score, stars: stars, streak: streak)
    }
    
    // MARK: - Setup
    private func setup(score: Int, stars: Int, streak: Int) {
        self.backgroundColor = Colors.colorFromRGB(rgbvalue: Colors.background)
        
        self.addChild(background)
        self.addChild(retryButton)
        self.addChild(gameOverTitle)
        
        let scoreBoard = ScoreBoard(score: score, stars: stars, streak: streak)
        self.addChild(scoreBoard)
    }
    
    // MARK: - Update
    override func update(_ currentTime: TimeInterval) {
    }
    
    // MARK: - Touch Handling
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch:UITouch = touches.first! as UITouch
        let touchLocation = touch.location(in: self)
        
        if retryButton.contains(touchLocation) {
            retryButton.tapped()
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
