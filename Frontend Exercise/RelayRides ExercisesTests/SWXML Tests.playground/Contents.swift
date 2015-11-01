//: Playground - noun: a place where people can play

import UIKit
import SWXMLHash

class CarType {
    var typicalSeating = ""
    var typeName = ""
    var typeCode = ""
    var possibleFeatures = ""
    var possibleModels = ""
}

let rawURL = "http://api.hotwire.com/v1/search/car?apikey=5zga3m9f4fghbtb9y3effm3x&dest=LAX&startdate=11/10/2015&enddate=11/11/2015&pickuptime=10:00&dropofftime=13:30"

let url = NSURL(string: rawURL)
let contents = try String(contentsOfURL: url!, encoding: NSUTF8StringEncoding)
var xml = SWXMLHash.parse(contents)

var carTypes = [String : CarType]()
for carTypeElement in xml["Hotwire"]["MetaData"]["CarMetaData"]["CarTypes"].children {
    var carType = CarType()
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

print(carTypes)

class CarResult {
    var totalPrice = ""
    var carType = CarType()
    var dailyRate = ""
    var locationDescription = ""
}

var carResults = [CarResult]()
for carResultElement in xml["Hotwire"]["Result"].children {
    var carResult = CarResult()
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

print(carResults[0].totalPrice)

let dayFormatter = NSDateFormatter()
dayFormatter.setLocalizedDateFormatFromTemplate("dd/MM/yyyy")
print(dayFormatter.stringFromDate(NSDate()))

//<SubTotal>95.96</SubTotal>
//<TaxesAndFees>37.07</TaxesAndFees>
//<TotalPrice>133.03</TotalPrice>
//<CarTypeCode>MVAR</CarTypeCode>
//<DailyRate>23.99</DailyRate>
//<DropoffDay>10/23/2015</DropoffDay>
//<DropoffTime>13:30</DropoffTime>
//<PickupDay>10/20/2015</PickupDay>
//<PickupTime>10:00</PickupTime>
//<LocationDescription>Counter in airport; Shuttle to car</LocationDescription>
//<MileageDescription>Unlimited</MileageDescription>
//<PickupAirport>LAX</PickupAirport>
//<RentalDays>4</RentalDays>

// [NSString stringWithContentsOfURL:[NSURL URLWithString:@"http://localhost/v/p.xml"] encoding:NSUTF8StringEncoding error:nil];
// MetaData>
//<CarMetaData>
//<CarTypes>
//<CarType>
