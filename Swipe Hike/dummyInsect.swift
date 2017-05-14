//
//  dummyInsect.swift
//  Swipe Hike
//
//  Created by Craig Watt on 12/05/2017.
//  Copyright © 2017 C10. All rights reserved.
//
/*
import Foundation


enum InsectType {
    case fly
    case beetle
    case ant
}

protocol InsectBase {
    //intrinsic states
    public var size: Int32
    public var legs: Int32
    public var eyes: Int32
    public var antennae: Int32
    public var toughness: Int32
    public var hunger: Int32
    public var canFly: Bool
    public var canBurrow: Bool
    
    public var insectType: InsectType! -> InsectType  {get set}
    public var maxHealth: Int32 {get set}
    
    // #region Extrinsic State
    //  Some "stateful" object - here an int that is calculated in the method.
    public func GetStrength(health: Int32) -> Int32
}

class Insect : InsectBase {
    public init(insectType: InsectType!) {
        self.insectType = insectType
        antennae = 2
        legs = 6
        switch insectType {
        case InsectType.fly:
            size = 2
            eyes = 1000
            toughness = 1
            maxHealth = 100
            hunger = 100
            canFly = true
            canBurrow = false
        case InsectType.beetle:
            size = 4
            eyes = 2
            toughness = 10
            maxHealth = 500
            hunger = 10
            canFly = true
            canBurrow = true
        case InsectType.ant:
            size = 1
            eyes = 2
            toughness = 10
            maxHealth = 100
            hunger = 50
            canFly = false
            canBurrow = true
        default:
            return nil
        }
    }
    
    public func GetStrength(health: Int32) -> Int32 {
        return size + toughness + (canFly ? 1 : 0) + (canBurrow ? 1 : 0) + health
    }
}

class InsectFlyweightFactory {
    public var showMessages: Bool = false
    private var _createdInsects: Hashtable! = Hashtable()
    
    public func GetInsectData(_ insectType: InsectType!) -> Insect! {
        if _createdInsects.ContainsKey(insectType) {
            if showMessages {
                Debug.Log("Reusing " + insectType.ToString())
            }
            return (_createdInsects[insectType] as? Insect)
        } else {
            if showMessages {
                Debug.LogWarning("Creating " + insectType.ToString())
            }
            var insect: Insect! = Insect(insectType)
            _createdInsects.Add(insectType, insect)
            return insect
        }
    }
}


public class InsectsFlyweightExample : MonoBehaviour {
    private func Start() {
        var insectFactory: InsectFlyweightFactory! = InsectFlyweightFactory()
        insectFactory.showMessages = true
        Debug.LogError("Testing reuse of insects")
        for var i: Int32 = 0; i <= 3 - 1; i++ {
            for var j: Int32 = 0; j <= 3 - 1; j++ {
                insectFactory.GetInsectData((i as? InsectType))
            }
        }
        Debug.LogError("Testing the pattern in action")
        //  An example of how this might work to our advantage.
        for var i: Int32 = 0; i <= 3 - 1; i++ {
            var challenger: Insect! = insectFactory.GetInsectData((i as? InsectType))
            Debug.Log("Insect to test: " + challenger.insectType.ToString())
            var defeatedInsect: List! = List()
            //  At what point can challenger be stronger than other insects at varying health.
            for var j: Int32 = 0; j <= challenger.maxHealth - 1; j++ {
                for var k: Int32 = 0; k <= 3 - 1; k++ {
                    if k == i {
                        continue
                    }
                    var insectType: InsectType! = (k as? InsectType)
                    if defeatedInsect.Contains(insectType) {
                        continue
                    }
                    var defender: Insect! = insectFactory.GetInsectData(insectType)
                    for var m: Int32 = defender.maxHealth; m >= 0; m-- {
                        var challengerStrength: Int32 = challenger.GetStrength(j)
                        var defenderStrength: Int32 = defender.GetStrength(m)
                        if challengerStrength > defenderStrength {
                            defeatedInsect.Add(insectType)
                            Debug.LogWarning(challenger.insectType.ToString() + " at health: " + j.ToString() + " defeated " + defender.insectType.ToString() + " at full health of " + defender.maxHealth.ToString())
                            break
                        }
                    }
                }
            }
            //  Check if anyone wasn't defeated.
            for var h: Int32 = 0; h <= 3 - 1; h++ {
                if h == i {
                    continue
                }
                var insectType: InsectType! = (h as? InsectType)
                if !defeatedInsect.Contains(insectType) {
                    Debug.LogError(challenger.insectType.ToString() + " could not defeat " + insectType.ToString())
                }
            }
        }
    }
    
    private func Update() {
    }
}
 */
