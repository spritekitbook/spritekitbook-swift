//
//  StatusBar.swift
//  SpaceRunner
//
//  Created by Jeremy Novak on 1/24/16.
//  Copyright © 2016 Jeremy Novak. All rights reserved.
//

import SpriteKit


class StatusBar:SKNode {
    
    // MARK: - Private class variables
    private var statusBarBackground = SKSpriteNode()
    private var scoreLabel = SKLabelNode()
    private var starsCollectedIcon = SKSpriteNode()
    private var starsCollectedLabel = SKLabelNode()
    
    // MARK: - Public class constants
    internal let pauseButton = PauseButton()
    
    // MARK: - Init
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init() {
        super.init()
    }
    
    convenience init(lives: Int, score: Int, stars: Int) {
        self.init()
        
        self.setupStatusBar()
        self.setupStatusBarBackground()
        self.setupStatusBarScore(score: score)
        self.updateLives(lives: lives)
        self.setupStatusBarStarsCollected(collected: stars)
        self.setupPauseButton()
    }
    
    // MARK: - Setup
    private func setupStatusBar() {
    }
    
    private func setupStatusBarBackground() {
        // Make a CGRect that is as wide as the screen an 5% of the height of the screen
        let statusBarBackgroundSize = CGSizeMake(kViewSize.width, kViewSize.height * 0.05)
        
        // Make an SKSpriteNode that is a Black color and the size of statusBarBackgroundSize
        self.statusBarBackground = SKSpriteNode(color: SKColor.blackColor(), size: statusBarBackgroundSize)
        
        // Make the anchorPoint 0,0 so it is positioned using the lower left corner
        self.statusBarBackground.anchorPoint = CGPointZero
        
        // Position statusBarBackground on the left edge of the screen and 95% up the screen
        self.statusBarBackground.position = CGPoint(x: 0, y: kViewSize.height * 0.95)
        
        // Set the alpha to 75% opacity
        self.statusBarBackground.alpha = 0.75
        
        // Add statusBarBackground to the StatusBar node
        self.addChild(self.statusBarBackground)
    }
    
    private func setupStatusBarScore(score score: Int) {
        // Static Label
        let scoreText = GameFonts.sharedInstance.createLabel(string: "Score: ", labelType: GameFonts.LabelType.StatusBar)
        scoreText.position = CGPoint(x: self.statusBarBackground.size.width * 0.6, y: self.statusBarBackground.size.height / 2)
        self.statusBarBackground.addChild(scoreText)
        
        // Score Label
        self.scoreLabel = GameFonts.sharedInstance.createLabel(string: String(score), labelType: GameFonts.LabelType.StatusBar)
        let offsetX = self.statusBarBackground.size.width * 0.75
        let offsetY = self.statusBarBackground.size.height / 2
        self.scoreLabel.position = CGPoint(x: offsetX, y: offsetY)
        self.statusBarBackground.addChild(self.scoreLabel)
    }
    
    
    private func setupStatusBarStarsCollected(collected collected: Int) {
        // Collected Stars Icon
        self.starsCollectedIcon = SKSpriteNode(texture: GameTextures.sharedInstance.textureWithName(name: SpriteName.StarIcon))
        
        let starOffsetX = self.statusBarBackground.size.width / 2 - self.starsCollectedIcon.size.width * 2
        let starOffsetY = self.statusBarBackground.size.height / 2
        
        self.starsCollectedIcon.position = CGPoint(x: starOffsetX, y: starOffsetY)
        
        // Collected Stars Label
        self.starsCollectedLabel = GameFonts.sharedInstance.createLabel(string: String(collected), labelType: GameFonts.LabelType.StatusBar)
        
        let labelOffsetX = self.statusBarBackground.size.width / 2
        let labelOffsetY = self.statusBarBackground.size.height / 2
        
        self.starsCollectedLabel.position = CGPoint(x: labelOffsetX, y: labelOffsetY)
        
        self.statusBarBackground.addChild(self.starsCollectedIcon)
        self.statusBarBackground.addChild(self.starsCollectedLabel)
        
        // Rotate the starsCollectedIcon forever
        self.starsCollectedIcon.runAction(SKAction.repeatActionForever(SKAction.rotateByAngle(1.0, duration: 2.5)))
    }
    
    
    private func setupPauseButton() {
        self.addChild(self.pauseButton)
    }
    
    
    // MARK: - Public functions
    func updateScore(score score: Int) {
        self.scoreLabel.text = String(score)
    }
    
    func updateStarsCollected(collected collected: Int) {
        self.starsCollectedLabel.text = String(collected)
        
        self.starsCollectedIcon.runAction(self.animateBounce())
        self.scoreLabel.runAction(self.animateBounce())
    }
    
    func updateLives(lives lives: Int) {
        // First clear all of the sprites
        self.statusBarBackground.enumerateChildNodesWithName(SpriteName.PlayerLives) { node, _ in
            if let livesSprite = node as? SKSpriteNode {
                livesSprite.removeFromParent()
            }
        }
        
        // Get the X and Y points where we should draw the sprites
        var offsetX = CGFloat()
        let offsetY = self.statusBarBackground.size.height / 2
        
        // Redraw the sprites
        for i in 0..<lives  {
            let livesSprite = GameTextures.sharedInstance.spriteWithName(name: SpriteName.PlayerLives)
            
            offsetX = livesSprite.size.width + livesSprite.size.width * 1.5 * CGFloat(i)
            
            livesSprite.position = CGPoint(x: offsetX, y: offsetY)
            
            livesSprite.name = SpriteName.PlayerLives
            
            self.statusBarBackground.addChild(livesSprite)
        }
    }
    
    // MARK: - Animations
    private func animateBounce() -> SKAction {
        let scaleUp = SKAction.scaleTo(1.5, duration: 0.12)
        let scaleNormal = SKAction.scaleTo(1.0, duration: 0.12)
        let scaleSequence = SKAction.sequence([scaleUp, scaleNormal])
        
        return scaleSequence
    }
}
