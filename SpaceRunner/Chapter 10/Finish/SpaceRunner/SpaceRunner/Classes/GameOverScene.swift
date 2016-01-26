//
//  GameOverScene.swift
//  SpaceRunner
//
//  Created by Jeremy Novak on 1/19/16.
//  Copyright © 2016 Jeremy Novak. All rights reserved.
//

import SpriteKit

class GameOverScene:SKScene {
    
    // MARK: - Private class constants
    private let background = Background()
    private let retryButton = RetryButton()
    private let gameOverTitle = GameOverTitle()
    
    // MARK: - Private class variables
    private var scoreBoard = ScoreBoard()
    
    // MARK: - Init
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(size: CGSize) {
        super.init(size: size)
    }
    
    
    convenience init(size: CGSize, score: Int, stars: Int, streak: Int) {
        self.init(size: size)
        
        self.setupScoreBoard(score: score, stars: stars, streak: streak)
    }
    
    override func didMoveToView(view: SKView) {
        self.setupGameOverScene()
    }
    
    // MARK: - Setup
    private func setupGameOverScene() {
        // Set the background color to Colors.Background
        self.backgroundColor = Colors.colorFromRGB(rgbvalue: Colors.Background)
        
        
        self.addChild(self.background)
        
        self.addChild(self.retryButton)
        
        self.addChild(self.gameOverTitle)
    }
    
    
    private func setupScoreBoard(score score: Int, stars: Int, streak: Int) {
        // Retrieve the best score, stars and streak
        let bestScore = GameSettings.sharedInstance.getBestScore()
        let bestStars = GameSettings.sharedInstance.getBestStars()
        let bestStreak = GameSettings.sharedInstance.getBestStreak()
        
        self.scoreBoard = ScoreBoard(score: score, bestScore: bestScore, streak: streak, bestStreak: bestStreak, stars: stars, bestStars: bestStars)
        
        self.addChild(self.scoreBoard)
    }
    
    // MARK: - Update
    override func update(currentTime: NSTimeInterval) {
    }
    
    // MARK: Touch Events
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch:UITouch = touches.first! as UITouch
        let touchLocation = touch.locationInNode(self)
        
        if self.retryButton.containsPoint(touchLocation) {
            
            self.retryButton.tapped()
            
            self.loadGameScene()
        }
    }
    
    // MARK: - Load Scene
    private func loadMenuScene() {
        let menuScene = MenuScene(size: kViewSize)
        let transition = SKTransition.fadeWithColor(SKColor.blackColor(), duration: 0.25)
        
        self.view?.presentScene(menuScene, transition: transition)
    }
    
    private func loadGameScene() {
        let gameScene = GameScene(size: kViewSize)
        let transition = SKTransition.fadeWithColor(SKColor.blackColor(), duration: 0.25)
        
        self.view?.presentScene(gameScene, transition: transition)
    }
}
