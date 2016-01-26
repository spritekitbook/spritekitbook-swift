//
//  GameFonts.swift
//  SpaceRunner
//
//  Created by Jeremy Novak on 1/24/16.
//  Copyright © 2016 Jeremy Novak. All rights reserved.
//

import SpriteKit

let GameFontsSharedInstance = GameFonts()

class GameFonts {
    
    class var sharedInstance:GameFonts {
        return GameFontsSharedInstance
    }
    
    // MARK: - Public enum
    internal enum LabelType:Int {
        case StatusBar
        case Bonus
        case Message
    }
    
    // MARK: - Private class constants
    private let fontName = "Edit Undo BRK"
    private let scoreSizePad:CGFloat = 24.0
    private let scoreSizePhone:CGFloat = 16.0
    private let bonusSizePad:CGFloat = 72.0
    private let bonusSizePhone:CGFloat = 36.0
    private let messageSizePad:CGFloat = 48.0
    private let messageSizePhone:CGFloat = 24.0
    
    // MARK: - Private class variables
    private var label = SKLabelNode()
    
    // MARK: - Init
    init() {
        self.setupLabel()
    }
    
    // MARK: - Setup
    private func setupLabel() {
        self.label = SKLabelNode(fontNamed: self.fontName)
        
        self.label.verticalAlignmentMode = SKLabelVerticalAlignmentMode.Center
    }
    
    // MARK: - Label creation
    func createLabel(string string: String, labelType: LabelType) -> SKLabelNode {
        let copiedLabel = self.label.copy() as! SKLabelNode
        
        switch labelType {
            case LabelType.StatusBar:
                copiedLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Left
                copiedLabel.fontColor = Colors.colorFromRGB(rgbvalue: Colors.FontScore)
                copiedLabel.fontSize = kDeviceTablet ? self.scoreSizePad : self.scoreSizePhone
                copiedLabel.text = string
                
            case LabelType.Bonus:
                copiedLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Center
                copiedLabel.fontColor = Colors.colorFromRGB(rgbvalue: Colors.FontBonus)
                copiedLabel.fontSize = kDeviceTablet ? self.bonusSizePad : self.bonusSizePhone
                copiedLabel.text = string
                
            case LabelType.Message:
                copiedLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Center
                copiedLabel.fontColor = Colors.colorFromRGB(rgbvalue: Colors.FontBonus)
                copiedLabel.fontSize = kDeviceTablet ? self.messageSizePad : self.messageSizePhone
                copiedLabel.text = string
        }
        
        
        return copiedLabel
    }
    
    // MARK: - Actions
    func animateFloatingLabel(node node: SKLabelNode) -> SKAction {
        let action = SKAction.runBlock({
            node.runAction(SKAction.fadeInWithDuration(0.1), completion: {
                node.runAction(SKAction.scaleTo(1.25, duration: 0.1), completion: {
                    node.runAction(SKAction.moveToY(node.position.y + node.frame.size.height * 2, duration: 0.1), completion: {
                        node.runAction(SKAction.fadeOutWithDuration(0.1), completion: {
                            node.removeFromParent()
                        })
                    })
                })
            })
        })
        
        return action
    }
}
