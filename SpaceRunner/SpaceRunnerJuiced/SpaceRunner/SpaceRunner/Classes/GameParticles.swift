//
//  GameParticles.swift
//  SpaceRunner
//
//  Created by Jeremy Novak on 1/20/16.
//  Copyright © 2016 Jeremy Novak. All rights reserved.
//

import SpriteKit

let GameParticlesSharedInstance = GameParticles()

class GameParticles {
    
    class var sharedInstance:GameParticles {
        return GameParticlesSharedInstance
    }
    
    // MARK: - Public class enum
    internal enum Particles:Int {
        case Magic
        case Engine
    }
    
    // MARK: - Private class properties
    private var magicParticles = SKEmitterNode()
    private var engineParticles = SKEmitterNode()
    
    // MARK: - Init
    init() {
        self.setupMagicParticles()
        self.setupEngineParticles()
    }
    
    // MARK: - Setup
    private func setupMagicParticles() {
        
        // Birthrate and Lifetime
        self.magicParticles.particleBirthRate = 35.0
        self.magicParticles.particleLifetime = 5.0
        self.magicParticles.particleLifetimeRange = 1.25
        
        // Position Range
        self.magicParticles.particlePositionRange = CGVectorMake(kViewSize.width * 2, kViewSize.height * 2)
        
        // Speed
        self.magicParticles.particleSpeed = -200.0
        self.magicParticles.particleSpeedRange = self.magicParticles.particleSpeed / 4
        
        // Emission Angle
        self.magicParticles.emissionAngle = DegreesToRadians(degrees: 90.0)
        self.magicParticles.emissionAngleRange = DegreesToRadians(degrees: 15)
        
        // Alpha
        self.magicParticles.particleAlpha = 0.5
        self.magicParticles.particleAlphaRange = 0.25
        self.magicParticles.particleAlphaSpeed = -0.125
        
        // Color blending
        self.magicParticles.particleColorBlendFactor = 0.5
        self.magicParticles.particleColorBlendFactorRange = 0.25
        
        // Color
        self.magicParticles.particleColor = Colors.colorFromRGB(rgbvalue: Colors.Magic)
        
        // Texture
        self.magicParticles.particleTexture = GameTextures.sharedInstance.textureWithName(name: SpriteName.Magic)
    }
    
    private func setupEngineParticles() {
        
        // Birthrate and Lifetime
        self.engineParticles.particleBirthRate = 25.0
        self.engineParticles.particleLifetime = 0.5
        
        // Position Range
        self.engineParticles.particlePositionRange = CGVectorMake(0, 0)
        
        // Angle
        self.engineParticles.emissionAngle = DegreesToRadians(degrees: 90)
        //self.engineParticles.emissionAngleRange = DegreesToRadians(degrees: 5.0)
        
        // Speed
        self.engineParticles.particleSpeed = -80.0
        
        // Scale
        self.engineParticles.particleScale = kDeviceTablet ? 0.75 : 0.25
        
        // Color Blending
        self.engineParticles.particleColorBlendFactor = 1.0
        
        // Color
        self.engineParticles.particleColor = Colors.colorFromRGB(rgbvalue: Colors.Engine)
        
        // Texture
        self.engineParticles.particleTexture = GameTextures.sharedInstance.textureWithName(name: SpriteName.Magic)
        
    }
    
    // MARK: - Public functions
    func createParticle(particles particles: Particles) -> SKEmitterNode {
        switch particles {
            case Particles.Magic:
                return self.magicParticles.copy() as! SKEmitterNode
            
            case Particles.Engine:
                return self.engineParticles.copy() as! SKEmitterNode
            
        }
    }
}
