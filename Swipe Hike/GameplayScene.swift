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
    
    private var mainCamera: SKCameraNode?;
    
    override func didMove(to view: SKView) {
        initializeGame()
        
    }
    override func update(_ currentTime: TimeInterval) {
        manageCamera()
        manageBGandG()
    }
    private func initializeGame(){
        mainCamera = childNode(withName: "MainCamera") as? SKCameraNode!
        
        bg1 = childNode(withName: "BG1") as? BGClass!
        bg2 = childNode(withName: "BG2") as? BGClass!
        bg3 = childNode(withName: "BG3") as? BGClass!
        
        gnd1 = childNode(withName: "GND1") as? GNDClass!
        gnd2 = childNode(withName: "GND2") as? GNDClass!
        gnd3 = childNode(withName: "GND3") as? GNDClass!
        
        rgnd1 = childNode(withName: "rGND1") as? GNDClass!
        rgnd2 = childNode(withName: "rGND2") as? GNDClass!
        rgnd3 = childNode(withName: "rGND3") as? GNDClass!
        
    }
    
    private func manageCamera(){
        self.mainCamera?.position.y += 2.5
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
}

































