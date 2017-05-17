//
//  Player.swift
//  Swipe Hike
//
//  Created by Craig Watt on 08/05/2017.
//  Copyright © 2017 C10. All rights reserved.
//

import SpriteKit

class Player: SKSpriteNode {
    
    private var playerAnimation = [SKTexture]()
    private var animatePlayerAction = SKAction()
    private var catClimbingFrames : [SKTexture]!
    private var busy: Bool = false
    
    private var onGND: Int = 0
    
    func initializePlayer(){
        busy = false
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
        self.size.height = 100
        self.size.width = 80
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
        let temp = SKAction.setTexture(SKTexture(imageNamed: "CatJump1"))
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
    func checkBusy() -> Bool{
        return busy
    }
    func changeBusyT(){
        busy = true
    }
    func changeBusyF(){
        busy = false
    }
}
