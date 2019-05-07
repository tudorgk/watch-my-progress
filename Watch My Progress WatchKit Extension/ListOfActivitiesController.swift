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
class ListOfActivitiesControler: WKInterfaceController {

    @IBOutlet weak var listOfActivitiesTable: WKInterfaceTable!
    
    var headlines = [
        Headline( title: "Lorem Ipsum"),
        Headline( title: "Aenean condimentum"),
        Headline( title: "In ac ante sapien"),
    ]

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        listOfActivitiesTable.setNumberOfRows(headlines.count, withRowType: "FlightRow")
        
    }
}
