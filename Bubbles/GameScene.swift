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
    
    let detailLabel = UILabel(frame: CGRectMake(16, 90, 300, 70))
    

    
    let red = UIColor(red: 209.0/255.0, green: 0.0/255.0, blue: 0.0/255, alpha: 1)          //0
    let orange = UIColor(red: 255.0/255.0, green: 102.0/255.0, blue: 34.0/255, alpha: 1)    //1
    let yellow = UIColor(red: 255.0/255.0, green: 218.0/255.0, blue: 33.0/255, alpha: 1)    //2
    let green = UIColor(red: 51.0/255.0, green: 221.0/255.0, blue: 0.0/255, alpha: 1)       //3
    let blue = UIColor(red: 17.0/255.0, green: 51.0/255.0, blue: 204.0/255, alpha: 1)       //4
    let indigo = UIColor(red: 34.0/255.0, green: 0.0/255.0, blue: 102.0/255, alpha: 1)      //5
    let violet = UIColor(red: 51.0/255.0, green: 0.0/255.0, blue: 68.0/255, alpha: 1)       //6


    var audioPlayer:AVAudioPlayer!
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        self.backgroundColor = SKColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1)
        
        
//        let path = NSBundle.mainBundle().pathForResource("MyParticle", ofType: "sks")
//        let bubbleParticle = NSKeyedUnarchiver.unarchiveObjectWithFile(path!) as! SKEmitterNode
//        
//        bubbleParticle.position = CGPointMake(self.size.width/2, 0)
//        bubbleParticle.name = "rainParticle"
//        bubbleParticle.targetNode = self.scene
//        
//        self.addChild(bubbleParticle)
        
        
        
        
        
        scoreLabel.textAlignment = NSTextAlignment.Left
        scoreLabel.font = scoreLabel.font.fontWithSize(55)
        scoreLabel.textColor = UIColor.whiteColor()
        scoreLabel.text = "\(score)"
        
        self.view!.addSubview(scoreLabel)
        
        detailLabel.textAlignment = NSTextAlignment.Left
        detailLabel.font = scoreLabel.font.fontWithSize(55)
        detailLabel.textColor = UIColor.whiteColor()
        
        self.view!.addSubview(detailLabel)
        

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
        
        let roygbiv = CGFloat(arc4random()%(6))

        
        let s = CGFloat(arc4random()%(40)) + 30
        
        let bubble = SKShapeNode(circleOfRadius: s)
        bubble.strokeColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1)
        bubble.lineWidth = 4
        if(roygbiv == 0){
            bubble.fillColor = red
            bubble.name = "red"
        } else if(roygbiv == 1){
            bubble.fillColor = orange
            bubble.name = "orange"
        } else if(roygbiv == 2){
            bubble.fillColor = yellow
            bubble.name = "yellow"
        } else if(roygbiv == 3){
            bubble.fillColor = green
            bubble.name = "green"
        } else if(roygbiv == 4){
            bubble.fillColor = blue
            bubble.name = "blue"
        } else if(roygbiv == 5){
            bubble.fillColor = indigo
            bubble.name = "indigo"
        } else if(roygbiv == 6){
            bubble.fillColor = violet
            bubble.name = "violet"
        } else if(roygbiv >= 7){
            bubble.fillColor = UIColor(red: r/255, green: g/255.0, blue: b/255, alpha: 1)
        }
        
//        bubble.fillColor = UIColor(red: r/255, green: g/255.0, blue: b/255, alpha: 1)
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
                if theName == "red" {
                    pop(location, color: red)
                    self.removeChildrenInArray([self.nodeAtPoint(location)])
                    if((detailLabel.text) == "red"){
                        score += 1
                    }

                } else if theName == "orange"{
                    pop(location, color: orange)
                    self.removeChildrenInArray([self.nodeAtPoint(location)])
                    
                    if((detailLabel.text) == "orange"){
                        score += 1
                    }
                } else if theName == "yellow"{
                    pop(location, color: yellow)

                    self.removeChildrenInArray([self.nodeAtPoint(location)])
                    
                    if((detailLabel.text) == "yellow"){
                        score += 1
                    }
                } else if theName == "green"{
                    pop(location, color: green)

                    self.removeChildrenInArray([self.nodeAtPoint(location)])
                    
                    if((detailLabel.text) == "green"){
                        score += 1
                    }
                } else if theName == "blue"{
                    pop(location, color: blue)

                    self.removeChildrenInArray([self.nodeAtPoint(location)])
                    
                    if((detailLabel.text) == "blue"){
                        score += 1
                    }
                } else if theName == "indigo"{
                    pop(location, color: indigo)

                    self.removeChildrenInArray([self.nodeAtPoint(location)])
                    
                    if((detailLabel.text) == "indigo"){
                        score += 1
                    }
                } else if theName == "violet"{
                    pop(location, color: violet)

                    self.removeChildrenInArray([self.nodeAtPoint(location)])
                    
                    if((detailLabel.text) == "violet"){
                        score += 1
                    }
                }
                
                scoreLabel.text = "\(score)"

            
                if((score % 10) == 0){
                    if(score == 0){
                       score += 1
                    }
                    scoreLabel.text = "\(score)"

                    let detail = CGFloat(arc4random()%(6))
                    if(detail == 0){
                        detailLabel.text = "red"
                        detailLabel.textColor = red;
                    } else if(detail == 1){
                        detailLabel.text = "orange"
                        detailLabel.textColor = orange;
                    } else if(detail == 2){
                        detailLabel.text = "yellow"
                        detailLabel.textColor = yellow;
                    } else if(detail == 3){
                        detailLabel.text = "green"
                        detailLabel.textColor = green;
                    } else if(detail == 4){
                        detailLabel.text = "blue"
                        detailLabel.textColor = blue;
                    } else if(detail == 5){
                        detailLabel.text = "indigo"
                        detailLabel.textColor = indigo;
                    } else if(detail == 6){
                        detailLabel.text = "violet"
                        detailLabel.textColor = violet;
                    }
                }
                
                
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
    
    func pop(pos: CGPoint, color: UIColor) {
        let emitterNode = SKEmitterNode(fileNamed: "PopParticle.sks")
        emitterNode!.particlePosition = pos
        emitterNode!.particleColorSequence = nil;
        emitterNode!.particleColorBlendFactor = 1.0;
        emitterNode!.particleColor = color;
        self.addChild(emitterNode!)
        // Don't forget to remove the emitter node after the explosion
        self.runAction(SKAction.waitForDuration(2), completion: { emitterNode!.removeFromParent() })
        
    }
   
    override func update(currentTime: CFTimeInterval) {
    }
}