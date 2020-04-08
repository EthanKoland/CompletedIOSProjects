
//
//  GameScene.swift
//  SpriteTest
//
//  Created by 90305076 on 2/21/20.
//  Copyright © 2020 Ethan Koland. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate  {
    
    var theBlock = SKShapeNode()
    var theBall = SKSpriteNode()
    var theScore = SKLabelNode()
    var testBackground = SKSpriteNode()
    var score = 0
    var playerColor = UIColor.cyan
    var backgroundColorCoustom = UIColor.black
    var playerSize = CGSize(width: 100, height: 50)
    var ballSize = CGSize(width: 50, height: 50)
    var touchLocation:CGPoint?
    var poly = SKShapeNode()
    var theBlockX: Float = 100
    
    override func didMove(to view: SKView) {
        self.backgroundColor = backgroundColorCoustom
        physicsWorld.contactDelegate = self
        
        setBorder()
        spawnBlock()
        //spawnBall()
        spawnScore()
        spawnPoly()
    
    }
    
    
 
    
    override func update(_ currentTime: TimeInterval) {
        if (poly.position.y <= -550){
            if(score == 420) {
                spawnBall()
                poly.physicsBody?.isDynamic = false
            } else {
            killBall()
            score = 0
            theScore.text = "Score : " + String(score)
                theBlock.removeFromParent()
                spawnBlock()
                
            }
       // } else if(CGRectIntersectsRect(CGRect(theBall), CGRect(theBlock))) {
            
        }
        
       // print(CGPoint(x: theBall.position.x, y: theBall.position.y))
        //print(score)
        //print("test")
        
    }
    func killBall(){
        poly.removeFromParent()
        //spawnBall()
        spawnPoly()
    }
    
    // MARK: Border
    
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
        testBackground.physicsBody?.restitution = 1
        testBackground.physicsBody?.linearDamping = 0
        testBackground.physicsBody?.angularDamping = 0
        testBackground.physicsBody?.friction = 0
        
        self.addChild(testBackground)
    }
    
    // MARK:  Score
    
    func spawnScore(){
        theScore.position = CGPoint(x: self.frame.midX, y: self.frame.midY + 400)
        theScore.fontSize = 65
        theScore.fontColor = UIColor.blue
        theScore.text = "Score:" + String(score)
        self.addChild(theScore)
    }
    
    // MARK:  Ball
    
    func spawnBall() {
         let direction: CGVector = CGVector(dx: 100, dy: 100)
        
       //Define Ball
        theBall = SKSpriteNode(color: UIColor.red, size: ballSize)
        theBall.position = CGPoint(x: self.frame.midX+50, y: self.frame.midY+50)
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
    
    // MARK: Block Spawn
    
    func spawnBlock(){
        //Define the block
    
        //theBlock = SKSpriteNode(color: playerColor, size: playerSize)
        theBlock.path = setBlockPath().cgPath
        theBlock.position = CGPoint(x: Int(theBlockX), y: -500 )
        theBlock.physicsBody = SKPhysicsBody(polygonFrom: setBlockPath().cgPath)
        theBlock.name = "Block"
        theBlock.fillColor = UIColor.red
        theBlock.strokeColor = UIColor.blue
        theBlock.lineWidth = 10
       //Block physics
        
        theBlock.physicsBody?.isDynamic = false
        theBlock.physicsBody?.affectedByGravity = false
        theBlock.physicsBody?.allowsRotation = false
        theBlock.physicsBody?.restitution = 0
        theBlock.physicsBody?.linearDamping = 0
        theBlock.physicsBody?.angularDamping = 0
        theBlock.physicsBody?.friction = 0
        
        print("block")
      
        
        
        //Spawn objects
         self.addChild(theBlock)
      
    }
    func setBlockPath( ) -> UIBezierPath{
        let tempPath = UIBezierPath()
               tempPath.move(to: CGPoint(x: self.frame.midX, y: 200 ))
               tempPath.addLine(to: CGPoint(x: self.frame.midX + 75, y: 200))
               tempPath.addLine(to: CGPoint(x: self.frame.midX + 75, y: 250))
               //tempPath.addLine(to: CGPoint(x: self.frame.midX, y: 150))
                tempPath.addQuadCurve(to: CGPoint(x: self.frame.midX  - 75, y: 250), controlPoint: CGPoint(x: self.frame.midX , y: 250 - CGFloat(log(Double(score+1)) * log(Double(score+1)))))
               tempPath.addLine(to: CGPoint(x: self.frame.midX - 75, y: 200 ))
               tempPath.close()
        return tempPath
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            touchLocation = touch.location(in: self)
            theBlockX = Float(touchLocation!.x)
        }
        theBlock.position.x = CGFloat(theBlockX)
        
    }
    
    // MARK: Collisions
    
    func collision(betwen ball:SKNode, object : SKNode){
        if object.name == "Block" {
            score += 1
        }
        theScore.text = "Score : " + String(score)
        
    }
    func didBegin(_ contact: SKPhysicsContact) {
        if contact.bodyA.node?.name == "poly"  {
            collision(betwen: contact.bodyA.node!, object: contact.bodyB.node!)
        } else if contact.bodyB.node?.name == "poly"  {
            collision(betwen: contact.bodyB.node!, object: contact.bodyA.node!)
        }
        print("COllision")
    }
    
    // MARK: Create Poly Path
    
    func polyPath(numberOfSides: Int) -> CGPath{
        let temp =  UIBezierPath()
        let startX = 0
        let startY = 200
        let sizeLength = 50
        temp.move(to: CGPoint(x: startX, y: startY))
        temp.addLine(to: CGPoint(x: startX, y: startY - sizeLength))
        temp.addLine(to: CGPoint(x: startX - sizeLength, y: startY - sizeLength))
        temp.addLine(to: CGPoint(x: startX - sizeLength, y: startY))
        temp.addLine(to: CGPoint(x: startX, y: startY))
        temp.close()
        print(temp)
        return temp.cgPath
    }
    
    func spawnPoly(){
      
        poly.name = "poly"
        poly.path = polyPath(numberOfSides: 4)
        poly.position = CGPoint(x: frame.midX, y: frame.midY)
        poly.fillColor = UIColor.red
        poly.strokeColor = UIColor.blue
        poly.lineWidth = 10
        
        poly.physicsBody = SKPhysicsBody(polygonFrom: polyPath(numberOfSides: 4))
        poly.physicsBody?.isDynamic = true
        poly.physicsBody?.affectedByGravity = true
        poly.physicsBody?.contactTestBitMask = poly.physicsBody?.collisionBitMask ?? 0
        poly.physicsBody?.allowsRotation = true
        poly.physicsBody?.restitution = 1.075
        poly.physicsBody?.mass = 0
        poly.physicsBody?.friction = 0
        
        self.addChild(poly)
        poly.physicsBody?.applyImpulse(CGVector(dx: 60, dy: 60))
        poly.physicsBody?.applyTorque(5)
        
    }
    func rotatePath(){
        
    }
}
