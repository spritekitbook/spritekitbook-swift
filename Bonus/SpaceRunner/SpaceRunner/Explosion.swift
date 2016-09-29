//
//  Explosion.swift
//  SpaceRunner
//
//  Created by Jeremy Novak on 9/14/16.
//  Copyright © 2016 Spritekit Book. All rights reserved.
//

import SpriteKit

class Explosion: SKNode {
    
    // MARK: - Private class constants
    private let particles = SKEmitterNode(fileNamed: "Explosion.sks")
    
    // MARK: - Init
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init() {
        super.init()
        
        self.setup()
    }
    
    // MARK: - Setup
    private func setup() {
        particles?.alpha = 0.0
        
        self.addChild(particles!)
    }
    
    // MARK: - Animation
    func animate(position: CGPoint) {
        particles?.position = position
        
        particles?.alpha = 1.0
        
        particles?.run(SKAction.wait(forDuration: 0.35), completion: {
            [weak self] in
            self?.particles?.alpha = 0.0
        })
        
    }
    
}
