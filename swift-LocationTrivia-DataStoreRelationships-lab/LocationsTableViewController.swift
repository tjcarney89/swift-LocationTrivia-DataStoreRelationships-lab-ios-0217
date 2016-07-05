//
//  LocationsTableViewController.swift
//  swift-LocationTrivia-DataStoreRelationships-lab
//
//  Created by Flatiron School on 7/1/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class LocationsTableViewController: UITableViewController {
    
    let store = LocationsDataStore.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.accessibilityLabel = "Locations Table"
        tableView.accessibilityIdentifier = "Locations Table"
        if let rightBarButtonItem = navigationItem.rightBarButtonItem {
                    rightBarButtonItem.accessibilityLabel = "addButton"
                    rightBarButtonItem.accessibilityIdentifier = "addButton"
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        tableView.reloadData()
    }
    
    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return store.locations.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("RightDetail", forIndexPath: indexPath)
        
        let currentLocation = self.store.locations[indexPath.row];
        
        if let textLabel = cell.textLabel {
            textLabel.text = currentLocation.name
        }
        if let detailTextLabel = cell.detailTextLabel {
            detailTextLabel.text = String.localizedStringWithFormat("%lu", currentLocation.trivia.count)
        }
        
        return cell
    }

    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier != "addLocation" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let location = store.locations[indexPath.row]
                if let triviaTVC: TriviaTableViewController = segue.destinationViewController as? TriviaTableViewController {
                    triviaTVC.location = location
                }
            }
        }
    }
}