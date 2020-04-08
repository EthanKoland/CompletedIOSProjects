//
//  GameScene.swift
//  SpriteTest
//
//  Created by 90305076 on 2/21/20.
//  Copyright © 2020 Ethan Koland. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var theBlock = SKSpriteNode()
    var theBall = SKSpriteNode()
    var theScore = SKLabelNode()
    var testBackground = SKSpriteNode()
    var score = 0
    var playerColor = UIColor.cyan
    var backgroundColorCoustom = UIColor.black
    var playerSize = CGSize(width: 100, height: 50)
    var ballSize = CGSize(width: 50, height: 50)
    var touchLocation:CGPoint?
   
    
    override func didMove(to view: SKView) {
        self.backgroundColor = backgroundColorCoustom
        physicsWorld.contactDelegate = self
        
        setBorder()
        spawnBlock()
        spawnBall()
        spawnScore()
    
    }
    
    
    
    override func update(_ currentTime: TimeInterval) {
        if (theBall.position.y <= -500){
            killBall()
            score = 0
            theScore.text = "Score : " + String(score)
            
       // } else if(CGRectIntersectsRect(CGRect(theBall), CGRect(theBlock))) {
            
        }
        
       // print(CGPoint(x: theBall.position.x, y: theBall.position.y))
        //print(score)
        //print("test")
    }
    func killBall(){
        theBall.removeFromParent()
        spawnBall()
        
    }
    func setBorder(){
        let border = SKPhysicsBody(edgeLoopFrom: self.frame)
        border.friction = 0
        border.restitution = 1
        border.angularDamping = 0
        border.linearDamping = 0
        self.physicsBody = border
    
        
        
        testBackground = SKSpriteNode(color: UIColor.yellow, size: CGSize(width: self.frame.width * 0.75, height: self.frame.height * 0.9))
        testBackground.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        testBackground.physicsBody = SKPhysicsBody(edgeLoopFrom: testBackground.frame)
        testBackground.physicsBody?.isDynamic = false
        testBackground.physicsBody?.angularDamping = 0
       testBackground.physicsBody?.affectedByGravity = false
        testBackground.physicsBody?.allowsRotation = false
        testBackground.physicsBody?.restitution = 0
        testBackground.physicsBody?.linearDamping = 0
        testBackground.physicsBody?.angularDamping = 0
        testBackground.physicsBody?.friction = 0
        
        self.addChild(testBackground)
    }
    func spawnScore(){
        theScore.position = CGPoint(x: self.frame.midX, y: self.frame.midY + 400)
        theScore.fontSize = 65
        theScore.fontColor = UIColor.blue
        theScore.text = "Score:" + String(score)
        self.addChild(theScore)
    }
    func spawnBall() {
         let direction: CGVector = CGVector(dx: 100, dy: 100)
        
       //Define Ball
        theBall = SKSpriteNode(color: UIColor.red, size: ballSize)
        theBall.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        //theBall.physicsBody = SKPhysicsBody(rectangleOf: ballSize, center: CGPoint(x: ballSize.width / 2, y: ballSize.height / 2))
        theBall.physicsBody = SKPhysicsBody(rectangleOf: ballSize)
        theBall.name = "ball"
    
        //the ball physics
        theBall.physicsBody?.isDynamic = true
        theBall.physicsBody?.contactTestBitMask = theBall.physicsBody?.collisionBitMask ?? 0
        theBall.physicsBody?.affectedByGravity = true
        theBall.physicsBody?.friction = 0
        theBall.physicsBody?.restitution = 1
        
      
        
        self.addChild(theBall)
        theBall.physicsBody?.applyImpulse(direction)
        
    }
    
    func spawnBlock(){
        //Define the block
        theBlock = SKSpriteNode(color: playerColor, size: playerSize)
        theBlock.position = CGPoint(x: self.frame.midX, y: self.frame.midY+200 )
        theBlock.physicsBody = SKPhysicsBody(rectangleOf: playerSize/*, center: CGPoint(x: playerSize.width / 2, y: playerSize.height / 2)*/)
        theBlock.name = "Block"
       //Block physics
        theBlock.position.y = -400
        theBlock.physicsBody?.isDynamic = false
        theBlock.physicsBody?.affectedByGravity = false
        theBlock.physicsBody?.allowsRotation = false
        theBlock.physicsBody?.restitution = 0
        theBlock.physicsBody?.linearDamping = 0
        theBlock.physicsBody?.angularDamping = 0
        theBlock.physicsBody?.friction = 0
        
        
      
        
        
        //Spawn objects
         self.addChild(theBlock)
      
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            touchLocation = touch.location(in: self)
        }
        theBlock.position.x = touchLocation!.x
        
    }
    func collision(betwen ball:SKNode, object : SKNode){
        if object.name == "Block" {
            score += 1
        }
        theScore.text = "Score : " + String(score)
        
    }
    func didBegin(_ contact: SKPhysicsContact) {
        if contact.bodyA.node?.name == "ball" {
            collision(betwen: contact.bodyA.node!, object: contact.bodyB.node!)
        } else if contact.bodyB.node?.name == "ball" {
            collision(betwen: contact.bodyB.node!, object: contact.bodyA.node!)
        }
        
    }
}
