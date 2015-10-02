//
//  GameScene.swift
//  Hack Your Brain
//
//  Created by Zoom NGUYEN on 3/18/15.
//  Copyright (c) 2015 ZoomStudio. All rights reserved.
//

import SpriteKit
//import AVFoundation
import UIKit


class GameScene: SKScene  {
    
    var myLabel = SKLabelNode()
    var myScore = SKLabelNode()
    var myHighestScore = SKLabelNode()
    
    var myCubic = SKSpriteNode()
    
    var scoreValue = Int()
    var cubicValue = Int()
    var ballValue = Int()
    var speedGame = NSTimeInterval()
    
    var ballGreenTexture = SKTexture(imageNamed: "green.png")
    var ballBlueTexture = SKTexture(imageNamed: "blue.png")
    var ballYellowTexture = SKTexture(imageNamed: "yellow.png")
    var ballRedTexture = SKTexture(imageNamed: "red.png")
    
//    var player = AVAudioPlayer()
    

    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        //Sound

        // init Audio Player
//        var alertSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("bgSound", ofType: "mp3")!)
//        // Removed deprecated use of AVAudioSessionDelegate protocol
//        AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback, error: nil)
//        AVAudioSession.sharedInstance().setActive(true, error: nil)
//        
//        var error:NSError?
//        player = AVAudioPlayer(contentsOfURL: alertSound, error: &error)
//        player.prepareToPlay()
        
        
        
        scoreValue = 0
        cubicValue = 1 // Meen yellow color
        speedGame  = 2
        
        //My Highest Score
        myHighestScore = SKLabelNode(fontNamed:"Chalkduster")
        myHighestScore.color = SKColor.blueColor()
        myHighestScore.colorBlendFactor = 1
        myHighestScore.fontSize = 30;
        
        print(CGRectGetMidX(self.frame))
        myHighestScore.position = CGPoint(x: CGRectGetMidX(self.frame) - 100 , y: self.frame.height - 100)
        if (NSUserDefaults.standardUserDefaults().objectForKey("highestScore") != nil) {
            myHighestScore.text = String(format: "Record: %d",NSUserDefaults.standardUserDefaults().objectForKey("highestScore") as! Int )
        }else {
            NSUserDefaults.standardUserDefaults().setObject(0, forKey: "highestScore")
            NSUserDefaults.standardUserDefaults().synchronize()
            myHighestScore.text = String(format: "Record: %d",NSUserDefaults.standardUserDefaults().objectForKey("highestScore") as! Int )
        }
        self.addChild(myHighestScore)
        
//        backgroundColor = UIColor.whiteColor()
        writeScore(String(scoreValue))
        writeSomeThing("Let's Go !")
        
        var cubicTexture =  SKTexture (imageNamed: "cubic.png")
        myCubic = SKSpriteNode(texture: cubicTexture)
        myCubic.size = CGSizeMake (self.frame.width / 4,self.frame.width / 4)
        myCubic.position = CGPoint(x: CGRectGetMidX(self.frame) , y: (CGRectGetMidY(self.frame) - 200))
        self.addChild(myCubic)
        
        
        
        var countdown = NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: Selector("countdown"), userInfo: nil, repeats: false)
    }
    func resetGame(){
        /* Setup your scene here */
        scoreValue  = 0
        cubicValue  = 1 // Meen yellow color
        speedGame   = 2
//        self.player.currentTime = 0
        myLabel.removeFromParent()
        myCubic.removeFromParent()
        
        myScore.text = "0"
        
        writeSomeThing("Let's Go !")
        
        let cubicTexture =  SKTexture (imageNamed: "cubic.png")
        myCubic = SKSpriteNode(texture: cubicTexture)
        myCubic.size = CGSizeMake (self.frame.width / 4,self.frame.width / 4)
        myCubic.position = CGPoint(x: CGRectGetMidX(self.frame) , y: (CGRectGetMidY(self.frame) - 200))
        self.addChild(myCubic)
        
        
        
        var countdown = NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: Selector("countdown"), userInfo: nil, repeats: false)
        
    }
    func writeScore(text:NSString){
        
        myScore = SKLabelNode(fontNamed:"Chalkduster")
        myScore.text = text as String
        myScore.color = SKColor.redColor()
        myScore.colorBlendFactor = 1
        myScore.fontSize = 80;
        myScore.position = CGPoint(x:CGRectGetMidX(self.frame) - 150, y:(CGRectGetMidY(self.frame)) + 100 );
        self.addChild(myScore)
    }
    func writeSomeThing(text:NSString){
        myLabel = SKLabelNode(fontNamed:"Chalkduster")
        myLabel.text = text as String
        myLabel.color = SKColor.blackColor()
        myLabel.colorBlendFactor = 1
        myLabel.fontSize = 40;
        myLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame));
        self.addChild(myLabel)
    }
    
    func countdown(){
        myLabel.text = "1"
        var countdown = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("count2"), userInfo: nil, repeats: false)
    }
    func count2(){
        myLabel.text = "2"
        var countdown = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("count3"), userInfo: nil, repeats: false)
    }
    func count3(){
        myLabel.text = "3"
        var countdown = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("gameStart"), userInfo: nil, repeats: false)
    }
    
    
    func gameStart(){
//        player.play()
        myLabel.removeFromParent()
        ballValue = randomBallValue(1, max: 4)
        
        //Game is Started
        var ball = SKSpriteNode()
        
        switch ballValue{
        case 1:
            ball = SKSpriteNode(texture: ballYellowTexture)
        case 2:
            ball = SKSpriteNode(texture: ballBlueTexture)
        case 3:
            ball = SKSpriteNode(texture: ballGreenTexture)
        case 4:
            ball = SKSpriteNode(texture: ballRedTexture)
        default:
            break
        }
        
        ball.size = CGSizeMake(self.frame.width / 15 ,self.frame.width / 15)
        ball.position = CGPoint(x: CGRectGetMidX(self.frame) , y: (CGRectGetMidY(self.frame) + 200))
        ball.zPosition = -1
        self.addChild(ball)
        
        //Ball drop down
        var moveBottom = SKAction.moveToY((CGRectGetMidY(self.frame) - 200 + (self.frame.width / 8)), duration: speedGame)
        ball.runAction(moveBottom, completion: {
            ball.removeFromParent()
            
            if(self.checkScored(self.cubicValue, ball: self.ballValue)){
                
                self.scoreValue += 1
                self.myScore.text = String(self.scoreValue)
                self.speedGame -= 0.02
                self.gameStart()
            } else {
                
                
                if (self.scoreValue > NSUserDefaults.standardUserDefaults().objectForKey("highestScore") as! Int){
                    NSUserDefaults.standardUserDefaults().setObject(self.scoreValue, forKey: "highestScore")
                    NSUserDefaults.standardUserDefaults().synchronize()
                    self.myHighestScore.text = String(format: "Record: %d",NSUserDefaults.standardUserDefaults().objectForKey("highestScore") as! Int)
                    self.writeSomeThing("New Record !")
//                    self.player.stop()
                }else {
                    self.writeSomeThing("You Lose !")
//                    self.player.stop()
                }
                
                var countdown = NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: Selector("resetGame"), userInfo: nil, repeats: false)
            }
        })
        
    }
    
    func checkScored(cubic:Int,ball:Int)->Bool {
        return (cubic==ball)
    }
    
    
    func randomBallValue(min: Int, max:Int) -> Int {
        return min + Int(arc4random_uniform(UInt32(max - min + 1)))
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch begins */
        
        for touch: AnyObject in touches {
            
            let action = SKAction.rotateByAngle(CGFloat(M_PI/2), duration:0.2)
            myCubic.runAction(action)
            if(cubicValue != 4){
                cubicValue += 1
            }else{
                cubicValue = 1
            }
            
            print(cubicValue)
            
        }
    }

    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
