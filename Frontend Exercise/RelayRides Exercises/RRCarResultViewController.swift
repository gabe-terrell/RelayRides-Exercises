//
//  RRCarResultViewController.swift
//  RelayRides Exercises
//
//  Created by Gabe Terrell on 10/31/15.
//  Copyright © 2015 Gabe Terrell. All rights reserved.
//

import UIKit

class RRCarResultViewController: UIViewController {
    
    // MARK: Class Variables
    
    var carResult : RRCarResult!
    
    // MARK: Initialization
    
    init(carResult : RRCarResult) {
        self.carResult = carResult
        
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.translucent = false

        let view = RRCarResultView()
        
        self.title = carResult.carType.typeName
        view.typicalSeatingLabel.text = "Typical Seating - " + carResult.carType.typicalSeating
        view.possibleModelsLabel.text = "Model - " + carResult.carType.possibleModels
        view.possibleFeaturesLabel.text = "Possible Features - " + carResult.carType.possibleFeatures
        view.dailyRateLabel.text = "Daily Rate - $" + carResult.dailyRate
        view.totalPriceLabel.text = "Total Cost - $" + carResult.totalPrice
        view.locationDescriptionLabel.text = "Pickup Location - " + carResult.locationDescription
        
        self.view = view
    }

}
