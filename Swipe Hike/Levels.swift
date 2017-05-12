//
//  Levels.swift
//  Swipe Hike
//
//  Created by Craig Watt on 12/05/2017.
//  Copyright © 2017 C10. All rights reserved.
//

import Foundation

protocol Levels {
    //var orderNumber: Int {get set}
    //var arrayOfStrings: [String]? {get set}
    var fileName: String {get}
    //func restartHappens()
    //func getLevelFile(fileName: String)
    //func restartHappens()
    //func getLevelFile()
    
}
extension Levels{
    //hmm
    func restartHappens() -> Int{
        return 0
    }
    func getLevelFile() -> [String]?{
        var arrayOfStrings: [String]?
        do {
            // This solution assumes  you've got the file in your bundle
            if let path = Bundle.main.path(forResource: fileName, ofType: "txt"){
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
    var fileName: String = "FirstLevel"
}

class LevelFactory {
    func initialiseLevel(levelN: String) -> Levels?{
        if(levelN == "FirstLevel"){
            return Level1()
        }
        else{
            return nil
        }
    }
}
