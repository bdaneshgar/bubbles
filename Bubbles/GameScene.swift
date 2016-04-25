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
        let original_bubbles = 6
        for i in 1 ... original_bubbles {
            self.addChild(Bubble().bubble)
        }
    }

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
        for touch: AnyObject in touches {
            let location = (touch as! UITouch).locationInNode(self)
            if let theName = self.nodeAtPoint(location).name {
                if theName == "bubble" {
                    self.removeChildrenInArray([self.nodeAtPoint(location)])
                    score += 1
                    print(score)
                    self.addChild(Bubble().bubble)
                }
            }
        }
    }

    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}

class Bubble {
    let bubble: SKSpriteNode
    init(){
        let newX = Int(arc4random_uniform(1024))
        let newY = Int(arc4random_uniform(1024))
        self.bubble = SKSpriteNode(imageNamed: "Bubble")
        self.bubble.name = "bubble"
        self.bubble.size = CGSize(width: 180, height: 180)
        self.bubble.position = CGPoint(x: newX, y: newY)
        self.bubble.physicsBody = SKPhysicsBody(circleOfRadius: 95)
        self.bubble.physicsBody?.dynamic = false
    }
}
