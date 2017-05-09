//
//  CustomSwipeRecogniser.swift
//  Swipe Hike
//
//  Created by Craig Watt on 09/05/2017.
//  Copyright © 2017 C10. All rights reserved.
//

import UIKit

class CustomSwipeRecogniser: UIGestureRecognizer {
    
    let requiredDistance: CGFloat = 50.0
    
    enum Direction:Int{
        case DirectionUnkown = 0
       // case DirectionLeft
        case DirectionTopLeft
        case DirectionBottomLeft
        
       // case DirectionRight
        case DirectionTopRight
        case DirectionBottomRight
        
        case Top
        case Bottom
    }
    
    var startPoint:CGPoint = CGPoint(x: 0.0, y: 0.0)
    var releasePoint:CGPoint = CGPoint(x: 0.0, y: 0.0)
    var directionMade:Direction = .DirectionUnkown
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        self.reset()
        if let touch = touches.first {
            self.startPoint = touch.location(in:self.view)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent) {
           }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent) {
        if let touch = touches.first {
            releasePoint = touch.location(in:self.view)

            let moveX = releasePoint.x - startPoint.x
            let moveY = releasePoint.y - startPoint.y

            if moveX < 0 && moveY < 0 {
                //(-5,-5)
                 directionMade = .DirectionTopLeft
            } else if moveX < 0 && moveY > 0 {
                //(-5,5)
                 directionMade = .DirectionBottomLeft
            } else if moveX > 0 && moveY > 0 {
                //(5,5)
                 directionMade = .DirectionBottomRight
            } else if moveX > 0 && moveY < 0 {
                //(5,-5)
                 directionMade = .DirectionTopRight
            }
            
            //moveX and moveY is a Float, so self.distanceForSwipeGesture needs to be a Float also
            if abs(moveX) < self.requiredDistance {
                return
            }
            //directionMade = curDirection
            self.state = .ended
        }

    }
    
    override func reset() {
        self.directionMade = .DirectionUnkown
        self.startPoint = CGPoint(x: 0.0, y: 0.0)
        //if self.state == .Possible {
        //     self.state = .Failed
        // }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent) {
        self.reset()
    }
}
