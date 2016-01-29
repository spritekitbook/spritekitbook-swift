//
//  ScoreBoard.swift
//  SpaceRunner
//
//  Created by Jeremy Novak on 1/25/16.
//  Copyright © 2016 Jeremy Novak. All rights reserved.
//

import SpriteKit

class ScoreBoard:SKNode {
    
    // MARK: - Private convenience constants
    private let fonts = GameFonts.sharedInstance
    private let fontType = GameFonts.LabelType.StatusBar
    
    // MARK: - Private class variables
    private var background = SKShapeNode()
    private var animation = SKAction()
    
    // MARK: - Init
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init() {
        super.init()
    }
    
    convenience init(score: Int, bestScore: Int, streak: Int, bestStreak: Int, stars: Int, bestStars: Int) {
        self.init()
        
        self.setupScoreBackground()
        self.setupScores(score, bestScore: bestScore, streak: streak, bestStreak: bestStreak, stars: stars, bestStars: bestStars)
        
        self.setupAnimation()
        
        self.animateIn()
    }
    
    // MARK: - Setup
    private func setupScoreBackground() {
        // Rectangle that is 90% of the width and 25% of the height of the screen
        let backgroundRect = CGRectMake(0, 0, kViewSize.width * 0.9, kViewSize.height * 0.25)
        
        // Make an SKShapeNode with a rect with a rounded corner
        self.background = SKShapeNode(rect: backgroundRect, cornerRadius: 5.0)
        
        // Give background a border stroke
        self.background.strokeColor = Colors.colorFromRGB(rgbvalue: Colors.Border)
        self.background.lineWidth = 1.5
        
        self.background.position = CGPoint(x: -kViewSize.width * 2, y: kViewSize.height * 0.35)
        
        self.addChild(self.background)
    }
    
    private func setupScores(score: Int, bestScore: Int, streak: Int, bestStreak: Int, stars: Int, bestStars: Int) {
        // Width and Height convience 
        let frameWidth = self.background.frame.width
        let frameHeight = self.background.frame.height
        
        
        // Labels
        let scoreLabel = fonts.createLabel(string: "Score: ", labelType: fontType)
        let streakLabel = fonts.createLabel(string: "Streak: ", labelType: fontType)
        let starsLabel = fonts.createLabel(string: "Stars: ", labelType: fontType)
        
        
        let bestScoreLabel = fonts.createLabel(string: "Best: ", labelType: fontType)
        let bestStreakLabel = fonts.createLabel(string: "Best: ", labelType: fontType)
        let bestStarsLabel = fonts.createLabel(string: "Best: ", labelType: fontType)

        
        // Scores
        let scoreValue = fonts.createLabel(string: String(score), labelType: fontType)
        let bestScoreValue = fonts.createLabel(string: String(bestScore), labelType: fontType)
        
        let streakValue = fonts.createLabel(string: String(streak), labelType: fontType)
        let bestStreakValue = fonts.createLabel(string: String(bestStreak), labelType: fontType)
        
        let starsValue = fonts.createLabel(string: String(stars), labelType: fontType)
        let bestStarsValue = fonts.createLabel(string: String(bestStars), labelType: fontType)

        
        // Positioning
        scoreLabel.position = CGPoint(x: frameWidth * 0.05, y: frameHeight * 0.75)
        scoreValue.position = CGPoint(x: frameWidth * 0.25, y: frameHeight * 0.75)
        
        bestScoreLabel.position = CGPoint(x: frameWidth * 0.5, y: frameHeight * 0.75)
        bestScoreValue.position = CGPoint(x: frameWidth * 0.7, y: frameHeight * 0.75)
        
        starsLabel.position = CGPoint(x: frameWidth * 0.05, y: frameHeight * 0.5)
        starsValue.position = CGPoint(x: frameWidth * 0.25, y: frameHeight * 0.5)
        
        bestStarsLabel.position = CGPoint(x: frameWidth * 0.5, y: frameHeight * 0.5)
        bestStarsValue.position = CGPoint(x: frameWidth * 0.7, y: frameHeight * 0.5)
        
        streakLabel.position = CGPoint(x: frameWidth * 0.05, y: frameHeight * 0.25)
        streakValue.position = CGPoint(x: frameWidth * 0.25, y: frameHeight * 0.25)
        
        bestStreakLabel.position = CGPoint(x: frameWidth * 0.5, y: frameHeight * 0.25)
        bestStreakValue.position = CGPoint(x: frameWidth * 0.7, y: frameHeight * 0.25)
        
        // Add to the background
        self.background.addChild(scoreLabel)
        self.background.addChild(scoreValue)
        
        self.background.addChild(bestScoreLabel)
        self.background.addChild(bestScoreValue)
        
        self.background.addChild(starsLabel)
        self.background.addChild(starsValue)
        
        self.background.addChild(bestStarsLabel)
        self.background.addChild(bestStarsValue)
        
        self.background.addChild(streakLabel)
        self.background.addChild(streakValue)
        
        self.background.addChild(bestStreakLabel)
        self.background.addChild(bestStreakValue)
    }
    
    private func setupAnimation() {
        let moveIn = SKAction.moveTo(CGPoint(x: kViewSize.width * 0.05, y: kViewSize.height * 0.35), duration: 0.5)
        let scaleUp = SKAction.scaleTo(1.1, duration: 0.125)
        let scaleDown = SKAction.scaleTo(1.0, duration: 0.125)
        
        self.animation = SKAction.sequence([moveIn, scaleUp, scaleDown])
    }
    
    // MARK: - Animation
    private func animateIn() {
        self.background.runAction(self.animation)
    }
}
