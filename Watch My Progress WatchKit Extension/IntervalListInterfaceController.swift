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
    
    let headerType = "headerType"
    let cellType = "cellType"
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        timerTable.setRowTypes([headerType, cellType, cellType, headerType])
    
    }
    
    override func willActivate(){
        super.willActivate()
    
    }
}
