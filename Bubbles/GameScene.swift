//
//  GameScene.swift
//  Bubbles
//
//  Created by Brian Daneshgar on 4/23/16.
//  Copyright (c) 2016 Brian Daneshgar. All rights reserved.
//

import SpriteKit

//hello world!

class GameScene: SKScene {
    
    var score = 0
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        let sprite = SKSpriteNode(imageNamed: "Bubble")
        sprite.name = "bubble"
        sprite.size = CGSize(width: 180, height: 180)
        sprite.position = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height/2)
        sprite.physicsBody = SKPhysicsBody(circleOfRadius: 95)
        sprite.physicsBody?.dynamic = false
        self.addChild(sprite)
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
        for touch: AnyObject in touches {
            let location = (touch as! UITouch).locationInNode(self)
            if let theName = self.nodeAtPoint(location).name {
                if theName == "bubble" {
                    self.removeChildrenInArray([self.nodeAtPoint(location)])
                    score+=1
                    print("score")
                }
            }
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
