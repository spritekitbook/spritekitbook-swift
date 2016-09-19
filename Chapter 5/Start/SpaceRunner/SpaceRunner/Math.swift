//
//  Math.swift
//  SpaceRunner
//
//  Created by Jeremy Novak on 8/30/16.
//  Copyright © 2016 Spritekit Book. All rights reserved.
//

import SpriteKit

func DegreesToRadians(degrees: CGFloat) -> CGFloat {
    return degrees * CGFloat(M_PI) / 180.0
}

func RadiansToDegrees(radians: CGFloat) -> CGFloat {
    return radians * 180.0 / CGFloat(M_PI)
}
