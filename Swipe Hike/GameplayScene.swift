//
//  GameplayScene.swift
//  Swipe Hike
//
//  Created by Craig Watt on 07/05/2017.
//  Copyright © 2017 C10. All rights reserved.
//

import SpriteKit

class GameplayScene: SKScene {

    // declare gestures
    
    //swipes
  //  let swipeTopLeftRec = CustomSwipeRecogniser()
  //  let swipeBottomLeftRec = CustomSwipeRecogniser()
  //  let swipeTopRightRec = CustomSwipeRecogniser()
  //  let swipeBottomRightRec = CustomSwipeRecogniser()
    
    let swipeDirection = CustomSwipeRecogniser()
    
    private var bg1: BGClass?
    private var bg2: BGClass?
    private var bg3: BGClass?
    
    private var gnd1: GNDClass?
    private var gnd2: GNDClass?
    private var gnd3: GNDClass?
    
    private var rgnd1: GNDClass?
    private var rgnd2: GNDClass?
    private var rgnd3: GNDClass?
    
    private var rgnd4: GNDClass?
    
    
    private var player: Player?
    
    var constantSpeed:Int = 600
    
    //var lrrl:Int = 0;
    
    private var mainCamera: SKCameraNode?;
    
    private var itemController = ItemController()
    
    override func didMove(to view: SKView) {
        
        swipeDirection.addTarget(self, action: #selector(GameplayScene.swipeReact) )
        self.view!.addGestureRecognizer(swipeDirection)
        
     //   swipeTopLeftRec.addTarget(self, action: #selector(GameplayScene.swipedToTopLeft) )
      //  swipeTopLeftRec.directionMade = .DirectionTopLeft
     //   self.view!.addGestureRecognizer(swipeTopLeftRec)
        
    //    swipeBottomLeftRec.addTarget(self, action: #selector(GameplayScene.swipedToBottomLeft) )
    //    self.view!.addGestureRecognizer(swipeBottomLeftRec)
        
    //    swipeTopRightRec.addTarget(self, action: #selector(GameplayScene.swipedToTopRight) )
    //    self.view!.addGestureRecognizer(swipeTopRightRec)
        
    //    swipeBottomRightRec.addTarget(self, action: #selector(GameplayScene.swipedToBottomRight) )
    //    self.view!.addGestureRecognizer(swipeBottomRightRec)
        
        initializeGame()
    }
    
    //the functions that get called when swiping...
    
    func swipeReact(){
        if(swipeDirection.directionMade == .DirectionTopLeft || swipeDirection.directionMade == .DirectionBottomLeft){
            jumpRight()
        }
        else if(swipeDirection.directionMade == .DirectionTopRight || swipeDirection.directionMade == .DirectionBottomRight){
            jumpLeft()
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
        
        bg1 = childNode(withName: "BG1") as? BGClass!
        bg2 = childNode(withName: "BG2") as? BGClass!
        bg3 = childNode(withName: "BG3") as? BGClass!
        
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
        
        //Timer.scheduledTimer(timeInterval: TimeInterval(itemController.randomBetweenNumbers(firstNum: 1, secondNum: 3)), target: self, selector: #selector(GameplayScene.spawnItems), userInfo: nil, repeats: true)
        
    }
    
    private func manageCamera(){
        self.mainCamera?.position.y += 2.5
    }
    
    private func managePlayer(){
            player?.move()
    }
    private func manageBGandG(){
        bg1?.moveBG(camera: mainCamera!)
        bg2?.moveBG(camera: mainCamera!)
        bg3?.moveBG(camera: mainCamera!)
        
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
        constantSpeed = -2000
    }
    
    private func jumpRight(){
        constantSpeed = 2000
    }
    
    func spawnItems() {
        self.scene?.addChild(itemController.spawnItems(camera: mainCamera!))
    }
}
