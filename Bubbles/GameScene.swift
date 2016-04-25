//
//  GameScene.swift
//  Bubbles
//
//  Created by Brian Daneshgar on 4/23/16.
//  Copyright (c) 2016 Brian Daneshgar. All rights reserved.
//
import SpriteKit


class GameScene: SKScene {
    var score = 0
    var bubbleName = "bubble"
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        let original_bubbles = 6
        (1...original_bubbles).forEach { (i) in
            self.addChild(Bubble(name: bubbleName).bubble)
        }
    }

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
        for touch: AnyObject in touches {
            let location = (touch as! UITouch).locationInNode(self)
            let name = self.nodeAtPoint(location).name
            if  name != nil && name! == bubbleName {
                    self.removeChildrenInArray([self.nodeAtPoint(location)])
                    score += 1
                    print(score)
                    self.addChild(Bubble(name: bubbleName).bubble)
            }
        }
    }

    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}


class Bubble {
    let bubble: SKSpriteNode
    let random_limit: UInt32 = 1024
    let diameter = 180
    let radius: CGFloat = 95
    init(name: String){
        let xpos = Int(arc4random_uniform(random_limit))
        let ypos = Int(arc4random_uniform(random_limit))
        self.bubble = SKSpriteNode(imageNamed: "Bubble")
        self.bubble.name = name
        self.bubble.size = CGSize(width: diameter, height: diameter)
        self.bubble.position = CGPoint(x: xpos, y: ypos)
        self.bubble.physicsBody = SKPhysicsBody(circleOfRadius: radius)
        self.bubble.physicsBody?.dynamic = false
    }
}
