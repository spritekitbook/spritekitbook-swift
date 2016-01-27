//
//  PauseButton.swift
//  SpaceRunner
//
//  Created by Jeremy Novak on 1/26/16.
//  Copyright © 2016 Jeremy Novak. All rights reserved.
//

import SpriteKit

class PauseButton:SKSpriteNode {
    
    // MARK: - Private class constants
    private let pauseTexture = GameTextures.sharedInstance.textureWithName(name: SpriteName.ButtonPause)
    private let resumeTexture = GameTextures.sharedInstance.textureWithName(name: SpriteName.ButtonResume)
    
    // MARK: - Private class variables
    private var gamePaused = false
    
    // MARK: - Init
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    
    convenience init() {
        let texture = GameTextures.sharedInstance.textureWithName(name: SpriteName.ButtonPause)
        self.init(texture: texture, color: SKColor.whiteColor(), size: texture.size())
        
        self.setupPauseButton()
    }
    
    // MARK: - Setup
    private func setupPauseButton() {
        // Put the anchorPoint in the top right corner of the sprite
        self.anchorPoint = CGPoint(x: 1.0, y: 1.0)
        
        // Position at top right corner of screen
        self.position = CGPoint(x: kViewSize.width, y: kViewSize.height)
    }
    
    // MARK: - Actions
    func tapped() {
        self.runAction(GameAudio.sharedInstance.soundButtonTap)
        
        // Flip the value of gamePaused
        self.gamePaused = !self.gamePaused
        
        // Which texture should we use?
        self.texture = self.gamePaused ? self.resumeTexture : self.pauseTexture
    }
    
    func getPauseState() -> Bool {
        return self.gamePaused
    }
}
