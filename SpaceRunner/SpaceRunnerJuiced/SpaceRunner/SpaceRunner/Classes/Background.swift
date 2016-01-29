//
//  Background.swift
//  SpaceRunner
//
//  Created by Jeremy Novak on 1/20/16.
//  Copyright © 2016 Jeremy Novak. All rights reserved.
//

import SpriteKit

class Background:SKNode {
    
    // MARK: - Private class constants
    private let backgroundRunSpeed:CGFloat = -200.0
    private let backgroundStopSpeed:CGFloat = -25.0
    
    // MARK: - Private class variables
    private var backgroundParticles = SKEmitterNode()
    private var backgroundParticlesSmall = SKEmitterNode()
    
    // MARK: - Init
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init() {
        super.init()
        
        self.setupBackground()
    }
    
    // MARK: - Setup
    private func setupBackground() {
        self.backgroundParticles = GameParticles.sharedInstance.createParticle(particles: GameParticles.Particles.Magic)
        
        // Small white particles
        self.backgroundParticlesSmall = GameParticles.sharedInstance.createParticle(particles: GameParticles.Particles.Magic)
        self.backgroundParticlesSmall.particleScale = 0.25
        
        self.addChild(self.backgroundParticles)
        self.addChild(self.backgroundParticlesSmall)
        
        self.stopBackground()
    }
    
    // MARK: - Action
    func startBackground() {
        self.backgroundParticles.particleSpeed = self.backgroundRunSpeed
        self.backgroundParticles.particleSpeedRange = self.backgroundRunSpeed / 4
        
        self.backgroundParticlesSmall.particleSpeed = self.backgroundRunSpeed * 1.5
        self.backgroundParticlesSmall.particleSpeedRange = self.backgroundParticlesSmall.particleSpeed / 4
    }
    
    func stopBackground() {
        self.backgroundParticles.particleSpeed = self.backgroundStopSpeed
        self.backgroundParticles.particleSpeedRange = self.backgroundStopSpeed / 4
        
        self.backgroundParticlesSmall.particleSpeed = self.backgroundStopSpeed * 1.5
        self.backgroundParticlesSmall.particleSpeedRange = self.backgroundParticlesSmall.particleSpeed / 4
    }
}
