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
import YOChartImageKit

class HeartRateInterfaceController: WKInterfaceController {
    @IBOutlet private weak var image: WKInterfaceImage!

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()

        let rates = [50, 51, 52, 53, 54, 55, 70, 90, 120, 180, 155, 143, 128, 111, 78, 53, 43, 12, 0]
        let values = rates.map { NSNumber(value: $0) }



        let frame = CGRect(x: 0,
                           y: 0,
                           width: self.contentFrame.width,
                           height: self.contentFrame.height * 0.8)

        let chart = YOBarChartImage()
        chart.values = values
        chart.fillColor = UIColor.red

        let chartImage = chart.draw(frame, scale: WKInterfaceDevice.current().screenScale)
        self.image.setImage(chartImage)

//        getHeartRates { (heartRates) in
//            DispatchQueue.main.async {
//                let rates = heartRates.map { $0.doubleValue(for: HKUnit(from: "count/min")) }
//                let values = rates.map { NSNumber(value: $0) }
//
//                let frame = CGRect(x: 0,
//                                   y: 0,
//                                   width: self.contentFrame.width,
//                                   height: self.contentFrame.height)
//                let chart = YOBarChartImage()
//                chart.values = values
//                chart.fillColor = UIColor.red
//
//                let chartImage = chart.draw(frame, scale: WKInterfaceDevice.current().screenScale)
//                self.image.setImage(chartImage)
//            }
//        }
    }
}

extension HeartRateInterfaceController {
    func getHeartRates(completion: @escaping ([HKQuantity]) -> Void) {

        let heartRateQuantityType = HKQuantityType.quantityType(forIdentifier: .heartRate)!

        let start = Calendar.current.date(byAdding: .hour, value: -2, to: Date())
        let end = Date()
        let predicate = HKQuery.predicateForSamples(withStart: start, end: end, options: .strictStartDate)

        let query = HKSampleQuery(
            sampleType: heartRateQuantityType,
            predicate: predicate,
            limit: 10000,
            sortDescriptors: nil) { (query, samples, error) in

                guard let samples = samples else { fatalError() }
                guard let quantitySamples: [HKQuantitySample] = samples as? [HKQuantitySample] else { fatalError() }

                let heartRates = quantitySamples.map { $0.quantity }

                DispatchQueue.main.async {
                    completion(heartRates)
                }
        }

        HKHealthStore().execute(query)
    }
}
