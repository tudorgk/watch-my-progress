//
//  HeartRateInterfaceController.swift
//  Watch My Progress WatchKit Extension
//
//  Created by Dennis Örnberg on 2019-05-07.
//  Copyright © 2019 Watch My Progress. All rights reserved.
//

import WatchKit
import Foundation


class HeartRateInterfaceController: WKInterfaceController {
    @IBOutlet private weak var label: WKInterfaceLabel!

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        label.setText("YO")
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
}
