//
//  InterfaceController.swift
//  Watch My Progress WatchKit Extension
//
//  Created by Tudor Dragan on 07/05/2019.
//  Copyright © 2019 Watch My Progress. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController, PausableTimerDelegate {
    @IBOutlet weak var timerLabel: WKInterfaceLabel!
    @IBOutlet weak var mainTimer: WKInterfaceTimer!
    @IBOutlet weak var startPauseButton: WKInterfaceButton!
    
    @IBOutlet weak var stopButton: WKInterfaceButton!

    
    var trackingTimer : PausableTimer?  //internal timer to keep track
    var isPaused = false //flag to determine if it is paused or not
    var firstStart = false
    var startDate: Date!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
    }
    
    override func willActivate(){
        super.willActivate()
    
    
    }
    
    @IBAction func pauseResumePressed() {
        if !firstStart {
            startDate = Date()
            mainTimer.setDate(startDate)
            mainTimer.start()
            
            trackingTimer = PausableTimer.init(interval: 1.0, delegate: self, autostart: true, repeats: true)
            
            firstStart = true
            startPauseButton.setTitle("Pause")
            return
            
        }
        
        //timer is paused. so unpause it and resume countdown
        if isPaused{
            isPaused = false
            
            mainTimer.setDate(Date(timeInterval: (trackingTimer?.timeElapsed)!, since: startDate))
            mainTimer.start()
            trackingTimer?.resume()
            
            startPauseButton.setTitle("Pause")
        }
            //pause the timer
        else{
            isPaused = true
        
            //stop watchkit timer on the screen
            mainTimer.stop()
            trackingTimer?.pause()
            
            //do whatever UI changes you need to
            startPauseButton.setTitle("Resume")
        }
    }
    
    @IBAction func stopButtonTapped() {
        mainTimer.stop()
        mainTimer.setDate(Date())
        firstStart = false
        startPauseButton.setTitle("Start")
        
        print("Time Remaining = \(String(describing: trackingTimer?.timeElapsed.debugDescription))")
        //TODO: Show action sheet to save the timer.
    }
    
    @objc func timerDone(){
        //timer done counting down
    }
    
    func timerStopped(PausableTimer: PausableTimer) {
//        timerLabel.setText(PausableTimer.timeElapsed.debugDescription)
    }
    
    
    func elapsedTime(interval: TimeInterval) {
        timerLabel.setText(interval.debugDescription)
    }

}
