//
//  GameTitleShip.swift
//  SpaceRunner
//
//  Created by Jeremy Novak on 1/20/16.
//  Copyright © 2016 Jeremy Novak. All rights reserved.
//

import SpriteKit

class GameTitleShip:SKSpriteNode {
    
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
        let texture = GameTextures.sharedInstance.textureWithName(name: SpriteName.TitleGameShip)
        self.init(texture: texture, color: SKColor.whiteColor(), size: texture.size())
        
        self.setupGameTitleShip()
    }
    
    // MARK: - Setup
    private func setupGameTitleShip() {
        // Offscreen lower left corner
        self.position = CGPoint(x: kViewSize.width / 2, y: kViewSize.height / 2)
    }
}