//
//  GameScene.swift
//  Bubbles
//
//  Created by Brian Daneshgar on 4/23/16.
//  Copyright (c) 2016 Brian Daneshgar. All rights reserved.
//


//pop the bubblez!

import SpriteKit
import AVFoundation

//hello world!

class GameScene: SKScene {
    
    var score = 0
    let scoreLabel = UILabel(frame: CGRectMake(16, 16, 300, 70))

    var audioPlayer:AVAudioPlayer!
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        self.backgroundColor = SKColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1)
        
        scoreLabel.textAlignment = NSTextAlignment.Left
        scoreLabel.font = scoreLabel.font.fontWithSize(55)
        scoreLabel.textColor = UIColor.whiteColor()
    
        self.view!.addSubview(scoreLabel)
        

        runAction(SKAction.repeatActionForever(
            SKAction.sequence([
                SKAction.runBlock(addBubble),
                SKAction.waitForDuration(0.7)
                ])
            ))
        self.physicsWorld.gravity = CGVectorMake(0, 0.1)
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
        
        let s = CGFloat(arc4random()%(40)) + 30
        
        
        
        
        let bubble = SKShapeNode(circleOfRadius: s)
        bubble.name = "bubble"
        bubble.strokeColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1)
        bubble.lineWidth = 4
        bubble.fillColor = UIColor(red: r/255, green: g/255.0, blue: b/255, alpha: 1)
        bubble.physicsBody?.affectedByGravity = true
        bubble.physicsBody?.restitution = 1   //
        bubble.physicsBody?.linearDamping = 0 //air resistance
        
        bubble.physicsBody = SKPhysicsBody(circleOfRadius: bubble.frame.size.width/2)
        
        
        let actualX = random(min: size.width - s, max:s)
        bubble.position = CGPoint(x: actualX, y: -s)
        addChild(bubble)
        let actualDuration = random(min: CGFloat(2.0), max: CGFloat(3.0))
        let actionMove = SKAction.moveTo(CGPoint(x: actualX, y: size.height + s), duration: NSTimeInterval(actualDuration))
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
                    score += 1
                    scoreLabel.text = "\(score)"
                    
                    
                    if let myAudioUrl = NSBundle.mainBundle().URLForResource("pop", withExtension: "mp3") {
                        do {
                            audioPlayer = try AVAudioPlayer(contentsOfURL: myAudioUrl)
                            audioPlayer.prepareToPlay()
                            audioPlayer.play()
                        } catch let error as NSError {
                            print(error.localizedDescription)
                        }
                    }
                    
                    
                    
                }
            }
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
    }
}
