//
//  RRSearchTableViewController.swift
//  RelayRides Exercises
//
//  Created by Gabe Terrell on 10/18/15.
//  Copyright © 2015 Gabe Terrell. All rights reserved.
//

import UIKit

class RRSearchTableViewController: UITableViewController {
    
    // MARK: - Class Variables
    
    var searchElements = ["Pickup Date", "Dropoff Date", "Destination"]
    
    var pickupDatePicker  = UIDatePicker()
    var dropoffDatePicker = UIDatePicker()
    
    var destinationTextField = UITextField()
    var searchButton = UIBarButtonItem()
    
    private let reuseIdentifier = "UITableViewCell"
    
    // MARK: - Initialization
    
    convenience init() {
        self.init(style: .Grouped)
        
        pickupDatePicker.date = NSDate()
        pickupDatePicker.minimumDate = NSDate()
        pickupDatePicker.datePickerMode = .DateAndTime
        
        // Make the UIDatePicker smaller than default
        let width : Double = Double(pickupDatePicker.frame.width)
        pickupDatePicker.frame = CGRect(x: 0.0, y: 0.0, width: width, height: 162.0)
        
        dropoffDatePicker.date = NSDate(timeInterval: 3600 * 24, sinceDate: NSDate())
        dropoffDatePicker.minimumDate = NSDate()
        dropoffDatePicker.datePickerMode = .DateAndTime
        dropoffDatePicker.frame = CGRect(x: 0.0, y: 0.0, width: width, height: 162.0)
        
        destinationTextField.placeholder = "Airport Code or City,State"
        
        searchButton = UIBarButtonItem(title: "Search", style: .Plain, target: self, action: "executeSearch")
        searchButton.enabled = false
    }
    
    override init(style: UITableViewStyle) {
        super.init(style: style)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Hotwire Car Search"
        
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        
        // Dismiss the keyboard when tapping outside of textview
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "dismissKeyboard"))

        // Add the search button
        self.navigationItem.rightBarButtonItem = searchButton
    }
    
    // Dismiss the keyboard when tapping outside of textview
    func dismissKeyboard() {
        destinationTextField.resignFirstResponder()
        
        if destinationTextField.text != "" {
            searchButton.enabled = true
        }
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return super.tableView(tableView, heightForRowAtIndexPath: indexPath)
        }
        // Special sizing for the UIDatePicker table cells
        else {
            return indexPath.section < 2 ? 162 : 41
        }
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier, forIndexPath: indexPath)

        if indexPath.row == 0 {
            cell.textLabel?.text = searchElements[indexPath.section]
        }
        else {
            switch indexPath.section {
                case 0:
                    cell.addSubview(pickupDatePicker)
                case 1:
                    cell.addSubview(dropoffDatePicker)
                case 2:
                    destinationTextField.frame = CGRect(x: 15, y: 0, width: cell.contentView.frame.size.width, height: cell.contentView.frame.size.height)
                    cell.contentView.addSubview(destinationTextField)
                default:
                    break
            }
        }

        return cell
    }
    
    // MARK - User interaction
    
    func executeSearch() {
        let results = RRSearchRequest.executeQuery(destinationTextField.text!, startDate: pickupDatePicker.date, endDate: dropoffDatePicker.date)
        self.navigationController?.pushViewController(RRSearchResultsTableViewController(results: results), animated: true)
    }

}
