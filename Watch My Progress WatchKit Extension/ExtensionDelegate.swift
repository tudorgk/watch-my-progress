//
//  ExtensionDelegate.swift
//  Watch My Progress WatchKit Extension
//
//  Created by Tudor Dragan on 07/05/2019.
//  Copyright © 2019 Watch My Progress. All rights reserved.
//

import WatchKit

class ExtensionDelegate: NSObject, WKExtensionDelegate {

    func applicationDidFinishLaunching() {
    }

    func applicationDidBecomeActive() {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillResignActive() {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, etc.
    }

    func handle(_ backgroundTasks: Set<WKRefreshBackgroundTask>) {
        // Sent when the system needs to launch the application in the background to process tasks. Tasks arrive in a set, so loop through and process each one.
        for task in backgroundTasks {
            // Use a switch statement to check the task type
            switch task {
            case let backgroundTask as WKApplicationRefreshBackgroundTask:
                // Be sure to complete the background task once you’re done.
                backgroundTask.setTaskCompletedWithSnapshot(false)
            case let snapshotTask as WKSnapshotRefreshBackgroundTask:
                // Snapshot tasks have a unique completion call, make sure to set your expiration date
                snapshotTask.setTaskCompleted(restoredDefaultState: true, estimatedSnapshotExpiration: Date.distantFuture, userInfo: nil)
            case let connectivityTask as WKWatchConnectivityRefreshBackgroundTask:
                // Be sure to complete the connectivity task once you’re done.
                connectivityTask.setTaskCompletedWithSnapshot(false)
            case let urlSessionTask as WKURLSessionRefreshBackgroundTask:
                // Be sure to complete the URL session task once you’re done.
                urlSessionTask.setTaskCompletedWithSnapshot(false)
            case let relevantShortcutTask as WKRelevantShortcutRefreshBackgroundTask:
                // Be sure to complete the relevant-shortcut task once you're done.
                relevantShortcutTask.setTaskCompletedWithSnapshot(false)
            case let intentDidRunTask as WKIntentDidRunRefreshBackgroundTask:
                // Be sure to complete the intent-did-run task once you're done.
                intentDidRunTask.setTaskCompletedWithSnapshot(false)
            default:
                // make sure to complete unhandled task types
                task.setTaskCompletedWithSnapshot(false)
            }
        }
    }

    // Triggered when a complication is tapped
    func handleUserActivity(_ userInfo: [AnyHashable : Any]?) {
        guard
            let date = userInfo?[CLKLaunchedTimelineEntryDateKey] as? Date,
            let type = date.complicationTypeFromEncodedDate
            else {
                return
        }
        switch type {
        case .small1:
            WKInterfaceController.reloadRootControllers(
                withNamesAndContexts: [(name: "addTimeInterval", context: ["action": "checkIn"] as AnyObject)])
        default:
            WKInterfaceController.reloadRootControllers(withNamesAndContexts: [(name: "HeartRateController",
                                                                                context: [] as AnyObject)])
        }

    }
}

enum ComplicationType: Int {
    case big
    case small1
    case small2
}

extension Date {
    var complicationTypeFromEncodedDate: ComplicationType? {
        let calendar = Calendar.current
        let ns = calendar.component(.nanosecond, from: self)

        return ComplicationType(rawValue: ns.nanosecondsToMilliseconds)
    }
}

extension Int {
    var nanosecondsToMilliseconds: Int {
        return Int(round(Double(self) / 1000000))
    }
}

extension Date {
    func encodedForComplication(type: ComplicationType) -> Date? {
        let calendar = Calendar.current

        var dc = calendar.dateComponents(in: calendar.timeZone, from: self)
        dc.nanosecond = type.rawValue.millisecondsToNanoseconds

        return calendar.date(from: dc)
    }
}

extension Int {
    var millisecondsToNanoseconds: Int {
        return self * 1000000
    }
}
