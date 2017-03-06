//
//  LocationsTableViewController.swift
//  swift-LocationTrivia-DataStoreRelationships-lab
//
//  Created by TJ Carney on 3/6/17.
//  Copyright © 2017 Flatiron School. All rights reserved.
//

import UIKit

class LocationsTableViewController: UITableViewController, AddLocationProtocol {
    
    @IBOutlet var locationTableView: UITableView!
    @IBOutlet weak var addButton: UIBarButtonItem!
    
    var store: LocationsDataStore = LocationsDataStore.sharedInstance

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        locationTableView.delegate = self
        locationTableView.dataSource = self
        store.generateStartingLocationsData()
        locationTableView.accessibilityLabel = "Locations Table"
        locationTableView.accessibilityIdentifier = "Locations Table"
        addButton.accessibilityLabel = "addButton"
        addButton.accessibilityIdentifier = "addButton"
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        locationTableView.reloadData()
    }

    // MARK: - Table view data source

    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.store.locations.count
       
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "locationSegue" {
            if let destVC = segue.destination as? TriviaTableViewController, let indexPath = locationTableView.indexPathForSelectedRow {
                destVC.location = store.locations[indexPath.row]
            } else {
                print("cast not working")
            }
        } else if segue.identifier == "addSegue" {
            if let destVC = segue.destination as? AddLocationViewController {
                destVC.delegate = self
            }
        }  else {
            print("segue not working")
        }

        
    }


    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "locationCell", for: indexPath)
        let currentLocation = store.locations[indexPath.row].name
        let amountOfTrivia = store.locations[indexPath.row].trivia.count 
        cell.textLabel?.text = "\(currentLocation)"
        cell.detailTextLabel?.text = "\(amountOfTrivia)"
        
        

        return cell
    }
    
    func addLocation(_ location: Location) {
        self.store.locations.append(location)
        self.tableView.reloadData()
    }
    
    
     

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
