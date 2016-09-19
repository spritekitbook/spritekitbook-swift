//
//  GameFonts.swift
//  SpaceRunner
//
//  Created by Jeremy Novak on 9/8/16.
//  Copyright © 2016 Spritekit Book. All rights reserved.
//

import SpriteKit

class GameFonts {
    
    static let sharedInstance = GameFonts()
    
    // MARK: - Public Enum
    enum LabelType {
        case label, bonus, message
    }
    
    // MARK: - Private class constants
    private let labelSize:CGFloat = 16.0
    private let bonusSize:CGFloat = 36.0
    private let messageSize:CGFloat = 24.0
    
    
    // MARK: - Private class variables
    private var label = SKLabelNode()
    
    // MARK: - Init
    init() {
        setup()
    }
    
    // MARK: - Setup
    private func setup() {
        label = SKLabelNode(fontNamed: kFont)
        
        label.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
    }
    
    // MARK: - Label creation
    func createLabel(string: String, type: LabelType) -> SKLabelNode {
        let copiedLabel = label.copy() as! SKLabelNode
        
        switch type {
        case .label:
            copiedLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
            copiedLabel.fontColor = Colors.colorFromRGB(rgbvalue: Colors.score)
            copiedLabel.fontSize = labelSize
            copiedLabel.text = string
            
        case .bonus:
            copiedLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
            copiedLabel.fontColor = Colors.colorFromRGB(rgbvalue: Colors.bonus)
            copiedLabel.fontSize = bonusSize
            copiedLabel.text = string
            
        case .message:
            copiedLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
            copiedLabel.fontColor = Colors.colorFromRGB(rgbvalue: Colors.border)
            copiedLabel.fontSize = messageSize
            copiedLabel.text = string
        }
        
        
        return copiedLabel
    }
    
    
    // MARK: - Actions
    func animate(label: SKLabelNode) -> SKAction {
        let action = SKAction.run({
            label.run(SKAction.fadeIn(withDuration: 0.1), completion: {
                label.run(SKAction.scale(to: 1.25, duration: 0.1), completion: {
                    label.run(SKAction.moveTo(y: label.position.y + label.frame.size.height * 2, duration: 0.1), completion: {
                        label.run(SKAction.fadeOut(withDuration: 0.1), completion: {
                            label.removeFromParent()
                        })
                    })
                })
            })
        })
        
        return action
    }
    
}
