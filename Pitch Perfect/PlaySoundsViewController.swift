//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by APARNA SRIDHAR on 12/15/14.
//  Copyright (c) 2014 Shoonya. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {

    var audioPlayer:AVAudioPlayer!
    var recordedAudio:RecordedAudio!
    var audioEngine:AVAudioEngine!
    var audioFile:AVAudioFile!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        audioEngine=AVAudioEngine()
        
        audioPlayer = AVAudioPlayer(contentsOfURL: recordedAudio.filePathURL, error: nil)
        audioPlayer.enableRate=true;
        
        audioFile=AVAudioFile(forReading: recordedAudio.filePathURL, error: nil)
        // Do any additional setup after loading the view.
    }

    @IBAction func playChipmunk(sender: UIButton) {
     
        playPitch(1000)
    }
    
    @IBAction func playDarthVader(sender: UIButton) {
        
        playPitch(-1000)
    }
    func playPitch(pitch: Float)
    {
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        
        var pitchPlayer = AVAudioPlayerNode()
        audioEngine.attachNode(pitchPlayer)
        
        var timePitch = AVAudioUnitTimePitch()
        timePitch.pitch = pitch
        audioEngine.attachNode(timePitch)
        
        audioEngine.connect(pitchPlayer, to: timePitch, format: nil)
        audioEngine.connect(timePitch, to: audioEngine.outputNode, format: nil)
        
        pitchPlayer.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        pitchPlayer.play()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func playFast(sender: UIButton) {
        audioPlayer.rate=2.0
        audioPlayer.play()
    }
    
 
    @IBAction func stopAudio(sender: UIButton) {
         audioPlayer.stop()
    }
    @IBAction func playSlow(sender: UIButton) {
        audioPlayer.rate=0.5;
        audioPlayer.play();
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
