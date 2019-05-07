//
//  HeaderRow.swift
//  Watch My Progress WatchKit Extension
//
//  Created by Tudor Dragan on 07/05/2019.
//  Copyright © 2019 Watch My Progress. All rights reserved.
//

import Foundation
import WatchKit

class RowController : NSObject {
    
    public static let type : String = "Row"
    
    @IBOutlet weak var titleLabel: WKInterfaceLabel!
}
