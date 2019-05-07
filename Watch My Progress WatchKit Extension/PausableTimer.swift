//
//  PausableTimer.swift
//  Watch My Progress WatchKit Extension
//
//  Created by Tudor Dragan on 07/05/2019.
//  Copyright © 2019 Watch My Progress. All rights reserved.
//

import Foundation

public protocol PausableTimerDelegate: class {
    func timerStopped(PausableTimer: PausableTimer)
    func elapsedTime(interval: TimeInterval)
}

public class PausableTimer {
    private var timer: Timer? {
        didSet {
            if timer != nil {
                startTime = Date()
            }
        }
    }

    private var interval: TimeInterval
    private var repeats = false
    private var startTime: Date?
    weak public var delegate: PausableTimerDelegate?
    
    public var isPaused: Bool = false
    public var timeElapsed: TimeInterval = 0
    
    public init(interval: TimeInterval, repeats: Bool = false) {
        self.interval = interval
        self.repeats = repeats
    }
    
    public init(interval: TimeInterval, delegate: PausableTimerDelegate, autostart: Bool, repeats: Bool = false) {
        self.interval = interval
        self.delegate = delegate
        self.repeats = repeats
        
        if autostart {
            start()
        }
    }
    
    deinit {
        timer?.invalidate()
    }

    public func start() {
        timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: repeats, block: { [unowned self] _ in
            self.timeElapsed = self.timeElapsed + self.interval
            self.delegate?.elapsedTime(interval: self.timeElapsed)
        })
    }
    
    public func pause() {
        if !isPaused {
            terminateTimer()
        }
    }
    
    public func resume() {
        start()
    }
    
    public func stop() {
        self.delegate?.elapsedTime(interval: timeElapsed)
        self.timerCompleted()
        timeElapsed = 0
    }
    
    
    private func timerCompleted() {
        delegate?.timerStopped(PausableTimer: self)
        if !repeats {
            terminateTimer()
        }
    }
    
    private func terminateTimer() {
        timer?.invalidate()
        timer = nil
    }
}
