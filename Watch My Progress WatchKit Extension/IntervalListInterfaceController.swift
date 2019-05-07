//
//  IntervalListInterfaceController.swift
//  Watch My Progress WatchKit Extension
//
//  Created by Tudor Dragan on 07/05/2019.
//  Copyright © 2019 Watch My Progress. All rights reserved.
//

import Foundation
import WatchKit

class IntervalListInterfaceController: WKInterfaceController {
        @IBOutlet weak var timerTable: WKInterfaceTable!
    @IBAction func changeToAddTimeIntervalScreen() {
        popToRootController()
    }
    
//    let rowTypes = [HeaderController.type, RowController.type, RowController.type, HeaderController.type, RowController.type]
//    let rowDataSource = ["Mobile Meetup Hackathon", "10 sec", "10 min", "Boringc Project", "59 min 2 sec"]
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        let (rowTypes, rowDataSource) = getTimeIntervalsFromUserDefaults()
        timerTable.setRowTypes(rowTypes)
        for (index, element) in rowTypes.enumerated() {
            if element == HeaderController.type {
                let header = timerTable.rowController(at: index) as! HeaderController
                header.titleLabel.setText(rowDataSource[index])
            } else {
                let row = timerTable.rowController(at: index) as! RowController
                row.titleLabel.setText(rowDataSource[index])
            }
        }
    }
    
    let timerForamtter : DateComponentsFormatter = {
        var dcf = DateComponentsFormatter()
        dcf.unitsStyle = .short
        return dcf
    }()
    
    fileprivate func generateListForKey(_ key: String, _ list: inout [String], _ rowTypes: inout [String]) {
        if let array = UserDefaults.standard.array(forKey: key) as? [Double] {
            list.append(key)
            rowTypes.append(HeaderController.type)
            for value in array{
                list.append(timerForamtter.string(from: value) as! String)
                rowTypes.append(RowController.type)
            }
        }
    }
    
    func getTimeIntervalsFromUserDefaults() -> ([String], [String]) {
        var rowTypes: [String] = []
        var list: [String] = []
        generateListForKey("Mobile Meetup Hackathon", &list, &rowTypes)
        generateListForKey("Boring Project", &list, &rowTypes)
        return (rowTypes, list)
    }
}
