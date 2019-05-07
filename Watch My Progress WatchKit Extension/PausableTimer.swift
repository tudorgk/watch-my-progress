//
//  PausableTimer.swift
//  Watch My Progress WatchKit Extension
//
//  Created by Tudor Dragan on 07/05/2019.
//  Copyright © 2019 Watch My Progress. All rights reserved.
//

import Foundation

public protocol PausableTimerDelegate: class {
    func PausableTimerEvent(PausableTimer: PausableTimer)
}

public class PausableTimer {
    private var timer: Timer? {
        didSet {
            if timer != nil {
                startTime = Date()
                pausedInterval = nil
            }
        }
    }
    

    private var interval: TimeInterval
    private var repeats = false
    private var startTime: Date?
    private var pausedInterval: TimeInterval?
    weak public var delegate: PausableTimerDelegate?
    
    public var isPaused: Bool {
        return pausedInterval != nil
    }

    public var isRunning: Bool {
        return timer != nil
    }

    public var timeRemaining: TimeInterval? {
        if let startTime = startTime {
            return Date().timeIntervalSince(startTime)
        }
        
        return nil
    }
    
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
        timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: repeats, block: { [weak self] _ in
            self?.timerCompleted()
        })
    }
    
    public func pause() {
        if isRunning,
            let startTime = startTime {
            pausedInterval = Date().timeIntervalSince(startTime)
            terminateTimer()
        }
    }
    
    public func resume() {
        if let pausedInterval = pausedInterval {
            interval = pausedInterval
            start()
        }
    }

    private func timerCompleted() {
        delegate?.PausableTimerEvent(PausableTimer: self)
        if !repeats {
            terminateTimer()
        }
    }
    
    private func terminateTimer() {
        timer?.invalidate()
        timer = nil
    }
}
