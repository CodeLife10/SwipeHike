//
//  GNDClass.swift
//  Swipe Hike
//
//  Created by Craig Watt on 08/05/2017.
//  Copyright © 2017 C10. All rights reserved.
//

import SpriteKit

class GNDClass: SKSpriteNode {
    
    func initializeGND(){
        physicsBody = SKPhysicsBody(rectangleOf: self.size)
        physicsBody?.affectedByGravity = false
        physicsBody?.contactTestBitMask = PhysicsCategory.Player
        physicsBody?.restitution = 0.0;
        physicsBody?.usesPreciseCollisionDetection = true
        
        physicsBody?.isDynamic = false
        physicsBody?.categoryBitMask = PhysicsCategory.Wall
    }
    
    func moveGND(camera: SKCameraNode){
        if self.position.y + self.size.height < camera.position.y {
            self.position.y += self.size.height * 3
        }
    }
    
    func move(){
        //(2.5)
        //(-20)
        self.position.y += -5
    }
}
