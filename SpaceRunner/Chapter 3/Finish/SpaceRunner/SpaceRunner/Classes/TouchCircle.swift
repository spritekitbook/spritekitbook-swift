//
//  TouchCircle.swift
//  SpaceRunner
//
//  Created by Jeremy Novak on 1/21/16.
//  Copyright © 2016 Jeremy Novak. All rights reserved.
//

import SpriteKit

class TouchCircle:SKSpriteNode {
    
    // MARK: - Init
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    
    convenience init() {
        let texture = GameTextures.sharedInstance.textureWithName(name: SpriteName.TouchCircle)
        self.init(texture: texture, color: SKColor.whiteColor(), size: texture.size())
        
        self.setupTouchCircle()
    }
    
    // MARK: - Setup
    private func setupTouchCircle() {
        self.alpha = 0.0
        
        self.name = "TouchCircle"
    }
    
    // MARK: - Animations
    func animateTouchCircle(atPosition atPosition: CGPoint) {
        self.position = atPosition
        
        // Fade/Scale In
        let fadeIn = SKAction.fadeAlphaTo(0.5, duration: 0.15)
        let scaleIn = SKAction.scaleTo(1.1, duration: 0.15)
        
        // Scale in group
        let scaleInGroup = SKAction.group([fadeIn, scaleIn])
        
        let scaleInNormal = SKAction.scaleTo(1.0, duration: 0.15)
        
        // Scale in sequence
        let scaleInSequence = SKAction.sequence([scaleInGroup, scaleInNormal])
        
        
        // Run the fade/scale in sequence, then fade out
        self.runAction(SKAction.sequence([scaleInSequence, SKAction.fadeOutWithDuration(0.15), SKAction.removeFromParent()]))
    }
}
