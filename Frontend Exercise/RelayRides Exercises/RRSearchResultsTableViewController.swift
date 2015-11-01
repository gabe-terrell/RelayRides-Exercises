//
//  RRSearchResultsTableViewController.swift
//  RelayRides Exercises
//
//  Created by Terrell, Gabriel C. on 10/30/15.
//  Copyright © 2015 Gabe Terrell. All rights reserved.
//

import UIKit

class RRSearchResultsTableViewController: UITableViewController {
    // MARK: - Class Variables
    
    var results : [RRCarResult]!
    
    private let reuseIdentifier = "UITableViewCell"
    
    // MARK: - Initialization
    
    init(results: [RRCarResult]) {
        self.results = results
        super.init(style: .Plain)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Results"
        
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell : UITableViewCell? = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier)
        if (cell != nil) {
            cell = UITableViewCell(style: .Value1, reuseIdentifier: reuseIdentifier)
        }
        
        cell!.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        
        cell!.textLabel?.text = results[indexPath.row].carType.typeName
        cell!.detailTextLabel?.text = "$" + results[indexPath.row].totalPrice
        
        return cell!
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let carResult = results[indexPath.row]
        self.navigationController?.pushViewController(RRCarResultViewController(carResult: carResult), animated: true)
    }
}
