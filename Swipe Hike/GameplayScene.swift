//
//  GameplayScene.swift
//  Swipe Hike
//
//  Created by Craig Watt on 07/05/2017.
//  Copyright © 2017 C10. All rights reserved.
//

import SpriteKit

class GameplayScene: SKScene {
    
    private var bg1: BGClass?
    private var bg2: BGClass?
    private var bg3: BGClass?
    
    private var gnd1: GNDClass?
    private var gnd2: GNDClass?
    private var gnd3: GNDClass?
    
    private var rgnd1: GNDClass?
    private var rgnd2: GNDClass?
    private var rgnd3: GNDClass?
    
    private var player: Player?
    
    var constantSpeed:Int = 600
    
    var lrrl:Int = 0;
    //var jumpAction:SKAction = SKAction.rotate(byAngle:-3, duration:5);
    //var jumpToLeft:SKAction = SKAction.rotate(byAngle:-9, duration:3);
    //var jumpToRight:SKAction = SKAction.rotate(byAngle:9, duration:3);
    //var jumpAction:SKAction = SKAction.rotate
    
    private var mainCamera: SKCameraNode?;
    
    override func didMove(to view: SKView) {
        initializeGame()
        
    }
    override func update(_ currentTime: TimeInterval) {
        //maintain constant speed?
        player!.physicsBody?.velocity = CGVector(dx: constantSpeed, dy: 0)
        manageCamera()
        manageBGandG()
        managePlayer()
    }
    
    //user input
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //reverseGravity()
        reverseSpeed()
        
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
        
        rgnd1?.initializeGND()
        rgnd2?.initializeGND()
        rgnd3?.initializeGND()
        
        player = childNode(withName: "Player") as? Player!
        player?.initializePlayer()
        
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
    }
    
    private func reverseGravity(){
        physicsWorld.gravity.dx *= -1
        //player?.reversePlayer();
    }
    
    private func reverseSpeed(){
        constantSpeed *= -1;
    }
}
