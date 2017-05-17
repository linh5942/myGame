//
//  GameScene.swift
//  myGame
//
//  Created by Hsuan Lin on 2/23/17.
//  Copyright © 2017 Hsuan Lin. All rights reserved.
//

import SpriteKit
import GameplayKit


class GameScene: SKScene, SKPhysicsContactDelegate {
    // "global to object"
    var score = 0
    let winningScore = 100
    var bestScore = 0
    
    //let bubbleSize: CGFloat = 44.0
    //let bubbleSpeed = 350
    
    
    
    //properties, define must "?"
    var player: SKSpriteNode?  //optional, "nil"
    var enemy: SKSpriteNode? //
    //var laser: SKShapeNode?
    
    var zShots: SKSpriteNode?
    
    var LabelScore: SKLabelNode?
    
    
    
    
    
    // Setup, first thing to get called. App called.
    override func didMove(to view: SKView) {
        self.physicsWorld.contactDelegate = self
        print("Hello I'm in didMove to view")  //"format a string"
        
        // as is "casting"
        player = self.childNode(withName: "player") as! SKSpriteNode?
        enemy = self.childNode(withName: "squid") as! SKSpriteNode?
        
        
        LabelScore = self.childNode(withName: "LabelScore") as! SKLabelNode?
        
        zShots = self.childNode(withName: "zShots") as? SKSpriteNode
        

 
        //makeBubble()
        makeZees()
        
        
        // set up
        self.physicsWorld.contactDelegate = self
        
        currentScore = 0
    }
  
    func makeZees(){
        zShots = SKSpriteNode()
        zShots?.size = CGSize(width: 44, height: 70)
        zShots?.texture = SKTexture(image: #imageLiteral(resourceName: "zShot"))
        
        zShots?.position = (player?.position)!
        
        zShots?.physicsBody = SKPhysicsBody(circleOfRadius: 25)
        zShots?.physicsBody?.affectedByGravity = false
        zShots?.physicsBody?.velocity = CGVector(dx: 0, dy: 250)
        zShots?.physicsBody?.contactTestBitMask = 3
        zShots?.physicsBody?.mass = CGFloat(100)
        
        self.addChild(zShots!)
        
        
        zShots?.run(
            SKAction.sequence([
                SKAction.wait(forDuration: 4.0),
                SKAction.removeFromParent()
                ])
            
        )
        
        
    }
    
    

    
 /*  func makeBubble(){
        laser = SKShapeNode(circleOfRadius: bubbleSize)
        
        laser?.strokeColor = UIColor.blue
        laser?.fillColor = UIColor.blue
        
        laser?.position = (player?.position)!
        
        laser?.physicsBody = SKPhysicsBody(rectangleOf: (laser?.frame.size)!)
        laser?.physicsBody?.affectedByGravity = false
        laser?.physicsBody?.velocity = CGVector(dx: 0, dy: bubbleSpeed)
        
        laser?.physicsBody?.contactTestBitMask = 3
        
        self.addChild(laser!)
        
    }
 
  */
    
    
    
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("touches began")
        
        
        //makeBubble()
        //makeZees()
        
        
        for  t in touches {
            print("t= \(t.location(in: self))")
            
            player?.position.x = t.location(in: self).x
            
        }
        
    }
    
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("touches moved")
        
        
        for  t in touches {
            // print out where the finger touched
            print("t= \(t.location(in: self))")
            
            // move player's X position to that point.
            player?.position.x = t.location(in: self).x
            
            // Shot!
            //makeBubble()
            makeZees()
            
        }
    }
    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("touches ended")
        
        
        for  t in touches {
            // print out where the finger touched
            print("t= \(t.location(in: self))")
            
            // move player's X position to that point.
            player?.position.x = t.location(in: self).x
            
            // Shot!
            //makeBubble()
            makeZees()
            
        }
        
    }
    
    
    
    

    
    func didBegin(_ contact: SKPhysicsContact) {
        // print("we have contact btw \(contact.bodyA) \(contact.bodyB)")
 
        if (currentScore >= winningScore){
            moveToSceneWith(sceneName: "GameWinScreen")
            
            lastScore = currentScore
            if (lastScore >= topScore){
                topScore = lastScore
            }
            
        }
        
        
        if (contact.bodyB.node?.name == "bottomWall" || contact.bodyA.node?.name == "bottomWall"){
            player?.run(SKAction.playSoundFileNamed("fireball.mp3",waitForCompletion:false));
            
            print("Bottom Hit, Game Over")
            
            
            lastScore = currentScore
            if (lastScore >= topScore){
                topScore = lastScore
            }
            
            // Load the SKScene from 'GameScene.sks'
            moveToSceneWith(sceneName: "GameOverScreen")
            
            
            
            
            
        }
        
        

        
        if (contact.bodyA.contactTestBitMask == 1){
            print("Dripping!")
            currentScore = currentScore + 1
            LabelScore?.text = "Drips: \(currentScore)"
            
        
            //score = score + 1
            
            
        }
        
        if (contact.bodyB.contactTestBitMask == 1){
            print("Dripping!")
            currentScore = currentScore + 1
            LabelScore?.text = "Drips: \(currentScore)"
            
            //score = score + 1
            
        }
        
        if ((contact.bodyA.contactTestBitMask == 2) || (contact.bodyA.contactTestBitMask == 3)){
            contact.bodyA.node?.removeFromParent()
            
             player?.run(SKAction.playSoundFileNamed("dripback.mp3",waitForCompletion:false));
            
        }
        
        if ((contact.bodyB.contactTestBitMask == 2) || (contact.bodyB.contactTestBitMask == 2)){
            contact.bodyB.node?.removeFromParent()
            
             player?.run(SKAction.playSoundFileNamed("dripback.mp3",waitForCompletion:false));
            
        }
        

        
    }
    
    
    

    

    
   func moveToSceneWith(sceneName: String) {
        
        let scene = GameScene(fileNamed: sceneName)
        let skView = self.view as SKView?
        scene?.scaleMode = .aspectFill
        skView?.presentScene(scene)
    }
 
    
}
