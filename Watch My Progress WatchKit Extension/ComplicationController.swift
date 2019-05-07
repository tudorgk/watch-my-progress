//
//  ComplicationController.swift
//  Watch My Progress WatchKit Extension
//
//  Created by Tudor Dragan on 07/05/2019.
//  Copyright © 2019 Watch My Progress. All rights reserved.
//

import ClockKit


class ComplicationController: NSObject, CLKComplicationDataSource {
    
    
    let HOUR: TimeInterval = 60 * 60
    let MINUTE: TimeInterval = 60
    
    // MARK: - Timeline Configuration
    
    func getSupportedTimeTravelDirections(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTimeTravelDirections) -> Void) {
        handler([.forward, .backward])
    }
    
    func getTimelineStartDate(for complication: CLKComplication, withHandler handler: @escaping (Date?) -> Void) {
        handler(nil)
    }
    
    func getTimelineEndDate(for complication: CLKComplication, withHandler handler: @escaping (Date?) -> Void) {
        handler(nil)
    }
    
    func getPrivacyBehavior(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationPrivacyBehavior) -> Void) {
        handler(.showOnLockScreen)
    }
    
    // MARK: - Timeline Population
    
    func getCurrentTimelineEntry(for complication: CLKComplication, withHandler handler: @escaping ((CLKComplicationTimelineEntry?) -> Void)) {
        // Get the complication data from the extension delegate.
        
        var entry : CLKComplicationTimelineEntry?
        var template : CLKComplicationTemplate?
        let now = NSDate()
        
        // Create the template and timeline entry.
        if complication.family == .modularSmall {
            let firstText = "test"
            let shortText = "2344"
            
            let textTemplate = CLKComplicationTemplateModularSmallStackImage()
            
            textTemplate.line1ImageProvider = CLKImageProvider(onePieceImage: UIImage(named: "happy")!)
            textTemplate.line2TextProvider = CLKSimpleTextProvider(text: firstText,
                                                                   shortText: shortText)
            
           
            template = textTemplate
        }
        else  if complication.family == .modularLarge{
          
            let modularLargeTemplate =
                CLKComplicationTemplateModularLargeStandardBody()
            modularLargeTemplate.headerImageProvider = CLKImageProvider(onePieceImage: UIImage(named: "happy")!)
            modularLargeTemplate.headerTextProvider =
                CLKSimpleTextProvider(text: "Watch my progress",
                                    shortText: "Watch my progress")
            modularLargeTemplate.body1TextProvider =
                CLKSimpleTextProvider(text: "Invoice",
                                      shortText: "90 332")
            modularLargeTemplate.body2TextProvider =
                CLKSimpleTextProvider(text: "Stop watch",
                                      shortText: "10 minutes 23 second")
            
           
            template = modularLargeTemplate
        }
        
        // Pass the timeline entry back to ClockKit.
        handler(CLKComplicationTimelineEntry(date: now as Date, complicationTemplate: template!))

    }
    
    func getTimelineEntries(for complication: CLKComplication, before date: Date, limit: Int, withHandler handler: @escaping ([CLKComplicationTimelineEntry]?) -> Void) {
        // Call the handler with the timeline entries prior to the given date
        handler(nil)
    }
    
    func getTimelineEntries(for complication: CLKComplication, after date: Date, limit: Int, withHandler handler: @escaping ([CLKComplicationTimelineEntry]?) -> Void) {
        // Call the handler with the timeline entries after to the given date
        handler(nil)
    }
    
    // MARK: - Placeholder Templates
    
    func getLocalizableSampleTemplate(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTemplate?) -> Void) {
        // This method will be called once per supported complication, and the results will be cached


        
        handler(nil)
    }
    
}
