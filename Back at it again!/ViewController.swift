//
//  ViewController.swift
//  Back at it again!
//
//  Created by Calvin Chueh on 2/23/16.
//  Copyright © 2016 oncloudcal.com. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    var audioPlayer = AVAudioPlayer()
    var audioRecorder = AVAudioRecorder()
    let fileName = "demo.caf"
    
    @IBOutlet weak var damn1: UIButton!
    @IBOutlet weak var damn2: UIButton!
    @IBOutlet weak var damn3: UIButton!
    @IBOutlet weak var full: UIButton!
    @IBOutlet weak var stop: UIButton!
    
    @IBOutlet weak var recordButton: UIButton!
    
    @IBAction func recordSound(sender: UIButton) {
        
    }
    
    @IBAction func stopSound(sender: AnyObject) {
        audioPlayer.stop()
    }
    @IBAction func playFull(sender: AnyObject) {
        playSound("DAMN DANIEL")
        
    }
    
    @IBAction func playDamn1(sender: AnyObject) {
        playSound("damn1")
    }
    
    @IBAction func playDamn2(sender: AnyObject) {
        playSound("damn2")
    }
    
    @IBAction func playDamn3(sender: AnyObject) {
        playSound("damn3")
    }
    
    func playSound(name: String) {
        print("called")
        let url:NSURL = NSBundle.mainBundle().URLForResource(name, withExtension: "mp3")!
        
        do { audioPlayer = try AVAudioPlayer(contentsOfURL: url, fileTypeHint: nil) }
        catch let error as NSError { print(error.description) }
        
        audioPlayer.currentTime = 0.0
        audioPlayer.prepareToPlay()
        audioPlayer.play()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.view.backgroundColor = UIColor(patternImage: UIImage(named: "white_van.jpg")!)
        var buttons = [UIButton!]()
        buttons.append(damn1)
        buttons.append(damn2)
        buttons.append(damn3)
        buttons.append(full)
        buttons.append(stop)
        
        for button in buttons {
            formatButton(button)
        }
    
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    func formatButton(button: UIButton) {
        //button.frame = CGRectMake(400, 400, 300, 300)
        
        button.tintColor = UIColor.redColor()
        button.layer.cornerRadius = 0.5 * button.bounds.size.width
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.blackColor().CGColor
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

