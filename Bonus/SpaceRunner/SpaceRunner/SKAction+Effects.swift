//
//  SKAction+Extensions.swift
//  SpaceRunner
//
//  Created by Jeremy Novak on 9/14/16.
//  Copyright © 2016 Spritekit Book. All rights reserved.
//

import SpriteKit


extension SKAction {
    
    class func shake(amount: CGPoint, duration: TimeInterval) -> SKAction {
        let startX:CGFloat = 0.0
        let startY:CGFloat = 0.0
        
        let shakeNumber = Int(duration / 0.016)
        
        var actions = [SKAction]()
        
        for _ in 0...shakeNumber {
            
            let newX = startX + CGFloat(arc4random_uniform(UInt32(amount.x) - UInt32(amount.x / 2)))
            let newY = startY + CGFloat(arc4random_uniform(UInt32(amount.y) - UInt32(amount.y / 2)))
            
            actions.append(SKAction.move(to: CGPoint(x: newX, y: newY), duration: 0.016))
        }
        
        actions.append(SKAction.move(to: CGPoint(x: startX, y: startY), duration: 0.016))
        
        return SKAction.sequence(actions)
    }
  
    class func shake(node: SKNode, amount: CGPoint, duration: TimeInterval) -> SKAction {
        let startX = node.position.x
        let startY = node.position.y
        
        let shakeNumber = Int(duration / 0.016)
        
        var actions = [SKAction]()
        
        for _ in 0...shakeNumber {
            
            let newX = startX + CGFloat(arc4random_uniform(UInt32(amount.x) - UInt32(amount.x / 2)))
            let newY = startY + CGFloat(arc4random_uniform(UInt32(amount.y) - UInt32(amount.y / 2)))
    
            actions.append(SKAction.move(to: CGPoint(x: newX, y: newY), duration: 0.016))
        }
        
        actions.append(SKAction.move(to: CGPoint(x: startX, y: startY), duration: 0.016))
        
        return SKAction.sequence(actions)
    }
}
