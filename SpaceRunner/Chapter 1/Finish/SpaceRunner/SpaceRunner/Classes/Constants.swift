//
//  Constants.swift
//  SpaceRunner
//
//  Created by Jeremy Novak on 1/19/16.
//  Copyright © 2016 Jeremy Novak. All rights reserved.
//

import Foundation
import SpriteKit

// MARK: - Debug
let kDebug = true

// MARK: - Screen dimension convenience
let kViewSize = UIScreen.mainScreen().bounds.size
let kScreenCenter = CGPoint(x: kViewSize.width / 2, y: kViewSize.height / 2)

// MARK: - Device size convenience
let kDeviceTablet = (UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Pad)
