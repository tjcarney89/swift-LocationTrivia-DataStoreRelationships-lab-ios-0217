//
//  TriviaTableViewController.swift
//  swift-LocationTrivia-DataStoreRelationships-lab
//
//  Created by TJ Carney on 3/6/17.
//  Copyright © 2017 Flatiron School. All rights reserved.
//

import UIKit

class TriviaTableViewController: UITableViewController, AddTriviaDelegate {

    @IBOutlet var triviaTableView: UITableView!
    
    
    var location: Location = Location()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dump(location)
        print("i am running")
        
        
        triviaTableView.accessibilityLabel = "Trivia Table"
        triviaTableView.accessibilityIdentifier = "Trivia Table"
    }

    

    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return location.trivia.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "triviaCell", for: indexPath)
        let currentFact = location.trivia[indexPath.row].content
        let numberOfLikes = location.trivia[indexPath.row].likes
        cell.textLabel?.text = "\(currentFact)"
        cell.detailTextLabel?.text = "Likes: \(numberOfLikes)"
        print("GOT CALLED")

        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addTriviaSegue" {
            if let destVC = segue.destination as? AddTriviaViewController {
                destVC.delegate = self
            }
        }
    }

    func addTrivia(_ trivia: Trivium) {
        self.location.trivia.append(trivia)
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
