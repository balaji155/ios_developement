//
//  GameScene.swift
//  Project11
//
//  Created by balaji.papisetty on 08/12/25.
//

import SpriteKit

class GameScene: SKScene ,SKPhysicsContactDelegate{
    var scoreLabel: SKLabelNode!
    var ballsRemaing = 5
    
    var editingLabel: SKLabelNode!
    var editMode: Bool = false {
        didSet {
            if editMode {
                editingLabel.text = "Done"
            }else {
                editingLabel.text = "Edit"
            }
        }
    }
    
    var score: Int = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    
    override func didMove(to view: SKView) {
        let background = SKSpriteNode(imageNamed: "background")
        background.position = CGPoint(x:512,y:384)
        background.blendMode = .replace
        background.zPosition = -1
        addChild(background)
        
        scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
        scoreLabel.text = "Score: 0"
        scoreLabel.horizontalAlignmentMode = .right
        scoreLabel.position = CGPoint(x: 980,y:700)
        addChild(scoreLabel)
        
        editingLabel = SKLabelNode(fontNamed: "Chalkduster")
        editingLabel.text = "Edit"
        editingLabel.horizontalAlignmentMode = .left
        editingLabel.position = CGPoint(x: 70,y:700)
        addChild(editingLabel)
        
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        physicsWorld.contactDelegate = self
        
        makeSlot(at: CGPoint(x: 128, y: 0), isGood: false)
        makeSlot(at: CGPoint(x: 384, y: 0), isGood: true)
        makeSlot(at: CGPoint(x: 640, y: 0), isGood: false)
        makeSlot(at: CGPoint(x: 896, y: 0), isGood: true)
        
        makeBouncer(at: CGPoint(x: 0, y: 0))
        makeBouncer(at: CGPoint(x: 256, y: 0))
        makeBouncer(at: CGPoint(x: 512, y: 0))
        makeBouncer(at: CGPoint(x: 768, y: 0))
        makeBouncer(at: CGPoint(x: 1024, y: 0))
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        
        let position = touch.location(in: self)
        let objects = nodes(at: position)
        
        if objects.contains(editingLabel) {
            editMode.toggle()
        }else {
            if editMode {
                let size = CGSize(width: Int.random(in: 16...128), height: 16)
                let box = SKSpriteNode(color: UIColor(red: CGFloat.random(in: 0...1), green: CGFloat.random(in: 0...1), blue: CGFloat.random(in: 0...1), alpha: 1), size: size)
                box.zRotation = CGFloat.random(in: 0...3)
                box.physicsBody = SKPhysicsBody(rectangleOf: size)
                box.physicsBody?.isDynamic = false
                box.position = position
                box.name = "box"
                addChild(box)
            }else {
                guard position.y > 600 && ballsRemaing > 0 else { return }
                let balls = ["ballRed","ballCyan","ballGreen","ballGrey","ballPurple","ballYellow"]
                let ball = SKSpriteNode(imageNamed: balls.randomElement() ?? "ballRed")
                ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.size.width / 2.0)
                ball.physicsBody?.contactTestBitMask = ball.physicsBody?.collisionBitMask ?? 0
                ball.physicsBody?.restitution = 0.4
                ball.position = position
                ball.name = "ball"
                addChild(ball)
                ballsRemaing -= 1
            }
        }
    }
    
    func makeBouncer(at position: CGPoint) {
        let bouncer = SKSpriteNode(imageNamed: "bouncer")
        bouncer.physicsBody = SKPhysicsBody(circleOfRadius: bouncer.size.width / 2.0)
        bouncer.physicsBody?.isDynamic = false
        bouncer.position = position
        addChild(bouncer)
    }
    
    func makeSlot(at position: CGPoint,isGood: Bool) {
        var slotBase: SKSpriteNode
        var slotGlow: SKSpriteNode
        
        if isGood {
            slotBase = SKSpriteNode(imageNamed: "slotBaseGood")
            slotGlow = SKSpriteNode(imageNamed: "slotGlowGood")
            slotBase.name = "good"
        }else {
            slotBase = SKSpriteNode(imageNamed: "slotBaseBad")
            slotGlow = SKSpriteNode(imageNamed: "slotGlowBad")
            slotBase.name = "bad"
        }
        
        slotBase.position = position
        slotGlow.position = position
        slotBase.physicsBody = SKPhysicsBody(rectangleOf: slotBase.size)
        slotBase.physicsBody?.isDynamic = false
        
        addChild(slotBase)
        addChild(slotGlow)
        
        let spin = SKAction.rotate(byAngle: .pi, duration: 10.0)
        let spinForever = SKAction.repeatForever(spin)
        
        slotGlow.run(spinForever)
    }
    
   func didBegin(_ contact: SKPhysicsContact) {
        guard let nodeA = contact.bodyA.node else { return }
        guard let nodeB = contact.bodyB.node else { return }
        
        if nodeA.name == "ball" {
            collision(between: nodeA, Object: nodeB)
        }else if nodeB.name == "ball" {
            collision(between: nodeB, Object: nodeA)
        }
    }
    
    func collision(between Ball:SKNode,Object:SKNode){
        if Object.name == "box" {
            Object.removeFromParent()
        }else if Object.name == "good" {
            deleteBall(Ball: Ball)
            score += 1
            ballsRemaing += 1
        }else if Object.name == "bad" {
            deleteBall(Ball: Ball)
            score -= 1
        }
    }
    
    func deleteBall(Ball: SKNode){
        if let fireParticle = SKEmitterNode(fileNamed: "FireParticles") {
            fireParticle.position = Ball.position
            addChild(fireParticle)
        }
        Ball.removeFromParent()
    }
    
}
