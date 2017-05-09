//
//  Player.swift
//  Swipe Hike
//
//  Created by Craig Watt on 08/05/2017.
//  Copyright © 2017 C10. All rights reserved.
//

import SpriteKit

struct ColliderType {
    static let PLAYER: UInt32 = 0
    static let GND: UInt32 = 1
    static let DANGER: UInt32 = 2
}

class Player: SKSpriteNode {
    
    private var playerAnimation = [SKTexture]()
    private var animatePlayerAction = SKAction()
    
    func initializePlayer(){
        name = "tPlayer"
       
       // for i in 1...6 {
       //     let name = "Player \(i)"
       //     playerAnimation.append(SKTexture(imageNamed: name))
       // }
       //
       // animatePlayerAction = SKAction.animate(with: playerAnimation, timePerFrame: 0.08, resize: true, restore: false)
        
       // self.run(SKAction.repeatForever(animatePlayerAction))
       
        physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.size.width-10, height: self.size.height-10))
        //might change upon death?
        physicsBody?.affectedByGravity = true
        //stop bounce?
        physicsBody?.restitution = 0.0
        physicsBody?.usesPreciseCollisionDetection = true
        physicsBody?.allowsRotation = true
        physicsBody?.angularVelocity = 0.0
        physicsBody?.categoryBitMask = ColliderType.PLAYER
        physicsBody?.collisionBitMask = ColliderType.GND
        physicsBody?.contactTestBitMask = ColliderType.DANGER
    }
    
    func move(){
        self.position.y += 2.5
    }
    
    func reversePlayer(){
        //self.xScale *= -1
    }
}
