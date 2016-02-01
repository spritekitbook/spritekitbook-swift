//
//  GameShaders.swift
//  SpaceRunner
//
//  Created by Jeremy Novak on 1/29/16.
//  Copyright © 2016 Jeremy Novak. All rights reserved.
//

import SpriteKit

private class ShaderNames {
    class var GrayScale:String     { return "Grayscale.fsh" }
}

let GameShadersSharedInstance = GameShaders()

class GameShaders {
    
    class var sharedInstance:GameShaders {
        return GameShadersSharedInstance
    }
    
    
    // MARK: - Private class constants
    private let shaderGrayscale = SKShader(fileNamed: ShaderNames.GrayScale)
    
    
    // MARK: - Init
    init() {
        
    }

    
    // MARK: - Shader Actions
    func shadeGray(node node: SKNode) {
        if let sprite = node as? SKSpriteNode {
            sprite.shader = self.shaderGrayscale
            
            sprite.runAction(SKAction.waitForDuration(3.0), completion: {
                sprite.shader = nil
            })
        }
    }
}
