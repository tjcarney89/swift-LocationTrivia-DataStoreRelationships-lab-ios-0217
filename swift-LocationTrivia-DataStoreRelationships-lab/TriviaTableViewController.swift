//
//  TriviaTableViewController.swift
//  swift-LocationTrivia-DataStoreRelationships-lab
//
//  Created by Flatiron School on 7/1/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class TriviaTableViewController: UITableViewController {
    
    var location: Location = Location.init()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.accessibilityIdentifier = "Trivia Table"
        tableView.accessibilityLabel = "Trivia Table"
        
        if let rightBarButtonItem = navigationItem.rightBarButtonItem {
            rightBarButtonItem.accessibilityIdentifier = "Add Trivia Button"
            rightBarButtonItem.accessibilityLabel = "Add Trivia Button"
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return location.trivia.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TriviaCell", forIndexPath: indexPath)

        let currentTrivia = location.trivia[indexPath.row]
        
        if let textLabel = cell.textLabel {
            textLabel.text = currentTrivia.content
        }
        if let detailTextLabel = cell.detailTextLabel {
            detailTextLabel.text = String(format: "%lu", currentTrivia.likes)
        }
        
        return cell
    }

    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "addTrivia" {
            if let addTriviaVC: AddTriviaViewController = segue.destinationViewController as? AddTriviaViewController {
                addTriviaVC.location = location
            }
        }
    }
}