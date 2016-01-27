//
//  GameOverTitle.swift
//  SpaceRunner
//
//  Created by Jeremy Novak on 1/25/16.
//  Copyright © 2016 Jeremy Novak. All rights reserved.
//

import SpriteKit

class GameOverTitle:SKSpriteNode {
    
    // MARK: - Init
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    
    convenience init() {
        let texture = GameTextures.sharedInstance.textureWithName(name: SpriteName.TitleGameOver)
        self.init(texture: texture, color: SKColor.whiteColor(), size: texture.size())
        
        self.setupGameOverTitle()
    }
    
    // MARK: - Setup
    private func setupGameOverTitle() {
        self.position = CGPoint(x: kViewSize.width / 2, y: kViewSize.height * 0.7)
    }
}