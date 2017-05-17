//
//  Danger.swift
//  Swipe Hike
//
//  Created by Craig Watt on 12/05/2017.
//  Copyright © 2017 C10. All rights reserved.
//

import SpriteKit

class D: SKSpriteNode {
    //now redundant
   // func initializeGND(){
    //    physicsBody = SKPhysicsBody(rectangleOf: self.size)
    //    physicsBody?.affectedByGravity = false
    //    physicsBody?.contactTestBitMask = PhysicsCategory.Player
    //    physicsBody?.restitution = 0.0;
   //     physicsBody?.usesPreciseCollisionDetection = true
        
   //     physicsBody?.isDynamic = false
     //   physicsBody?.categoryBitMask = PhysicsCategory.Wall
   // }
    
    func moveDanger(camera: SKCameraNode){
        if self.position.y + self.size.height < camera.position.y {
            self.position.y += self.size.height * 3
        }
    }
    func move(){
        //(2.5)
        //(-20)
        //(-5)
        self.position.y += 0
    }
}

protocol Danger{
    var dangerName: String { get set}
}
extension Danger {
    //could have pre set sizes in child classes instead?
    //can/should size and physics be in child class?
    func placeDanger(xP: CGFloat, yP: CGFloat, direction: Int) -> SKSpriteNode?{ //t: String
        if(dangerName == "SPIKE"){
            let danger = SKSpriteNode(imageNamed: "Spike1")
            danger.texture = SKTexture(imageNamed: "Spike1")
            //wall.size = CGSize(width: xSize, height: ySize)
            danger.position = CGPoint(x: xP, y: yP)
            danger.size.width = 64
            danger.size.height = 64
            danger.zPosition = 2
            
            danger.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: danger.size.width, height: danger.size.height))
            danger.physicsBody?.affectedByGravity = false
            danger.physicsBody?.contactTestBitMask = PhysicsCategory.Player
            danger.physicsBody?.restitution = 0.0;
            danger.physicsBody?.usesPreciseCollisionDetection = true
            danger.physicsBody?.isDynamic = false
            danger.physicsBody?.categoryBitMask = PhysicsCategory.Danger
            switch direction {
            case 1:
                //point left
                danger.zRotation = CGFloat.pi/2
            case 2:
                //point right
                danger.zRotation = -CGFloat.pi/2
            case 3:
                //point down
                danger.zRotation =  (CGFloat.pi)
            default:
                return nil
            }
            return danger
        }
        else{
            return nil
        }
    }
}

class Spike : Danger {
    var dangerName = "SPIKE"
}

class DangerFlyWeightFactory {
    func initialiseDanger(dangerN: String) -> Danger?{
        if(dangerN == "SPIKE"){
            return Spike()
        }
        else{
            return nil
        }
    }
}
