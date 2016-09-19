//
//  StatusBar.swift
//  SpaceRunner
//
//  Created by Jeremy Novak on 9/8/16.
//  Copyright © 2016 Spritekit Book. All rights reserved.
//

import SpriteKit

class StatusBar: SKNode {
    
    // MARK: - Private class variables
    private var barBackground = SKSpriteNode()
    private var scoreLabel = SKLabelNode()
    private var starsIcon = SKSpriteNode()
    private var starsLabel = SKLabelNode()
    
    // MARK: - Init
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init() {
        super.init()
    }
    
    convenience init(lives: Int, score: Int, stars: Int) {
        self.init()
        
        setupBarBackground()
        setupScore(score: score)
        setupStarsCollected(collected: stars)
        
        updateLives(lives: lives)
    }
    
    // MARK: - Setup
    private func setupBarBackground() {
        // Make a CGRect that is as wide as the screen an 5% of the height of the screen
        let barBackgroundSize = CGSize(width: kViewSize.width, height: kViewSize.height * 0.05)
        
        // Make an SKSpriteNode that is a Black color and the size of statusBarBackgroundSize
        barBackground = SKSpriteNode(color: SKColor.black, size: barBackgroundSize)
        
        // Make the anchorPoint 0,0 so it is positioned using the lower left corner
        barBackground.anchorPoint = CGPoint.zero
        
        // Position statusBarBackground on the left edge of the screen and 95% up the screen
        barBackground.position = CGPoint(x: 0, y: kViewSize.height * 0.95)
        
        // Set the alpha to 75% opacity
        barBackground.alpha = 0.75
        
        self.addChild(barBackground)
    }
    
    private func setupScore(score: Int) {
        // Static Label
        let scoreText = GameFonts.sharedInstance.createLabel(string: "Score: ", type: .label)
        scoreText.position = CGPoint(x: barBackground.size.width * 0.6, y: barBackground.size.height / 2)
        barBackground.addChild(scoreText)
        
        // Score Label
        self.scoreLabel = GameFonts.sharedInstance.createLabel(string: String(score), type: .label)
        let offsetX = barBackground.size.width * 0.75
        let offsetY = barBackground.size.height / 2
        scoreLabel.position = CGPoint(x: offsetX, y: offsetY)
        barBackground.addChild(self.scoreLabel)
    }
    
    private func setupStarsCollected(collected: Int) {
        // Collected Stars Icon
        starsIcon = SKSpriteNode(texture: GameTextures.sharedInstance.texture(name: SpriteName.starIcon))
        
        let starOffsetX = barBackground.size.width / 2 - starsIcon.size.width * 2
        let starOffsetY = barBackground.size.height / 2
        
        starsIcon.position = CGPoint(x: starOffsetX, y: starOffsetY)
        
        // Collected Stars Label
        starsLabel = GameFonts.sharedInstance.createLabel(string: String(collected), type: .label)
        
        let labelOffsetX = barBackground.size.width / 2
        let labelOffsetY = barBackground.size.height / 2
        
        starsLabel.position = CGPoint(x: labelOffsetX, y: labelOffsetY)
        
        barBackground.addChild(starsIcon)
        barBackground.addChild(starsLabel)
        
        // Rotate the starsCollectedIcon forever
        starsIcon.run(SKAction.repeatForever(SKAction.rotate(byAngle: 1.0, duration: 2.5)))
    }
    
    // MARK: - Animations
    private func animate() -> SKAction {
        let scaleUp = SKAction.scale(to: 1.5, duration: 0.12)
        let scaleNormal = SKAction.scale(to: 1.0, duration: 0.12)
        let scaleSequence = SKAction.sequence([scaleUp, scaleNormal])
        
        return scaleSequence
    }
    
    // MARK: - Updates
    func updateScore(score: Int) {
        self.scoreLabel.text = String(score)
    }
    
    func updateStars(collected: Int) {
        starsLabel.text = String(collected)
        
        starsIcon.run(animate())
        scoreLabel.run(animate())
    }
    
    func updateLives(lives: Int) {
        // First clear all of the sprites
        barBackground.enumerateChildNodes(withName: SpriteName.playerLives) { node, _ in
            if let livesSprite = node as? SKSpriteNode {
                livesSprite.removeFromParent()
            }
        }
        
        // Get the X and Y points where we should draw the sprites
        var offsetX = CGFloat()
        let offsetY = barBackground.size.height / 2
        
        // Redraw the sprites
        for i in 0..<lives  {
            let livesSprite = GameTextures.sharedInstance.sprite(name: SpriteName.playerLives)
            
            offsetX = livesSprite.size.width + livesSprite.size.width * 1.5 * CGFloat(i)
            
            livesSprite.position = CGPoint(x: offsetX, y: offsetY)
            
            livesSprite.name = SpriteName.playerLives
            
            barBackground.addChild(livesSprite)
        }
    }

}
