//
//  ListOfActivitiesController.swift
//  Watch My Progress WatchKit Extension
//
//  Created by Silviu Macovei on 07/05/2019.
//  Copyright © 2019 Watch My Progress. All rights reserved.
//

import WatchKit
import Foundation

struct Headline {
    var title : String
}
class ListOfActivitiesController: WKInterfaceController {

    @IBOutlet weak var listOfActivitiesTable: WKInterfaceTable!
    
    
    let rowTypes = [HeaderController.type, HeaderController.type, HeaderController.type]
    var headlines = [
        Headline( title: "Timer"),
        Headline( title: "Activity"),
        Headline(title: "Invoices")
    ]

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        listOfActivitiesTable.setNumberOfRows(headlines.count, withRowType: HeaderController.type)
        listOfActivitiesTable.setRowTypes(rowTypes)
        
        for (index, element) in headlines.enumerated() {
            let row = listOfActivitiesTable.rowController(at: index) as! HeaderController
            row.titleLabel.setText(element.title)
        }
        
    }
    
    override func table(_ table: WKInterfaceTable, didSelectRowAt rowIndex: Int) {
        switch rowIndex {
        case 0:
            self.pushController(withName: "addTimeInterval", context: nil)
        case 1:
            self.pushController(withName: "graph", context: nil)
        default:
            self.pushController(withName: "RingInterfaceController", context: nil)
            
        }
    }
}
