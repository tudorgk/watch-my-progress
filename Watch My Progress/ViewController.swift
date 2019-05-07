//
//  ViewController.swift
//  Watch My Progress
//
//  Created by Tudor Dragan on 07/05/2019.
//  Copyright © 2019 Watch My Progress. All rights reserved.
//

import HealthKit
import UIKit

class ViewController: UIViewController {

    let healthStore = HKHealthStore()

    override func viewDidLoad() {
        super.viewDidLoad()

        let healthKitTypes: Set = [
            HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.heartRate)!
        ]
        healthStore.requestAuthorization(toShare: nil, read: healthKitTypes) { (bool, error) in
            if let e = error {
                print("something went wrong during authorization \(e.localizedDescription)")
            } else {
                print("User has completed the authorization flow")
            }
        }
    }
}

