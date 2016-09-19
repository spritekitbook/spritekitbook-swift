//
//  GameParticles.swift
//  SpaceRunner
//
//  Created by Jeremy Novak on 8/30/16.
//  Copyright © 2016 Spritekit Book. All rights reserved.
//

import SpriteKit

class GameParticles {
    
    static let sharedInstance = GameParticles()
    
    // MARK: Class Enum
    enum Particles:Int {
        case background, engine
    }
    
    // MARK: - Private class variables
    private var backgroundEmitter = SKEmitterNode()
    private var engineEmitter = SKEmitterNode()
    
    init() {
        setupBackgroundEmitter()
        setupEngineEmitter()
    }
    
    private func setupBackgroundEmitter() {
        
        // Birthrate and Lifetime
        backgroundEmitter.particleBirthRate = 25.0
        backgroundEmitter.particleLifetime = 5.0
        backgroundEmitter.particleLifetimeRange = 5.0
        
        // Position Range
        backgroundEmitter.position = CGPoint(x: kViewSize.width / 2, y: kViewSize.height)
        backgroundEmitter.particlePositionRange = CGVector(dx: kViewSize.width, dy: kViewSize.height * 2)
        
        // Speed
        backgroundEmitter.particleSpeed = 200.0
        backgroundEmitter.particleSpeedRange = backgroundEmitter.particleSpeed / 4
        
        // Emission Angle
        backgroundEmitter.emissionAngle = DegreesToRadians(degrees: -90.0)
        backgroundEmitter.emissionAngleRange = DegreesToRadians(degrees: 15)
        
        // Alpha
        backgroundEmitter.particleAlpha = 0.5
        backgroundEmitter.particleAlphaRange = 0.25
        backgroundEmitter.particleAlphaSpeed = -0.125
        
        // Color blending
        backgroundEmitter.particleColorBlendFactor = 0.5
        backgroundEmitter.particleColorBlendFactorRange = 0.25
        
        // Color
        backgroundEmitter.particleColor = Colors.colorFromRGB(rgbvalue: Colors.dust)
        
        // Texture
        backgroundEmitter.particleTexture = GameTextures.sharedInstance.texture(name: SpriteName.magic)
    }
    
    private func setupEngineEmitter() {
        
        // Birthrate and Lifetime
        engineEmitter.particleBirthRate = 25.0
        engineEmitter.particleLifetime = 0.5
        
        // Position Range
        engineEmitter.particlePositionRange = CGVector(dx: 0, dy: 0)
        
        // Angle
        engineEmitter.emissionAngle = DegreesToRadians(degrees: 90)
        
        // Speed
        engineEmitter.particleSpeed = -80.0
        
        // Color Blending
        engineEmitter.particleColorBlendFactor = 1.0
        
        // Color
        engineEmitter.particleColor = Colors.colorFromRGB(rgbvalue: Colors.engine)
        
        // Texture
        engineEmitter.particleTexture = GameTextures.sharedInstance.texture(name: SpriteName.magic)
        
    }
    
    // MARK: - Public methods
    func createParticles(particles: Particles) -> SKEmitterNode {
        switch particles {
        case .background:
            return backgroundEmitter.copy() as! SKEmitterNode
            
        case .engine:
            return engineEmitter.copy() as! SKEmitterNode
        }
    }
}
