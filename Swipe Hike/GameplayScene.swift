//
//  GameplayScene.swift
//  Swipe Hike
//
//  Created by Craig Watt on 07/05/2017.
//  Copyright © 2017 C10. All rights reserved.
//

import SpriteKit

struct PhysicsCategory {
    //hmmmm
    static let None      : UInt32 = 0
    static let All       : UInt32 = UInt32.max
    static let Player   : UInt32 = 0b1       // 1
    static let Wall: UInt32 = 0b10      // 2
    static let Danger: UInt32 = 0b100    //3
    static let Projectile: UInt32 = 0b1000  //4
    static let Pickup: UInt32 = 0b10000 //5
}


class GameplayScene: SKScene, SKPhysicsContactDelegate {

    // declare gestures
    
    //swipes
  //  let swipeTopLeftRec = CustomSwipeRecogniser()
  //  let swipeBottomLeftRec = CustomSwipeRecogniser()
  //  let swipeTopRightRec = CustomSwipeRecogniser()
  //  let swipeBottomRightRec = CustomSwipeRecogniser()
    
    let swipeDirection = CustomSwipeRecogniser()
    
    private var cloudbg1: BGClass?
    private var cloudbg2: BGClass?
    private var cloudbg3: BGClass?
    
    private var gnd1: GNDClass?
    private var gnd2: GNDClass?
    private var gnd3: GNDClass?
    
    private var rgnd1: GNDClass?
    private var rgnd2: GNDClass?
    private var rgnd3: GNDClass?
    
    private var rgnd4: GNDClass?
    
    
    private var cat : Player?    
    private var player: Player?
    
    var constantSpeed:Int = -600
    
    //var lrrl:Int = 0;
    
    private var mainCamera: SKCameraNode?;
    
    private var itemController = ItemController()
    
    override func didMove(to view: SKView) {
        physicsWorld.contactDelegate = self
        
        swipeDirection.addTarget(self, action: #selector(GameplayScene.swipeReact) )
        self.view!.addGestureRecognizer(swipeDirection)

        initializeGame()
    }
    
    //the functions that get called when swiping...
    
    func swipeReact(){
        if(swipeDirection.directionMade == .DirectionTopLeft || swipeDirection.directionMade == .DirectionBottomLeft){
            jumpRight()
            player?.animateCatJump()
        }
        else if(swipeDirection.directionMade == .DirectionTopRight || swipeDirection.directionMade == .DirectionBottomRight){
            jumpLeft()
            player?.animateCatJump()
        }
    }
    func swipedToTopLeft(){
        //reverseSpeed()
    }
    func swipedToBottomLeft(){
        //reverseSpeed()
    }
    func swipedToTopRight(){
        //reverseSpeed()
    }
    func swipedToBottomRight(){
        //reverseSpeed()
    }
    
    //user input
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //reverseGravity()
        //reverseSpeed()
        //jumpLeft()
        //jumpRight()
        //(turnLeft)
        //(turnRight)
        //decide which way to rotate?
        // if lrrl == 0{
        //     player?.run(jumpToRight)
        //     lrrl = 1
        // }
        // else{
        //     player?.run(jumpToLeft)
        //     lrrl = 0
        // }
        
    }
    
   

    
    override func update(_ currentTime: TimeInterval) {
        //maintain constant speed?
        player!.physicsBody?.velocity = CGVector(dx: constantSpeed, dy: 0)
        manageCamera()
        manageBGandG()
        managePlayer()
    }

    private func initializeGame(){
        //set gravity to zero?
        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
    
        mainCamera = childNode(withName: "MainCamera") as? SKCameraNode!
        
        cloudbg1 = childNode(withName: "cloudBG1") as? BGClass!
        cloudbg2 = childNode(withName: "cloudBG2") as? BGClass!
        cloudbg3 = childNode(withName: "cloudBG3") as? BGClass!
        
        gnd1 = childNode(withName: "GND1") as? GNDClass!
        gnd2 = childNode(withName: "GND2") as? GNDClass!
        gnd3 = childNode(withName: "GND3") as? GNDClass!
        
        gnd1?.initializeGND()
        gnd2?.initializeGND()
        gnd3?.initializeGND()
        
        rgnd1 = childNode(withName: "rGND1") as? GNDClass!
        rgnd2 = childNode(withName: "rGND2") as? GNDClass!
        rgnd3 = childNode(withName: "rGND3") as? GNDClass!
        
        rgnd4 = childNode(withName: "rGND4") as? GNDClass!
        rgnd4?.initializeGND()
        
        rgnd1?.initializeGND()
        rgnd2?.initializeGND()
        rgnd3?.initializeGND()
        
        player = childNode(withName: "Player") as? Player!
        player?.initializePlayer()
        
        
       
        //cat = childNode(withName: "Player2") as? Player!
        //cat?.initializePlayer()
        //cat?.position = CGPoint(x:self.frame.midX, y:self.frame.midY)
        //addChild(cat)
        
        //Timer.scheduledTimer(timeInterval: TimeInterval(itemController.randomBetweenNumbers(firstNum: 1, secondNum: 3)), target: self, selector: #selector(GameplayScene.spawnItems), userInfo: nil, repeats: true)
        
    }
    
    private func manageCamera(){
        self.mainCamera?.position.y = ((self.player?.position.y)! + 400)
        
        if((self.player?.position.x)!) > ((self.mainCamera?.position.x)! + 125){
            self.mainCamera?.position.x = (self.player?.position.x)! - 125
        }
        if((self.player?.position.x)!) < ((self.mainCamera?.position.x)! - 125){
            self.mainCamera?.position.x = (self.player?.position.x)! + 125
        }
        //else if((self.player?.position.x)!) == ((self.mainCamera?.position.x)! + 100){
         //   self.mainCamera?.position.x = (self.mainCamera?.position.x)!
        //}
    }
    
    private func managePlayer(){
            player?.move()
            gnd1?.move()
            gnd2?.move()
            gnd3?.move()
            rgnd1?.move()
            rgnd2?.move()
            rgnd3?.move()
            rgnd4?.move()
            cloudbg1?.move()
            cloudbg2?.move()
            cloudbg3?.move()
        
    }
    private func manageBGandG(){
        
        cloudbg1?.moveBG(camera: mainCamera!)
        cloudbg2?.moveBG(camera: mainCamera!)
        cloudbg3?.moveBG(camera: mainCamera!)
        
        gnd1?.moveGND(camera: mainCamera!)
        gnd2?.moveGND(camera: mainCamera!)
        gnd3?.moveGND(camera: mainCamera!)
        
        rgnd1?.moveGND(camera: mainCamera!)
        rgnd2?.moveGND(camera: mainCamera!)
        rgnd3?.moveGND(camera: mainCamera!)
        rgnd4?.moveGND(camera: mainCamera!)
    }
    
    private func reverseGravity(){
        physicsWorld.gravity.dx *= -1
        //player?.reversePlayer();
    }
    
    private func reverseSpeed(){
        constantSpeed *= -1;
    }
    
    private func jumpLeft(){
        constantSpeed = -600
        //hmm
        player?.xScale = 1
    }
    
    private func jumpRight(){
        constantSpeed = 600
        //hmm
        player?.xScale = -1
    }
    
    func spawnItems() {
        self.scene?.addChild(itemController.spawnItems(camera: mainCamera!))
    }
    
  //  func didBegin(_ contact: SKPhysicsContact) {
   //     var firstBody = SKPhysicsBody()
    //    var secondBody = SKPhysicsBody()
    //
    //    if contact.bodyA.node?.name == "Player"{
    //        firstBody = contact.bodyA
    //        secondBody = contact.bodyB
    //    } else{
    //        firstBody = contact.bodyB
    //        secondBody = contact.bodyA
    //    }
        
    //    if firstBody.node?.name == "Player" && secondBody.node?.name != "Player"{
    //        playerDidCollideWithWall()
    //    }
    //}
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        // 1
        var firstBody: SKPhysicsBody
        var secondBody: SKPhysicsBody
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        // 2
        if ((firstBody.categoryBitMask & PhysicsCategory.Player != 0) &&
            (secondBody.categoryBitMask & PhysicsCategory.Wall != 0)) {
            //if let monster = firstBody.node as? SKSpriteNode, let
            //    projectile = secondBody.node as? SKSpriteNode {
                playerDidCollideWithWall()//projectile: projectile, monster: monster)
            //}
        }
        
    }

    
    
    func playerDidCollideWithWall() {
        player?.animateCatClimb()
        
        
        //monstersDestroyed += 1
        //if (monstersDestroyed > 100) {
        //    let reveal = SKTransition.flipHorizontal(withDuration: 0.5)
        //   let gameOverScene = GameOverScene(size: self.size, won: true)
        //    self.view?.presentScene(gameOverScene, transition: reveal)
        //}
    }

    
}
