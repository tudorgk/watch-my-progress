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
    @IBOutlet weak var startPauseButton: WKInterfaceButton!
    
    @IBOutlet weak var stopButton: WKInterfaceButton!

    @IBAction func switchToListMenuItem() {
        pushController(withName: "intervalList", context: nil)
    }
    @IBAction func switchToGraph() {
        pushController(withName: "graph", context: nil)
    }
    
    var trackingTimer : PausableTimer?  //internal timer to keep track
    var isPaused = false //flag to determine if it is paused or not
    var firstStart = false
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
    }
    
    override func willActivate(){
        super.willActivate()
    
    
    }
    
    @IBAction func pauseResumePressed() {
        if !firstStart {
            
            trackingTimer = PausableTimer.init(interval: 1.0, delegate: self, autostart: true, repeats: true)
            
            firstStart = true
            startPauseButton.setTitle("Pause")
            return
            
        }
        
        //timer is paused. so unpause it and resume countdown
        if isPaused{
            isPaused = false
            
            trackingTimer?.resume()
            
            startPauseButton.setTitle("Pause")
        }
            //pause the timer
        else{
            isPaused = true
        
            //stop watchkit timer on the screen
            trackingTimer?.pause()
            
            //do whatever UI changes you need to
            startPauseButton.setTitle("Resume")
        }
    }
    
    @IBAction func stopButtonTapped() {
        firstStart = false
        startPauseButton.setTitle("Start")
        trackingTimer?.stop()
        trackingTimer = nil
    }

    
    fileprivate func syncUserDefaultsWith(interval: TimeInterval, forKey key: String) {
        if let oldTimeIntervals = UserDefaults.standard.array(forKey: key) as? [Double] {
            var intervals: [Double] = []
            intervals.append(contentsOf: oldTimeIntervals)
            intervals.append(interval)
            UserDefaults.standard.set(intervals, forKey: key)
        } else {
            UserDefaults.standard.set([interval], forKey: key)
        }
    }
    
    func timerStopped(interval: TimeInterval) {
        presentAlert(
            withTitle: "Hooray! You did \(interval) seconds of work!",
            message: "Choose which project you want to save to",
            preferredStyle: .actionSheet,
            actions: [
                WKAlertAction(title: "Mobile Meetup Hackathon", style: .default, handler: {
                    self.syncUserDefaultsWith(interval: interval, forKey: "Mobile Meetup Hackathon")
                    self.dismiss()
                }),
                WKAlertAction(title: "Boring Project", style: .default, handler: {
                    self.syncUserDefaultsWith(interval: interval, forKey: "Boring Project")
                    self.dismiss()
                }),
                WKAlertAction(title: "Cancel", style: .cancel, handler: {
                    self.dismiss()
                })
            ])
    }
    
    let timerForamtter : DateComponentsFormatter = {
        var dcf = DateComponentsFormatter()
        dcf.unitsStyle = .short
        return dcf
    }()
    
    func elapsedTime(interval: TimeInterval) {
        timerLabel.setText(timerForamtter.string(from: interval))
    }

}
