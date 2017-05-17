//
//  GNDClass.swift
//  Swipe Hike
//
//  Created by Craig Watt on 08/05/2017.
//  Copyright © 2017 C10. All rights reserved.
//

import SpriteKit

enum WallType {
    case scratchpost
}

protocol WallBase {
    //Intrinsic states
    var sprite: SKSpriteNode {get}
    
    init(t: SKTexture)
    func display (xPos: CGFloat, yPos: CGFloat, height: CGFloat, width: CGFloat)
    //would be mutating func, with struct or enum
    func moveY()
    func moveForSequence(camera: SKCameraNode)
    
}

class FlyweightWall: WallBase {
    let sprite: SKSpriteNode = SKSpriteNode()
    var te: SKTexture = SKTexture()
    
    required init(t: SKTexture) {
        sprite.texture = t
        sprite.zPosition = 1
    }

    func display(xPos: CGFloat, yPos: CGFloat, height: CGFloat, width: CGFloat) {
        sprite.position.x = xPos
        sprite.position.y = yPos
        sprite.size.height = height
        sprite.size.width = width
        sprite.physicsBody = SKPhysicsBody(rectangleOf: sprite.self.size)
        sprite.physicsBody?.affectedByGravity = false
        sprite.physicsBody?.contactTestBitMask = PhysicsCategory.Player
        sprite.physicsBody?.restitution = 0.0;
        sprite.physicsBody?.usesPreciseCollisionDetection = true
        sprite.physicsBody?.isDynamic = false
        sprite.physicsBody?.categoryBitMask = PhysicsCategory.Wall
    }
    func moveY(){
        sprite.self.position.y += 2
    }
    func moveForSequence(camera: SKCameraNode){
        if (sprite.position.y) + (sprite.size.height) < camera.position.y {
            sprite.position.y += (sprite.size.height) * 3
        }
    }
}
class FlyweightDanger {
    let sprite: SKSpriteNode = SKSpriteNode()
    var te: SKTexture = SKTexture()
    
    required init(t: SKTexture) {
        sprite.texture = t
        sprite.zPosition = 2
    }
    
    func display(xPos: CGFloat, yPos: CGFloat, direction: Int, width: CGFloat) {
        sprite.position.x = xPos
        sprite.position.y = yPos
        sprite.size.height = 50
        sprite.size.width = width
        sprite.physicsBody = SKPhysicsBody(rectangleOf: sprite.self.size)
        sprite.physicsBody?.affectedByGravity = false
        sprite.physicsBody?.contactTestBitMask = PhysicsCategory.Player
        sprite.physicsBody?.restitution = 0.0;
        sprite.physicsBody?.usesPreciseCollisionDetection = true
        sprite.physicsBody?.isDynamic = false
        sprite.physicsBody?.categoryBitMask = PhysicsCategory.Danger
        switch direction {
        case 1:
            //point left
            sprite.zRotation = CGFloat.pi/2
        case 2:
            //point right
            sprite.zRotation = -CGFloat.pi/2
        case 3:
            //point down
            sprite.zRotation =  (CGFloat.pi)
        default: ()
        }

    }
    func moveY(){
        sprite.self.position.y += 2
    }
    func moveForSequence(camera: SKCameraNode){
        if (sprite.position.y) + (sprite.size.height) < camera.position.y {
            sprite.position.y += (sprite.size.height) * 3
        }
    }
}

class FlyweightWallFactory {
    internal static var wallsMap = Dictionary<SKTexture, FlyweightWall>()
    
    static func getFlyweightWall(texture:SKTexture) -> FlyweightWall{
        if let result = wallsMap[texture]{
            return result
        } else { // if nil add it to dictionary
            let result = FlyweightWall(t: texture)
            wallsMap[texture] = result
            return result
        }
    }
}
class FlyweightDangerFactory {
    internal static var dangersMap = Dictionary<SKTexture, FlyweightDanger>()
    
    static func getFlyweightDanger(texture:SKTexture) -> FlyweightDanger{
        if let result = dangersMap[texture]{
            return result
        } else { // if nil add it to dictionary
            let result = FlyweightDanger(t: texture)
            dangersMap[texture] = result
            return result
        }
    }
}

