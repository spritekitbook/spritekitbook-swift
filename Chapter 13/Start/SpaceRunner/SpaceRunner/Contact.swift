//
//  Contact.swift
//  SpaceRunner
//
//  Created by Jeremy Novak on 9/7/16.
//  Copyright © 2016 Spritekit Book. All rights reserved.
//

import Foundation


class Contact {
    class var player:UInt32     { return 1 << 0 }
    class var meteor:UInt32     { return 1 << 1 }
    class var star:UInt32       { return 1 << 2 }
}
