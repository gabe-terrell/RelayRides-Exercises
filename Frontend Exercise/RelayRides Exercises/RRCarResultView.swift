//
//  RRCarResultView.swift
//  RelayRides Exercises
//
//  Created by Gabe Terrell on 10/31/15.
//  Copyright © 2015 Gabe Terrell. All rights reserved.
//

import UIKit

class RRCarResultView: UIView {

    // MARK: Class Variables
    
    var typicalSeatingLabel = UILabel()
    var possibleFeaturesLabel = UILabel()
    var possibleModelsLabel = UILabel()
    var dailyRateLabel = UILabel()
    var totalPriceLabel = UILabel()
    var locationDescriptionLabel = UILabel()
    
    
    // MARK: Initialization
    
    convenience init() {
        self.init(frame: CGRectZero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.whiteColor()
        
        let viewsDictionary = ["TSL" : typicalSeatingLabel , "PFL" : possibleFeaturesLabel , "PML" : possibleModelsLabel , "DRL" : dailyRateLabel ,
            "TPL" : totalPriceLabel, "LDL" : locationDescriptionLabel]
        
        for view in viewsDictionary.values {
            view.translatesAutoresizingMaskIntoConstraints = false
            view.numberOfLines = 0
            view.lineBreakMode = NSLineBreakMode.ByWordWrapping
            self.addSubview(view)
        }
        
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-[TSL]-|",
            options: NSLayoutFormatOptions(rawValue: 0),
            metrics: nil, views: viewsDictionary))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-[TSL]-15-[PFL]-15-[PML]-15-[DRL]-15-[TPL]-15-[LDL]",
            options: [.AlignAllLeft, .AlignAllRight],
            metrics: nil, views: viewsDictionary))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


}
