//
//  Levels.swift
//  Swipe Hike
//
//  Created by Craig Watt on 12/05/2017.
//  Copyright © 2017 C10. All rights reserved.
//

import Foundation

protocol Levels {
    var wallFileName: String {get}
    var dangerFileName: String {get}
}
extension Levels{
    func restartHappens() -> Int{
        return 0
    }
    func getLevelWalls() -> [String]?{
        var arrayOfStrings: [String]?
        do {
            // This solution assumes  you've got the file in your bundle
            if let path = Bundle.main.path(forResource: wallFileName, ofType: "txt"){
                let data = try String(contentsOfFile:path, encoding: String.Encoding.utf8)
                // Use `n` here
                arrayOfStrings = data.components(separatedBy: "\n")
                print(arrayOfStrings ?? "unkown")
            }
        } catch let err as NSError {
            // do something with Error
            print(err)
        }
        return arrayOfStrings
    }
    func getLevelDangers() -> [String]?{
        var arrayOfStrings: [String]?
        do {
            // This solution assumes  you've got the file in your bundle
            if let path = Bundle.main.path(forResource: dangerFileName, ofType: "txt"){
                let data = try String(contentsOfFile:path, encoding: String.Encoding.utf8)
                // Use `n` here
                arrayOfStrings = data.components(separatedBy: "\n")
                print(arrayOfStrings ?? "unkown")
            }
        } catch let err as NSError {
            // do something with Error
            print(err)
        }
        return arrayOfStrings
    }
}

class Level1: Levels {
    var wallFileName: String = "FirstLevelWalls"
    var dangerFileName: String = "FirstLevelDangers"
}

class Level2: Levels {
    var wallFileName: String = "SecondLevelWalls"
    var dangerFileName: String = "SecondLevelDangers"
}

class Level3: Levels{
    var wallFileName: String = "ThirdLevelWalls"
    var dangerFileName: String = "ThirdLevelDangers"
}

class LevelFactory {
    func initialiseLevel(levelN: String) -> Levels?{
        if(levelN == "FirstLevel"){
            return Level1()
        }
        else if(levelN == "SecondLevel"){
            return Level2()
        }
        else if(levelN == "ThirdLevel"){
            return Level3()
        }
        else{
            return nil
        }
    }
}
