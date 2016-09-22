//
//  SKNode+Extras.swift
//  SpaceRunner
//
//  Created by Jeremy Novak on 9/21/16.
//  Copyright © 2016 Spritekit Book. All rights reserved.
//

import SpriteKit

extension SKNode {
    public var scaleAsPoint: CGPoint {
        get {
            return CGPoint(x: xScale, y: yScale)
        }
        set {
            xScale = newValue.x
            yScale = newValue.y
        }
    }
}
