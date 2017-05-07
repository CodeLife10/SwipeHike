//
//  GNDClass.swift
//  Swipe Hike
//
//  Created by Craig Watt on 08/05/2017.
//  Copyright © 2017 C10. All rights reserved.
//

import SpriteKit

class GNDClass: SKSpriteNode {
    func moveGND(camera: SKCameraNode){
        if self.position.y + self.size.height < camera.position.y {
            self.position.y += self.size.height * 3
        }
    }
}
