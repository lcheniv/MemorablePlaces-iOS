//
//  TableViewController.swift
//  Memorable Places
//
//  Created by Lawrence Chen on 2/10/16.
//  Copyright © 2016 Lawrence Chen. All rights reserved.
//

import UIKit

// global variable
// Places is an array is a set of dictionaries and takes in two strings - 1 for name 1 for value
var places = [Dictionary <String, String>()]

class TableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Example place in the table so it's not empty
        if(places.count == 1){
            
            places.removeAtIndex(0)
            
            places.append(["name":"Taj Mahal", "lat": "27.175277", "lon":"78.042128"])
            
        }
        
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    // This is the number of rows that are created - number of rows is based on # of places in places array
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places.count
    }

    // Updates the table view
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        
        cell.textLabel?.text = places[indexPath.row]["name"]
        
        return cell
        
    }
    
}
