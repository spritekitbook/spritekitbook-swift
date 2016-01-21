//
//  GameTextures.swift
//  SpaceRunner
//
//  Created by Jeremy Novak on 1/20/16.
//  Copyright © 2016 Jeremy Novak. All rights reserved.
//

import SpriteKit

let GameTexturesSharedInstance = GameTextures()

class GameTextures {
    
    class var sharedInstance:GameTextures {
        return GameTexturesSharedInstance
    }
    
    // MARK: - Private class variables
    private var interfaceSpritesAtlas = SKTextureAtlas()
    private var gameSpritesAtlas = SKTextureAtlas()
    
    // MARK: - Init
    init() {
        self.interfaceSpritesAtlas = SKTextureAtlas(named: "InterfaceSprites")
        self.gameSpritesAtlas = SKTextureAtlas(named: "GameSprites")
        
        self.testWithName("Test")
        self.testWithName2(name: "Test")
    }
    
    // MARK: - Public convenience functions
    func textureWithName(name name: String) -> SKTexture {
        return SKTexture(imageNamed: name)
    }
    
    func spriteWithName(name name: String) -> SKSpriteNode {
        return SKSpriteNode(imageNamed: name)
    }
    
    func testWithName(name: String) -> SKSpriteNode {
        return SKSpriteNode(imageNamed: name)
    }
    
    func testWithName2(name name: String) -> SKSpriteNode {
        return SKSpriteNode(imageNamed: name)
    }
}
