//
//  HeartRateInterfaceController.swift
//  Watch My Progress WatchKit Extension
//
//  Created by Dennis Örnberg on 2019-05-07.
//  Copyright © 2019 Watch My Progress. All rights reserved.
//

import WatchKit
import Foundation
import HealthKit

class HeartRateInterfaceController: WKInterfaceController {
    @IBOutlet private weak var label: WKInterfaceLabel!
    @IBOutlet private weak var button: WKInterfaceButton!

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()

        button.setTitle("Fetch")
    }

    @IBAction func buttonPressed() {
        getHeartRates { (heartRates) in
            DispatchQueue.main.async {
                let rates = heartRates.map { $0.doubleValue(for: HKUnit(from: "count/min")) }
                self.label.setText("\(rates)")
            }
        }
    }
}

extension HeartRateInterfaceController {
    func getHeartRates(completion: @escaping ([HKQuantity]) -> Void) {

        let heartRateQuantityType = HKQuantityType.quantityType(forIdentifier: .heartRate)!

        let now = Date()
        let startOfDay = Calendar.current.startOfDay(for: now)
        let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: now, options: .strictStartDate)

        let query = HKSampleQuery(sampleType: heartRateQuantityType,
                      predicate: predicate,
                      limit: 10000,
                      sortDescriptors: nil) { (query, samples, error) in

                        guard let samples = samples else { fatalError("oopsie") }

                        guard let quantitySamples: [HKQuantitySample] = samples as? [HKQuantitySample] else { return }

                        let heartRates = quantitySamples.map { $0.quantity }

                        DispatchQueue.main.async {
                            completion(heartRates)
                        }

        }

        HKHealthStore().execute(query)
    }
}
