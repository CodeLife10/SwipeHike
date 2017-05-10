//
//  ItemController.swift
//  Swipe Hike
//
//  Created by Craig Watt on 09/05/2017.
//  Copyright © 2017 C10. All rights reserved.
//

import SpriteKit

class ItemController {
    
    private var minX = CGFloat(-5), maxX = CGFloat(5)
    
    func spawnItems(camera:SKCameraNode) -> SKSpriteNode{
        let item: SKSpriteNode?
        if Int(randomBetweenNumbers(firstNum: 0, secondNum: 10)) >= 6{
            item = SKSpriteNode(imageNamed: "Coin")
            item?.name = "Coin"
            item?.setScale(6000)
            item?.physicsBody = SKPhysicsBody(rectangleOf: item!.size)
        } else {
            item = SKSpriteNode(imageNamed: "Coin")
            item?.name="Coin"
            item?.physicsBody = SKPhysicsBody(rectangleOf: item!.size)
        }
        
        item!.physicsBody?.affectedByGravity = false
        //hmm
        item?.physicsBody?.categoryBitMask = PhysicsCategory.Danger
        
        item?.zPosition = 4
        item?.anchorPoint = CGPoint(x: 0.5, y: 0.5)
       
        item?.position.y = 0 // + 50
        item?.position.x = 0
        
        //item?.position.x = 20 //randomBetweenNumbers(firstNum: minX, secondNum: maxX)
        
        return SKSpriteNode()
    }
    
    func randomBetweenNumbers(firstNum: CGFloat, secondNum: CGFloat) ->CGFloat{
        return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(firstNum-secondNum) + min(firstNum, secondNum)
        
    }
} //class
