//
//  GNDClass.swift
//  Swipe Hike
//
//  Created by Craig Watt on 08/05/2017.
//  Copyright © 2017 C10. All rights reserved.
//

import SpriteKit

//class GNDClass: SKSpriteNode {
    //now redundant
   // func initializeGND(){
   //     physicsBody = SKPhysicsBody(rectangleOf: self.size)
    //    physicsBody?.affectedByGravity = false
    //    physicsBody?.contactTestBitMask = PhysicsCategory.Player
    //    physicsBody?.restitution = 0.0;
    //    physicsBody?.usesPreciseCollisionDetection = true
     //
    //    physicsBody?.isDynamic = false
    //    physicsBody?.categoryBitMask = PhysicsCategory.Wall
   // }
    
    //for repetitive sequence
    //func moveGND(camera: SKCameraNode){
     //   if self.position.y + self.size.height < camera.position.y {
     //       self.position.y += self.size.height * 3
     //   }
   // }
    
   // func move(){
        //(2.5)
        //(-20)
        //(-5)
     //   self.position.y += 0
   // }
//}

enum WallType {
    case scratchpost
}

protocol WallBase {
    //Intrinsic states
   // var sprite: SKSpriteNode? {get}
   // var texture: SKTexture? {get}
   // var xPos: CGFloat? {get}
   // var yPos: CGFloat? {get}
   // var width: CGFloat? {get}
   // var height: CGFloat? {get}
    init(t: SKTexture)
    func display (xPos: CGFloat, yPos: CGFloat, height: CGFloat, width: CGFloat)
    //would be mutating func, with struct or enum
    func moveY()
    func moveForSequence(camera: SKCameraNode)
    
}

class FlyweightWall: WallBase {
    let sprite: SKSpriteNode = SKSpriteNode()
    //var texture: SKTexture?
   // var xPos: CGFloat?
    //var yPos: CGFloat?
    
    //var width: CGFloat?
    
    //var height: CGFloat?
    
    //required init?(coder aDecoder: NSCoder) {
   //     fatalError("init(coder:) has not been implemented")
   // }
    
    required init(t: SKTexture) {
        sprite.texture = t
        sprite.zPosition = 1
        //sprite.physicsBody = SKPhysicsBody(rectangleOf: sprite.self.size)


        //self.texture = texture
        //self.sprite = SKSpriteNode()
        //self.width could go here as shared by all? ------<<<<<<
        //super.init(texture: t, color: UIColor.clear , size: t.size())
        //self.texture = t
    }
   // required init?(coder aDecoder: NSCoder) {
   //     fatalError("init(coder:) has not been implemented")
   // }
    

    
    //width might be able to be the same
    func display(xPos: CGFloat, yPos: CGFloat, height: CGFloat, width: CGFloat) {
        //self.xPos = xPos
       // self.yPos = yPos
        //self.height = height
        //self.width = width
        
        sprite.position.x = xPos
        sprite.position.y = yPos
        sprite.size.height = height
        sprite.size.width = width
        sprite.physicsBody = SKPhysicsBody(rectangleOf: sprite.self.size)
        sprite.physicsBody?.affectedByGravity = false
        sprite.physicsBody?.contactTestBitMask = PhysicsCategory.Player
        sprite.physicsBody?.restitution = 0.0;
        sprite.physicsBody?.usesPreciseCollisionDetection = true
        sprite.physicsBody?.isDynamic = false
        sprite.physicsBody?.categoryBitMask = PhysicsCategory.Wall
        
    }
    func moveY(){
        sprite.self.position.y += 2
    }
    func moveForSequence(camera: SKCameraNode){
        if (sprite.position.y) + (sprite.size.height) < camera.position.y {
            sprite.position.y += (sprite.size.height) * 3
        }
    }
    /*
    func description() -> String  {
        return "sprite position: \(String(describing: self.xPos)), \(String(describing: self.yPos)) : dimension: \(String(describing: self.width)), \(String(describing: self.height)) : texture: \(String(describing: self.texture))"
    }
 */
}

class FlyweightWallFactory {
    internal static var wallsMap = Dictionary<SKTexture, FlyweightWall>()
    
    static func getFlyweightWall(texture:SKTexture) -> FlyweightWall{
        if let result = wallsMap[texture]{
            return result
        } else { // if nil add it to dictionary
            let result = FlyweightWall(t: texture)
            wallsMap[texture] = result
            return result
        }
    }
}

/*
class AbstractPerfTest {
    
    let textures: [SKTexture] = [SKTexture(imageNamed: "GND1")]
    
    
    //let sks = SKScene()
    //let view = SKView(frame: NSRect(x: 0, y: 0, width: 1024, height: 768))
    
    //let maxRectWidth = 100
    //let maxRectHeight = 100
    
    //must be overriden
    func run() -> [FlyweightWall]{
        preconditionFailure("Must be overriden")
    }
}

class WithPattern: AbstractPerfTest{
    //Execute the test
    var walls = [FlyweightWall]()
    override func run() -> [FlyweightWall]{
        //var j:Int = 0
        
        for index in 0...5{
            //let idx = Int(arc4random_uniform(UInt32(self.colors.count-1)))
            walls.append(FlyweightWallFactory.getFlyweightWall(texture: self.textures[0]))
            walls[index].display(xPos: 0, yPos: 0, height: 200, width: 500)
            //j++
        }
        //print("\(j) rects generated")
        //print("nb Map: \(FlyweightRectFactory.rectsMap.count)")
    }
    
    func update(){
        for index in 0...5{
            walls[index].moveY()
        }
    }
}
*/
    
    
    
    
/*
class Wall: WallBase {
    init(wallType: WallType!){
        self.wallType = wallType
        texture = SKTexture(imageNamed: "GND1")
        //switch wallType {
        //case WallType.scratchpost:
            
        //}
    }
}

protocol Wall{
    var wallName: String { get set}
}
extension Wall {
    //could have pre set sizes in child classes instead?
    //can/should size and physics be in child class?
    func placeWall(xP: CGFloat, yP: CGFloat, height: CGFloat) -> SKSpriteNode?{ //t: String
        if(wallName == "SCRATCHPOST"){
            let wall = SKSpriteNode(imageNamed: "GND1")
            wall.texture = SKTexture(imageNamed: "GND1")
            //wall.size = CGSize(width: xSize, height: ySize)
            wall.anchorPoint = CGPoint(x: 0.5, y: 0)
            wall.position = CGPoint(x: xP, y: yP)
            wall.size.width = 100
            wall.size.height = height
            wall.zPosition = 1
            wall.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: wall.size.width-2, height: wall.size.height))
            wall.physicsBody?.affectedByGravity = false
            wall.physicsBody?.contactTestBitMask = PhysicsCategory.Player
            wall.physicsBody?.restitution = 0.0;
            wall.physicsBody?.usesPreciseCollisionDetection = true
            wall.physicsBody?.isDynamic = false
            wall.physicsBody?.categoryBitMask = PhysicsCategory.Wall
            return wall
        }
        else{
            return nil
        }
    }
}

class ScratchPost : Wall {
        var wallName = "SCRATCHPOST"
}

class WallFlyWeightFactory {
    func initialiseWall(wallN: String) -> Wall?{
        if(wallN == "SCRATCHPOST"){
            return ScratchPost()
        }
        else{
            return nil
        }
    }
}
*/

