//
//  RRSearchRequest.swift
//  RelayRides Exercises
//
//  Created by Terrell, Gabriel C. on 10/30/15.
//  Copyright © 2015 Gabe Terrell. All rights reserved.
//

import UIKit
import SWXMLHash

class RRCarType {
    var typicalSeating = ""
    var typeName = ""
    var typeCode = ""
    var possibleFeatures = ""
    var possibleModels = ""
}

class RRCarResult {
    var totalPrice = ""
    var carType = RRCarType()
    var dailyRate = ""
    var locationDescription = ""
}

class RRSearchRequest: NSObject {
    private class func buildRequestURL (dest: String, start: NSDate, end: NSDate) -> NSURL {
        let dayFormatter = NSDateFormatter()
        dayFormatter.setLocalizedDateFormatFromTemplate("dd/MM/yyyy")
        
        let timeFormatter = NSDateFormatter()
        timeFormatter.setLocalizedDateFormatFromTemplate("HH")
        
        var rawURL = "https://api.hotwire.com/v1/search/car?apikey=5zga3m9f4fghbtb9y3effm3x"
        rawURL += "&dest=" + dest
        rawURL += "&startdate=" + dayFormatter.stringFromDate(start)
        rawURL += "&enddate=" + dayFormatter.stringFromDate(end)
        rawURL += "&pickuptime=" + timeFormatter.stringFromDate(start) + ":30"
        rawURL += "&dropofftime=" + timeFormatter.stringFromDate(end) + ":30"
            
        return NSURL(string: rawURL)!
    }
    
    private class func extractCarTypesFromXML(xml: XMLIndexer) -> [String : RRCarType] {
        var carTypes = [String : RRCarType]()
        for carTypeElement in xml["Hotwire"]["MetaData"]["CarMetaData"]["CarTypes"].children {
            let carType = RRCarType()
            for feature in carTypeElement.children {
                let text = feature.element!.text!
                switch feature.element!.name {
                    case "TypicalSeating":
                        carType.typicalSeating = text
                    case "CarTypeName":
                        carType.typeName = text
                    case "CarTypeCode":
                        carType.typeCode = text
                    case "PossibleFeatures":
                        carType.possibleFeatures = text
                    case "PossibleModels":
                        carType.possibleModels = text
                    default: break
                }
            }
            carTypes[carType.typeCode] = carType
        }
        return carTypes
    }
    
    class func executeQuery(destination: String, startDate: NSDate, endDate: NSDate) -> [RRCarResult] {
        let url = RRSearchRequest.buildRequestURL(destination, start: startDate, end: endDate)
        let contents = try? String(contentsOfURL: url, encoding: NSUTF8StringEncoding)
        let xml = SWXMLHash.parse(contents!)
        
        let carTypes = RRSearchRequest.extractCarTypesFromXML(xml)
        
        var carResults = [RRCarResult]()
        for carResultElement in xml["Hotwire"]["Result"].children {
            let carResult = RRCarResult()
            for detail in carResultElement.children {
                let text = detail.element!.text!
                switch detail.element!.name {
                    case "TotalPrice":
                        carResult.totalPrice = text
                    case "CarTypeCode":
                        carResult.carType = carTypes[text]!
                    case "DailyRate":
                        carResult.dailyRate = text
                    case "LocationDescription":
                        carResult.locationDescription = text
                    default: break
                }
            }
            carResults.append(carResult)
        }
        return carResults
    }
}
