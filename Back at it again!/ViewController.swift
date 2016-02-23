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
    var audioRecorder: AVAudioRecorder!
    
    @IBOutlet weak var damn1: UIButton!
    @IBOutlet weak var damn2: UIButton!
    @IBOutlet weak var damn3: UIButton!
    @IBOutlet weak var full: UIButton!
    @IBOutlet weak var stop: UIButton!
    @IBOutlet weak var record: UIButton!
    
    var isRecording = true
    var nameRecorded = false
    
    @IBAction func recordSound(sender: UIButton) {
        print("clicked")
        if nameRecorded {
            if (!audioRecorder.recording){
                do {
                    try audioPlayer = AVAudioPlayer(contentsOfURL: audioRecorder.url)
                    audioPlayer.play()
                } catch {
                }
            }
        }
        else if isRecording {
            print("isrecording")
            record.setTitle("Stop Record", forState: UIControlState.Normal)
            isRecording = false
            if !audioRecorder.recording {
                let audioSession = AVAudioSession.sharedInstance()
                do {
                    try audioSession.setActive(true)
                    audioRecorder.record()
                } catch {
                }
            }
        } else {
            record.setTitle("Play Name", forState: UIControlState.Normal)
            isRecording = true
            audioRecorder.stop()
            nameRecorded = true
            let audioSession = AVAudioSession.sharedInstance()
            do {
                try audioSession.overrideOutputAudioPort(AVAudioSessionPortOverride.Speaker)
                try audioSession.setActive(false)
            } catch {
            }

        }
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
        audioPlayer.volume = 1
        audioPlayer.play()
    }
    
    let recordSettings = [AVSampleRateKey : NSNumber(float: Float(44100.0)),
        AVFormatIDKey : NSNumber(int: Int32(kAudioFormatMPEG4AAC)),
        AVNumberOfChannelsKey : NSNumber(int: 1),
        AVEncoderAudioQualityKey : NSNumber(int: Int32(AVAudioQuality.Medium.rawValue))]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "DAMNNNN"
        
        var buttons = [UIButton!]()
        buttons.append(damn1)
        buttons.append(damn2)
        buttons.append(damn3)
        buttons.append(full)
        buttons.append(stop)
        buttons.append(record)
        
        for button in buttons {
            formatButton(button)
        }
        
        let audioSession = AVAudioSession.sharedInstance()
        do {
            //try audioSession.overrideOutputAudioPort(AVAudioSessionPortOverride.Speaker)
            try audioSession.setCategory(AVAudioSessionCategoryPlayAndRecord)
            try audioRecorder = AVAudioRecorder(URL: self.directoryURL()!,
                settings: recordSettings)
            audioRecorder.prepareToRecord()
        } catch {
        }
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    func directoryURL() -> NSURL? {
        let fileManager = NSFileManager.defaultManager()
        let urls = fileManager.URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        let documentDirectory = urls[0] as NSURL
        let soundURL = documentDirectory.URLByAppendingPathComponent("sound.m4a")
        return soundURL
    }
    
    func formatButton(button: UIButton) {
        
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

