//  GameplayScene.swift
//  Swipe Hike
//
//  Created by Craig Watt on 07/05/2017.
//  Copyright © 2017 C10. All rights reserved.
//

import SpriteKit

struct PhysicsCategory {
    static let None      : UInt32 = 0
    static let All       : UInt32 = UInt32.max
    static let Player   : UInt32 = 0b1       // 1
    static let Wall: UInt32 = 0b10      // 2
    static let Danger: UInt32 = 0b100    //3
    static let Projectile: UInt32 = 0b1000  //4
    static let Pickup: UInt32 = 0b10000 //5
    static let Finish: UInt32 = 0b100000
}


class GameplayScene: SKScene, SKPhysicsContactDelegate {
    let swipeDirection = CustomSwipeRecogniser()
    let dangerFlyweightFactory = DangerFlyWeightFactory()
    private var danger: Danger?
    let levelFactory = LevelFactory()
    var coiner = SKSpriteNode()
    private var level: Levels?
    private var SWA: [String]?
    private var SDA: [String]?
    var curD: Int?
    private var cloudbg1: BGClass?
    private var cloudbg2: BGClass?
    private var cloudbg3: BGClass?
    var walls = [FlyweightWall]()
    let textures: [SKTexture] = [SKTexture(imageNamed: "Tree4"), SKTexture(imageNamed: "Spike1")]
    private var player: Player?
    var constantSpeed:Int = -600
    private var mainCamera: SKCameraNode?;
    var lvl :String!
    
    override func didMove(to view: SKView) {
        physicsWorld.contactDelegate = self
        swipeDirection.addTarget(self, action: #selector(GameplayScene.swipeReact) )
        self.view!.addGestureRecognizer(swipeDirection)
        initializeGame()
    }
    
    func swipeReact(){
        if((swipeDirection.directionMade == .DirectionTopLeft || swipeDirection.directionMade == .DirectionBottomLeft) && player?.checkBusy() == false){
                jumpRight()
                player?.animateCatJump()
        }
        else if((swipeDirection.directionMade == .DirectionTopRight || swipeDirection.directionMade == .DirectionBottomRight) && player?.checkBusy() == false){
            jumpLeft()
            player?.animateCatJump()
        }
        else if swipeDirection.directionMade == .singleTouch && swipeDirection.releasePoint.x > (coiner.position.x){
                self.removeAllChildren()
                self.removeAllActions()
                let menuScene = MenuScene(fileNamed: "MenuScene")
                menuScene?.scaleMode = .aspectFill
                let animation = SKTransition.crossFade(withDuration: 0.5)
                self.view?.presentScene(menuScene!, transition: animation)
            
        }
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        player!.physicsBody?.velocity = CGVector(dx: constantSpeed, dy: 0)
        manageCamera()
        manageBGandG()
        managePlayer()
    }
    
    func manageWalls(){
        var orderNumber: Int? = 0
        for _ in 1...(((SWA?.count)!-1)/3){
            let n = NumberFormatter().number(from: SWA![orderNumber!])
            let n2 = NumberFormatter().number(from: SWA![orderNumber!+1])
            let n3 = NumberFormatter().number(from: SWA![orderNumber!+2])
            let f = CGFloat(n!)
            let f2 = CGFloat(n2!)
            let f3 = CGFloat(n3!)
            let fClass = FlyweightWallFactory.getFlyweightWall(texture: self.textures[0])
            fClass.display(xPos: f, yPos: f2, height: f3, width: 50)
            let spriteCopy = fClass.sprite.copy() as! SKSpriteNode
            addChild(spriteCopy)
            let moveDown = SKAction.moveBy(x: 0, y: -3000, duration: 16)
            let sequence = SKAction.sequence([moveDown])
            spriteCopy.run(SKAction.repeatForever(sequence), withKey:  "moving")
            orderNumber = orderNumber! + 3
        }
    }
    
    func manageDangers(){
        var orderNumber: Int? = 0
        for _ in 1...(((SDA?.count)!-1)/3){
            let n = NumberFormatter().number(from: SDA![orderNumber!])
            let n2 = NumberFormatter().number(from: SDA![orderNumber!+1])
            let n3 = NumberFormatter().number(from: SDA![orderNumber!+2])
            let f = CGFloat(n!)
            let f2 = CGFloat(n2!)
            let f3 = Int(n3!)
            let fClass = FlyweightDangerFactory.getFlyweightDanger(texture: self.textures[1])
            fClass.display(xPos: f, yPos: f2, direction: f3, width: 50)
            let spriteCopy = fClass.sprite.copy() as! SKSpriteNode
            addChild(spriteCopy)
            let moveDown = SKAction.moveBy(x: 0, y: -3000, duration: 16)
            let sequence = SKAction.sequence([moveDown])
            spriteCopy.run(SKAction.repeatForever(sequence), withKey:  "moving")
            orderNumber = orderNumber! + 3
        }
    }
    
    func deployFinish(){
        let finish = SKSpriteNode()
        finish.position.x = 0
        finish.position.y = 5000
        finish.texture = SKTexture(imageNamed: "FinishLine")
        finish.zPosition = 3
        finish.size.height = 100
        finish.size.width = 10000
        finish.physicsBody = SKPhysicsBody(rectangleOf: finish.self.size)
        finish.physicsBody?.affectedByGravity = false
        finish.physicsBody?.contactTestBitMask = PhysicsCategory.Player
        finish.physicsBody?.restitution = 0.0;
        finish.physicsBody?.usesPreciseCollisionDetection = true
        finish.physicsBody?.isDynamic = false
        finish.physicsBody?.categoryBitMask = PhysicsCategory.Finish
        addChild(finish)
        let moveDown = SKAction.moveBy(x: 0, y: -3000, duration: 20)
        let sequence = SKAction.sequence([moveDown])
        finish.run(SKAction.repeatForever(sequence), withKey:  "moving")
    }
    /*
    func updateWallsPosition(){
        let fClass = FlyweightWallFactory.getFlyweightWall(texture: self.textures[0])
        fClass.moveY()
    }
    */
    private func initializeGame(){
        //set gravity to zero?
        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        mainCamera = childNode(withName: "MainCamera") as? SKCameraNode!
        cloudbg1 = childNode(withName: "cloudBG1") as? BGClass!
        cloudbg2 = childNode(withName: "cloudBG2") as? BGClass!
        cloudbg3 = childNode(withName: "cloudBG3") as? BGClass!
        danger = dangerFlyweightFactory.initialiseDanger(dangerN: "SPIKE")
        level = levelFactory.initialiseLevel(levelN: lvl)
        SWA = level?.getLevelWalls()
        SDA = level?.getLevelDangers()
        player = childNode(withName: "Player") as? Player!
        player?.initializePlayer()
        manageWalls()
        manageDangers()
        deployFinish()
        let hudNode = SKNode()
        hudNode.zPosition = 1000
        hudNode.isUserInteractionEnabled = true
        mainCamera?.addChild(hudNode)
        coiner = SKSpriteNode(imageNamed: "LevelExit")
        coiner.size.height = 100
        coiner.size.width = 100
        coiner.zPosition = 1000
        coiner.position = CGPoint(x:(((self.scene?.size.width)!/2) - (coiner.size.width/2)), y: (((self.scene?.size.height)!/2) - (coiner.size.height/2)))
        coiner.position = convert(CGPoint(x:(((self.scene?.size.width)!/2) - (coiner.size.width/2)), y: (((self.scene?.size.height)!/2) - (coiner.size.height/2))), to: mainCamera!)
        coiner.isUserInteractionEnabled = true
        hudNode.addChild(coiner)
    }
    
    private func manageCamera(){
        self.mainCamera?.position.y = ((self.player?.position.y)! + 400)
        if((self.player?.position.x)!) > ((self.mainCamera?.position.x)! + 125){
            self.mainCamera?.position.x = (self.player?.position.x)! - 125
        }
        if((self.player?.position.x)!) < ((self.mainCamera?.position.x)! - 125){
            self.mainCamera?.position.x = (self.player?.position.x)! + 125
        }
    }
    
    private func managePlayer(){
            player?.move()
            cloudbg1?.move()
            cloudbg2?.move()
            cloudbg3?.move()
        
    }
    private func manageBGandG(){
        cloudbg1?.moveBG(camera: mainCamera!)
        cloudbg2?.moveBG(camera: mainCamera!)
        cloudbg3?.moveBG(camera: mainCamera!)
    }
    
    private func reverseGravity(){
        physicsWorld.gravity.dx *= -1
    }
    
    private func reverseSpeed(){
        constantSpeed *= -1;
    }
    
    private func jumpLeft(){
            player?.changeBusyT()
            constantSpeed = -500
            //hmm
            player?.xScale = 1
    }
    
    private func jumpRight(){
            player?.changeBusyT()
            constantSpeed = 500
            player?.xScale = -1
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        var firstBody: SKPhysicsBody
        var secondBody: SKPhysicsBody
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        if ((firstBody.categoryBitMask & PhysicsCategory.Player != 0) &&
            (secondBody.categoryBitMask & PhysicsCategory.Wall != 0)) {
                playerDidCollideWithWall()
        }
        else if ((firstBody.categoryBitMask & PhysicsCategory.Player != 0) &&
            (secondBody.categoryBitMask & PhysicsCategory.Danger != 0)) {
            playerDidCollideWithDanger()
        }
        else if ((firstBody.categoryBitMask & PhysicsCategory.Player != 0) &&
            (secondBody.categoryBitMask & PhysicsCategory.Finish != 0)) {
            playerDidCollideWithFinish()
        }
    }

    func playerDidCollideWithWall() {
        player?.changeBusyF()
        player?.animateCatClimb()
        constantSpeed = 0
    }
    
    func playerDidCollideWithDanger(){
        //player?.animateDeath()
        restartScene()
    }
    
    func playerDidCollideWithFinish(){
        winScene()
    }
    
    func winScene(){
        self.removeAllChildren()
        self.removeAllActions()
        let winSceneTemp = WinScene(fileNamed: "WinScene")
        winSceneTemp?.scaleMode = .aspectFill
        self.scene?.view?.presentScene(winSceneTemp!, transition: SKTransition.crossFade(withDuration: 1))
    }
    func restartScene(){
        self.removeAllChildren()
        self.removeAllActions()
        let scene = GameplayScene(fileNamed: "GameplayScene")
            scene?.scaleMode = .aspectFill
            scene?.lvl = self.lvl
        let animation = SKTransition.crossFade(withDuration: 0.5)
        self.view?.presentScene(scene!, transition: animation)
    }
}
