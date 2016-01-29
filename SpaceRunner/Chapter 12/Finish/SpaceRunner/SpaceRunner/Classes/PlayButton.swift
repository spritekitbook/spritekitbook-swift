//
//  PlayButton.swift
//  SpaceRunner
//
//  Created by Jeremy Novak on 1/20/16.
//  Copyright © 2016 Jeremy Novak. All rights reserved.
//

import SpriteKit


class PlayButton:SKSpriteNode {
    
    // MARK: - Private class variables
    private var animation = SKAction()
    
    // MARK: - Init
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    
    convenience init() {
        let texture = GameTextures.sharedInstance.textureWithName(name: SpriteName.ButtonPlay)
        self.init(texture: texture, color: SKColor.whiteColor(), size: texture.size())
        
        self.setupPlayButton()
        
        self.setupAnimation()
        
        self.animateIn()
    }
    
    // MARK: - Setup
    private func setupPlayButton() {
        self.position = CGPoint(x: kViewSize.width / 2, y: -kViewSize.height + kViewSize.height / 2)
    }
    
    private func setupAnimation() {
        let moveIn = SKAction.moveTo(CGPoint(x: kViewSize.width / 2, y: kViewSize.height * 0.3), duration: 0.5)
        let scaleUp = SKAction.scaleTo(1.1, duration: 0.125)
        let scaleDown = SKAction.scaleTo(1.0, duration: 0.125)
        
        self.animation = SKAction.sequence([moveIn, scaleUp, scaleDown])
    }
    
    // MARK: - Actions
    func tapped() {
        self.runAction(GameAudio.sharedInstance.soundButtonTap)
    }
    
    // MARK: - Animations
    private func animateIn() {
        self.runAction(self.animation, completion:  {
            self.blinkPlayButton()
        })
    }
    
    private func blinkPlayButton() {
        let blink = SKAction.sequence([SKAction.waitForDuration(0.5), SKAction.fadeOutWithDuration(0.5), SKAction.fadeInWithDuration(0.5)])
        self.runAction(SKAction.repeatActionForever(blink))
        
    }
}