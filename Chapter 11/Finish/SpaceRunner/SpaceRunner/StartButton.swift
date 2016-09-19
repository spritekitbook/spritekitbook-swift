//
//  StartButton.swift
//  SpaceRunner
//
//  Created by Jeremy Novak on 9/7/16.
//  Copyright © 2016 Spritekit Book. All rights reserved.
//

import SpriteKit

class StartButton: SKSpriteNode {
    
    // MARK: - Init
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    
    convenience init() {
        let texture = GameTextures.sharedInstance.texture(name: SpriteName.startButton)
        self.init(texture: texture, color: SKColor.white, size: texture.size())
        
        setup()
    }
    
    // MARK: - Setup
    private func setup() {
        self.position = kScreenCenter
    }
    
    
    // MARK: - Touch Events
    func buttonTapped() {
        animateOut()
    }
    
    // MARK: - Animations
    private func animateOut() {
        self.run(SKAction.fadeOut(withDuration: 0.5), completion: {
            [weak self] in
            self?.removeFromParent()
        })
    }
}
