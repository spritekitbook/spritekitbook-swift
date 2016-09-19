//
//  StartButton.swift
//  SpaceRunner
//
//  Created by Jeremy Novak on 8/26/16.
//  Copyright © 2016 Spritekit Book. All rights reserved.
//

import SpriteKit

class PlayButton: SKSpriteNode {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    
    convenience init() {
        let texture = GameTextures.sharedInstance.texture(name: SpriteName.playButton)
        self.init(texture: texture, color: SKColor.white, size: texture.size())
        
        setup()
    }
    
    private func setup() {
        self.position = CGPoint(x: kViewSize.width / 2, y: kViewSize.height * 0.3)
    }
    
    func tapped() {
        self.run(GameAudio.sharedInstance.playClip(type: .button))
    }

}
