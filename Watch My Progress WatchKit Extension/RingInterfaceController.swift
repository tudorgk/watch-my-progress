//
//  RingInterfaceController.swift
//  Watch My Progress WatchKit Extension
//
//  Created by Göran Lilja on 2019-05-07.
//  Copyright © 2019 Watch My Progress. All rights reserved.
//

import Foundation
import WatchKit
import CoreGraphics

class RingInterfaceController: WKInterfaceController {
    @IBOutlet private weak var image: WKInterfaceImage! {
        didSet {
            setupImage()
        }
    }

    var totalSalesInvoices: Int = 47 {
        didSet {
            setupImage()
        }
    }

    var paidSalesInvoices: Int = 32 {
        didSet {
            setupImage()
        }
    }

    var totalPurchaseInvoices: Int = 23 {
        didSet {
            setupImage()
        }
    }

    var paidPurchaseInvoices: Int = 21 {
        didSet {
            setupImage()
        }
    }

    private let screenSize: CGSize = {
        let currentDevice = WKInterfaceDevice.current()
        return currentDevice.screenBounds.size
    } ()

    private func setupImage() {
        UIGraphicsBeginImageContext(screenSize)
        if let context = UIGraphicsGetCurrentContext() {
            let lineWidth: CGFloat = 12
            // Set the circle outerline-width
            context.setLineWidth(lineWidth)
            context.setLineCap(.round)

            // Create Circle
            let center = CGPoint(x: screenSize.width / 2, y: screenSize.height / 2)

            let outerRadius = (screenSize.width - lineWidth) / 2

            // Unpaid
            UIColor.green1.set()
            context.addArc(center: center, radius: outerRadius, startAngle: 0, endAngle: 2 * .pi, clockwise: false)
            context.strokePath()

            // Paid
            let salesInvoiceProgress: CGFloat = CGFloat(paidSalesInvoices) / CGFloat(totalSalesInvoices)
            let saleProgressAngle: CGFloat = 2 * .pi * salesInvoiceProgress - .pi / 2
            UIColor.green2.set()
            context.addArc(center: center, radius: outerRadius, startAngle: .pi * 1.5, endAngle: saleProgressAngle, clockwise: false)
            context.strokePath()

            // Purchase invoice
            let innerRadius = outerRadius - lineWidth * 2

            // Unpaid
            UIColor.red1.set()
            context.addArc(center: center, radius: innerRadius, startAngle: 0, endAngle: 2 * .pi, clockwise: false)
            context.strokePath()

            // Paid
            let purchaseInvoiceProgress: CGFloat = CGFloat(paidPurchaseInvoices) / CGFloat(totalPurchaseInvoices)
            let purchaseProgressAngle: CGFloat = 2 * .pi * purchaseInvoiceProgress - .pi / 2
            UIColor.red2.set()
            context.addArc(center: center, radius: innerRadius, startAngle: .pi * 1.5, endAngle: purchaseProgressAngle, clockwise: false)
            context.strokePath()


            // Convert to UIImage
            let cgimage = context.makeImage()
            let uiimage = UIImage(cgImage: cgimage!)

            // End the graphics context
            UIGraphicsEndImageContext()

            image.setImage(uiimage)
        }
    }
}

extension UIColor {
    static let red1: UIColor = {
        return UIColor(red: 241/255, green: 90/255, blue: 90/255, alpha: 0.3)
    } ()

    static let red2: UIColor = {
        return UIColor(red: 241/255, green: 90/255, blue: 90/255, alpha: 1)
    } ()

    static let green1: UIColor = {
        return UIColor(red: 78/255, green: 186/255, blue: 111/255, alpha: 0.3)
    } ()

    static let green2: UIColor = {
        return UIColor(red: 78/255, green: 186/255, blue: 111/255, alpha: 1)
    } ()

    static let blue1: UIColor = {
        return UIColor(red: 0/255, green: 97/255, blue: 153/255, alpha: 0.3)
    } ()

    static let blue2: UIColor = {
        return UIColor(red: 0/255, green: 97/255, blue: 153/255, alpha: 1)
    } ()

    static let orange1: UIColor = {
        return UIColor(red: 250/255, green: 137/255, blue: 25/255, alpha: 0.3)
    } ()

    static let orange2: UIColor = {
        return UIColor(red: 250/255, green: 137/255, blue: 25/255, alpha: 1)
    } ()
}
