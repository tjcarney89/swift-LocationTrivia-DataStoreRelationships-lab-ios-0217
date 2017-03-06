//
//  AddLocationViewController.swift
//  swift-LocationTrivia-DataStoreRelationships-lab
//
//  Created by TJ Carney on 3/6/17.
//  Copyright © 2017 Flatiron School. All rights reserved.
//

import UIKit


protocol AddLocationProtocol: class {
    func addLocation(_ location: Location)
}

class AddLocationViewController: UIViewController {
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var latitudeField: UITextField!
    @IBOutlet weak var longitudeField: UITextField!

    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    
    
    weak var delegate: AddLocationProtocol?
    
    var store: LocationsDataStore = LocationsDataStore.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameField.accessibilityLabel = "nameField"
        nameField.accessibilityIdentifier = "nameField"
        
        latitudeField.accessibilityLabel = "latitudeField"
        latitudeField.accessibilityIdentifier = "latitudeField"
        
        longitudeField.accessibilityLabel = "longitudeField"
        longitudeField.accessibilityIdentifier = "longitudeField"
        
        cancelButton.accessibilityLabel = "cancelButton"
        cancelButton.accessibilityIdentifier = "cancelButton"
        
        saveButton.accessibilityLabel = "saveButton"
        saveButton.accessibilityIdentifier = "saveButton"
        
    }
    
    func dismissView() {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func cancelButtonTapped(_ sender: Any) {
        dismissView()
    }
 
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        var name: String = ""
        var latitude = CGFloat()
        var longitude = CGFloat()
        
        if let nameInput = nameField.text {
            name = nameInput
        }
        if let latitudeInput = latitudeField.text {
            if let latitudeNum = Double(latitudeInput) {
                 latitude = CGFloat(latitudeNum)
            }
        }
        if let longitudeInput = longitudeField.text {
            if let longitudeNum = Double(longitudeInput) {
                 longitude = CGFloat(longitudeNum)
            }
        }

        let newLocation = Location(name: name, latitude: Float(latitude), longitude: Float(longitude))
        if let receiver = delegate {
            receiver.addLocation(newLocation)
            dismissView()
        }
//        store.locations.append(newLocation)
        
        

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
