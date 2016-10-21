//
//  GameTextures.swift
//  SpaceRunner
//
//  Created by Jeremy Novak on 8/26/16.
//  Copyright © 2016 Spritekit Book. All rights reserved.
//

import SpriteKit

class GameTextures {
    
    static let sharedInstance = GameTextures()
    
    // MARK: - Private class constants
    private let gameSprites = "GameSprites"
    private let interfaceSprites = "InterfaceSprites"
    
    // MARK: - Private class variables
    private var interfaceSpritesAtlas = SKTextureAtlas()
    private var gameSpritesAtlas = SKTextureAtlas()
    
    // MARK: - Init
    init() {
        self.interfaceSpritesAtlas = SKTextureAtlas(named: interfaceSprites)
        self.gameSpritesAtlas = SKTextureAtlas(named: gameSprites)
    }
    
    // MARK: - Public convenience methods
    func texture(name: String) -> SKTexture {
        return SKTexture(imageNamed: name)
    }
    
    func sprite(name: String) -> SKSpriteNode {
        return SKSpriteNode(imageNamed: name)
    }
}
