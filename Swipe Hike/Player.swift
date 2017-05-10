//
//  Player.swift
//  Swipe Hike
//
//  Created by Craig Watt on 08/05/2017.
//  Copyright © 2017 C10. All rights reserved.
//

import SpriteKit

//struct ColliderType {
  //  static let PLAYER: UInt32 = 0
   // static let GND: UInt32 = 1
   // static let DANGER: UInt32 = 2
//}

class Player: SKSpriteNode {
    
    private var playerAnimation = [SKTexture]()
    private var animatePlayerAction = SKAction()
    private var catClimbingFrames : [SKTexture]!
    
    private var onGND: Int = 0
    
    func initializePlayer(){
        name = "Player"
        
        let catAnimatedAtlas = SKTextureAtlas(named: "myAtlas1")
        var climbFrames = [SKTexture]()
        
        let numImages = catAnimatedAtlas.textureNames.count
        
        for index in  1...numImages {
            let catTextureName = "kit\(index)"
            climbFrames.append(catAnimatedAtlas.textureNamed(catTextureName))
        }
        
        catClimbingFrames = climbFrames
        
        let firstFrame = catClimbingFrames[0]
        self.texture = firstFrame
        
        physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.size.width-10, height: self.size.height-10))
        //might change upon death?
        physicsBody?.affectedByGravity = true
        //stop bounce?
        physicsBody?.restitution = 0.0
        physicsBody?.usesPreciseCollisionDetection = true
        physicsBody?.allowsRotation = false
        physicsBody?.angularVelocity = 0.0
        physicsBody?.categoryBitMask = PhysicsCategory.Player
        physicsBody?.collisionBitMask = PhysicsCategory.Wall
        physicsBody?.contactTestBitMask = PhysicsCategory.Wall
        physicsBody?.contactTestBitMask = PhysicsCategory.Danger
        
        //animateCatClimb()
    }
    
    func move(){
        //(2.5)
        //(0)
        self.position.y += 0
    }
    
    func animateCatClimb(){
        //This is our general runAction method to make our cat walk.
        if onGND == 0{
            run(SKAction.repeatForever(
                SKAction.animate(with: catClimbingFrames,
                                 timePerFrame: 0.03,
                                 resize: false,
                                 restore: true)),
                    withKey:"climbingInPlaceCat")
                onGND = 1
        }
    }
    
    func animateCatJump(){
        self.removeAllActions()
        onGND = 0
        let temp = SKAction.setTexture(SKTexture(imageNamed: "tempJump"))
        run(temp)
        
       // run(SKAction.repeatForever(
       //     SKAction.animate(with: catClimbingFrames,
       //                      timePerFrame: 10,
       //                      resize: false,
       //                      restore: true)),
       //     withKey:"jumpingCat"
    }
    func reversePlayer(){
        //self.xScale *= -1
    }
}
