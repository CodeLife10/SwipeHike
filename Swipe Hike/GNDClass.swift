//
//  GNDClass.swift
//  Swipe Hike
//
//  Created by Craig Watt on 08/05/2017.
//  Copyright © 2017 C10. All rights reserved.
//

import SpriteKit

class GNDClass: SKSpriteNode {
    //now redundant
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
        //(-5)
        self.position.y += 0
    }
}

protocol Wall{
    var wallName: String { get set}
}
extension Wall {
    //could have pre set sizes in child classes instead?
    //can/should size and physics be in child class?
    func placeWall(xP: CGFloat, yP: CGFloat) -> SKSpriteNode?{ //t: String
        if(wallName == "SCRATCHPOST"){
            let wall = SKSpriteNode(imageNamed: "GND1")
            wall.texture = SKTexture(imageNamed: "GND1")
            //wall.size = CGSize(width: xSize, height: ySize)
            wall.position = CGPoint(x: xP, y: yP)
            wall.size.width = 100
            wall.size.height = 1300
            wall.zPosition = 1
            wall.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: wall.size.width-2, height: wall.size.height))
            wall.physicsBody?.affectedByGravity = false
            wall.physicsBody?.contactTestBitMask = PhysicsCategory.Player
            wall.physicsBody?.restitution = 0.0;
            wall.physicsBody?.usesPreciseCollisionDetection = true
            wall.physicsBody?.isDynamic = false
            wall.physicsBody?.categoryBitMask = PhysicsCategory.Wall
            return wall
        }
        else{
            return nil
        }
    }
}

class ScratchPost : Wall {
        var wallName = "SCRATCHPOST"
}

class WallFlyWeightFactory {
    func initialiseWall(wallN: String) -> Wall?{
        if(wallN == "SCRATCHPOST"){
            return ScratchPost()
        }
        else{
            return nil
        }
    }
}
