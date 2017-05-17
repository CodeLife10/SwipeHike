//
//  Menu.swift
//  Swipe Hike
//
//  Created by Craig Watt on 16/05/2017.
//  Copyright © 2017 C10. All rights reserved.
//

import SpriteKit

class MenuScene: SKScene {
    
    var playButton = SKSpriteNode()
    var helpButton = SKSpriteNode()
    
    let playButtonTex = SKTexture(imageNamed: "PlayButton")
    let helpButtonTex = SKTexture(imageNamed: "HelpButton")
    
    override func didMove(to view: SKView) {
        self.backgroundColor = UIColor.black
        playButton = SKSpriteNode(texture: playButtonTex)
        helpButton = SKSpriteNode(texture: helpButtonTex)
        
        playButton.position = CGPoint(x: frame.midX, y: frame.midY)
        helpButton.position = CGPoint(x: frame.midX, y: (frame.midY-400))
        playButton.name = "playButton"
        self.addChild(playButton)
        self.addChild(helpButton)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        if playButton.contains(touch.location(in: self)) {
            let levelSceneTemp = LevelScene(fileNamed: "LevelScene")
            levelSceneTemp?.scaleMode = .aspectFill
            self.scene?.view?.presentScene(levelSceneTemp!, transition: SKTransition.crossFade(withDuration: 1))
        }
        if helpButton.contains(touch.location(in: self)) {
            let helpSceneTemp = HelpScene(fileNamed: "HelpScene")
            helpSceneTemp?.scaleMode = .aspectFill
            self.scene?.view?.presentScene(helpSceneTemp!, transition: SKTransition.crossFade(withDuration: 1))
        }

    }
}
class HelpScene: SKScene {
    var howImage = SKSpriteNode()    
    let howToPlay = SKTexture(imageNamed: "Explain")
    
    override func didMove(to view: SKView) {
        self.backgroundColor = UIColor.black
        howImage = SKSpriteNode(texture: howToPlay)
        howImage.position = CGPoint(x: frame.midX, y: frame.midY)
        self.addChild(howImage)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.removeAllChildren()
        self.removeAllActions()
        let menuScene = MenuScene(fileNamed: "MenuScene") // Whichever scene you want to restart (and are in)
        menuScene?.scaleMode = .aspectFill
        let animation = SKTransition.crossFade(withDuration: 0.5) // ...Add transition if you like
        self.view?.presentScene(menuScene!, transition: animation)
    }

}

class WinScene: SKScene {
    var winSprite = SKSpriteNode()
    let winImage = SKTexture(imageNamed: "youWin")
    
    override func didMove(to view: SKView) {
        self.backgroundColor = UIColor.black
        winSprite = SKSpriteNode(texture: winImage)
        winSprite.position = CGPoint(x: frame.midX, y: frame.midY)
        self.addChild(winSprite)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.removeAllChildren()
        self.removeAllActions()
        let menuScene = MenuScene(fileNamed: "MenuScene") // Whichever scene you want to restart (and are in)
        menuScene?.scaleMode = .aspectFill
        let animation = SKTransition.crossFade(withDuration: 0.5) // ...Add transition if you like
        self.view?.presentScene(menuScene!, transition: animation)
    }
}

class LevelScene: SKScene {
    var level1Sprite = SKSpriteNode()
    var level2Sprite = SKSpriteNode()
    var level3Sprite = SKSpriteNode()
    
    let level1Image = SKTexture(imageNamed: "Level1")
    let level2Image = SKTexture(imageNamed: "Level2")
    let level3Image = SKTexture(imageNamed: "Level3")
    
    
    override func didMove(to view: SKView) {
        self.backgroundColor = UIColor.black
        level1Sprite = SKSpriteNode(texture: level1Image)
        level2Sprite = SKSpriteNode(texture: level2Image)
        level3Sprite = SKSpriteNode(texture: level3Image)
        
        level1Sprite.position = CGPoint(x: (frame.midX-200), y: frame.midY)
        level2Sprite.position = CGPoint(x: (frame.midX), y: frame.midY)
        level3Sprite.position = CGPoint(x: (frame.midX+200), y: frame.midY)
        self.addChild(level1Sprite)
        self.addChild(level2Sprite)
        self.addChild(level3Sprite)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        if level1Sprite.contains(touch.location(in: self)) {
            let gameplaySceneTemp = GameplayScene(fileNamed: "GameplayScene")
            gameplaySceneTemp?.scaleMode = .aspectFill
            gameplaySceneTemp?.lvl = "FirstLevel"
            self.scene?.view?.presentScene(gameplaySceneTemp!, transition: SKTransition.crossFade(withDuration: 1))
        }
        if level2Sprite.contains(touch.location(in: self)) {
            let gameplaySceneTemp = GameplayScene(fileNamed: "GameplayScene")
            gameplaySceneTemp?.scaleMode = .aspectFill
            gameplaySceneTemp?.lvl = "SecondLevel"
            self.scene?.view?.presentScene(gameplaySceneTemp!, transition: SKTransition.crossFade(withDuration: 1))
        }
        if level3Sprite.contains(touch.location(in: self)) {
            let gameplaySceneTemp = GameplayScene(fileNamed: "GameplayScene")
            gameplaySceneTemp?.scaleMode = .aspectFill
            gameplaySceneTemp?.lvl = "ThirdLevel"
            self.scene?.view?.presentScene(gameplaySceneTemp!, transition: SKTransition.crossFade(withDuration: 1))
        }
    }
}
