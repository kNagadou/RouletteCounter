//
//  ViewController.swift
//  RussianRouletteCounter
//
//  Created by 長堂嘉寿将 on 2015/12/18.
//  Copyright © 2015年 kNagadou. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController,AVAudioPlayerDelegate {
    
    @IBOutlet weak var count: UILabel!
    @IBOutlet weak var reStartButton: UIButton!
    
    var countAudioPlayer:AVAudioPlayer!
    var reStartAudioPlayer:AVAudioPlayer!
    var bombAudioPlayer:AVAudioPlayer!
    
    var random = arc4random_uniform(40)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setAudioPlayer()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onReStartButton(sender: AnyObject) {
        self.count.text = "0"
        self.count.textColor = UIColor.whiteColor()
        self.count.font = UIFont.systemFontOfSize(200)
        random = arc4random_uniform(40)
        reStartAudioPlayer.play()

    }
    
    override func canBecomeFirstResponder() -> Bool {
        return true
    }
    
    override func motionBegan(motion: UIEventSubtype, withEvent event: UIEvent?) {
        if event?.type == UIEventType.Motion && event?.subtype == UIEventSubtype.MotionShake {
            NSLog("began");
            let count = Int(self.count.text!)! + 1
            if Int(random) != count {
                self.count.text = count.description
                countAudioPlayer.play()
            } else {
                self.count.text = "Bang!"
                self.count.textColor = UIColor.redColor()
                self.count.font = UIFont.systemFontOfSize(100)
                bombAudioPlayer.play()
            }

        }
    }
    
    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent?) {
        if event?.type == UIEventType.Motion && event?.subtype == UIEventSubtype.MotionShake {
            NSLog("ended");
//            let count = Int(self.count.text!)! + 1
//            if Int(random) != count {
//                self.count.text = count.description
//                countAudioPlayer.play()
//            } else {
//                self.count.text = "Bang!"
//                self.count.textColor = UIColor.redColor()
//                self.count.font = UIFont.systemFontOfSize(100)
//                bombAudioPlayer.play()
//            }
        }
    }
    
    override func motionCancelled(motion: UIEventSubtype, withEvent event: UIEvent?) {
        if event?.type == UIEventType.Motion && event?.subtype == UIEventSubtype.MotionShake {
            NSLog("cancelled");
        }
    }
    
    func setAudioPlayer() {
        let countSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("cursor4", ofType: "mp3")!)
        let reStartSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("cancel2", ofType: "mp3")!)
        let bombSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("bomb1", ofType: "mp3")!)
        do {
            countAudioPlayer = try AVAudioPlayer(contentsOfURL: countSound, fileTypeHint: nil)
            reStartAudioPlayer = try AVAudioPlayer(contentsOfURL: reStartSound, fileTypeHint: nil)
            bombAudioPlayer = try AVAudioPlayer(contentsOfURL: bombSound, fileTypeHint: nil)
            countAudioPlayer.delegate = self
            reStartAudioPlayer.delegate = self
            bombAudioPlayer.delegate = self
        } catch {
            NSLog("Audio Init Err!");
        }
    }
    
}

