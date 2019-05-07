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
    
    let rowTypes = [HeaderController.type, RowController.type, RowController.type, HeaderController.type, RowController.type]
    let rowDataSource = ["Mobile Meetup Hackathon", "10 sec", "10 min", "Boringc Project", "59 min 2 sec"]
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
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
    
    override func willActivate(){
        super.willActivate()
    
    }
}
