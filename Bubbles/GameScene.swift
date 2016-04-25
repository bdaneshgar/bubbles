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
    let scoreLabel = UILabel(frame: CGRectMake(16, 16, 200, 21))

    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        self.backgroundColor = SKColor(red: 165/255, green: 217/255, blue: 255/255, alpha: 1)
        
        scoreLabel.textAlignment = NSTextAlignment.Left
        scoreLabel.font = scoreLabel.font.fontWithSize(25)
        self.view!.addSubview(scoreLabel)
        

        runAction(SKAction.repeatActionForever(
            SKAction.sequence([
                SKAction.runBlock(addBubble),
                SKAction.waitForDuration(1.0)
                ])
            ))
        self.physicsWorld.gravity = CGVectorMake(0, 0.15)
    }
    
    
    func random() -> CGFloat {
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }
    
    func random(min min: CGFloat, max: CGFloat) -> CGFloat {
        return random() * (max - min) + min
    }
    
    func addBubble() {
        
        let r = CGFloat(arc4random()%(255))
        let g = CGFloat(arc4random()%(255))
        let b = CGFloat(arc4random()%(255))
        
        let bubble = SKShapeNode(circleOfRadius: 50)
        bubble.name = "bubble"
        bubble.strokeColor = UIColor(red: r/255, green: g/255, blue: b/255, alpha: 1)
        bubble.lineWidth = 4
        bubble.fillColor = UIColor(red: 255, green: 255, blue: 255, alpha: 0.4)
        bubble.physicsBody?.affectedByGravity = true
        bubble.physicsBody?.restitution = 1   //
        bubble.physicsBody?.linearDamping = 0 //air resistance
        
        bubble.physicsBody = SKPhysicsBody(circleOfRadius: bubble.frame.size.width/2)
        
        
        let actualX = random(min: size.width - 50, max:50)
        bubble.position = CGPoint(x: actualX, y: -50)
        addChild(bubble)
        let actualDuration = random(min: CGFloat(1.0), max: CGFloat(3.0))
        let actionMove = SKAction.moveTo(CGPoint(x: actualX, y: size.height + 50), duration: NSTimeInterval(actualDuration))
        let actionMoveDone = SKAction.removeFromParent()
        bubble.runAction(SKAction.sequence([actionMove, actionMoveDone]))
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
        for touch: AnyObject in touches {
            let location = (touch as! UITouch).locationInNode(self)
            if let theName = self.nodeAtPoint(location).name {
                if theName == "bubble" {
                    self.removeChildrenInArray([self.nodeAtPoint(location)])
                    score+=1
                    scoreLabel.text = "\(score)"
                    createBubble()
                }
            }
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        self.enumerateChildNodesWithName("bubble") {
            node, stop in
            if (node is SKSpriteNode) {
                let sprite = node as! SKSpriteNode
                // Check if the node is not in the scene
                if (sprite.position.x < -sprite.size.width/2.0 || sprite.position.x > self.size.width+sprite.size.width/2.0
                    || sprite.position.y < -sprite.size.height/2.0 || sprite.position.y > self.size.height+sprite.size.height/2.0) {
                        sprite.removeFromParent()
                        self.createBubble()
                }
            }
        }
    }
    
    func createBubble(){
        
        let r = CGFloat(arc4random()%(255))
        let g = CGFloat(arc4random()%(255))
        let b = CGFloat(arc4random()%(255))
        
        let shape = SKShapeNode(circleOfRadius: 50)
        shape.name = "bubble"
        shape.strokeColor = UIColor(red: r/255, green: g/255, blue: b/255, alpha: 1)
        shape.lineWidth = 4
        shape.fillColor = UIColor(red: 255, green: 255, blue: 255, alpha: 0.4)
        shape.position = CGPoint (x: CGFloat(arc4random()%(800)) + 100, y: CGFloat(arc4random()%(800)))
        shape.physicsBody?.affectedByGravity = true
        shape.physicsBody?.restitution = 1   //
        shape.physicsBody?.linearDamping = 0 //air resistance
        
        self.addChild(shape)
        shape.physicsBody = SKPhysicsBody(circleOfRadius: shape.frame.size.width/2)
    }
}
