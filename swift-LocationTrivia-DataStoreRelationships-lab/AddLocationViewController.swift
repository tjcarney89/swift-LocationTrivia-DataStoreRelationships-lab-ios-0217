//
//  AddLocationViewController.swift
//  swift-LocationTrivia-DataStoreRelationships-lab
//
//  Created by Flatiron School on 7/1/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit
import CoreLocation

class AddLocationViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var latitudeField: UITextField!
    @IBOutlet weak var longitudeField: UITextField!
    
    @IBOutlet weak var useCurrentLocationButton: UIButton!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    var locationManager = CLLocationManager()
    var currentLocation = CLLocation()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAccessibilityLabels()
        setupLocationManager()
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(true)
        locationManager.stopUpdatingLocation()
    }
    
    func setupAccessibilityLabels() {
        nameField.accessibilityLabel = "nameField"
        nameField.accessibilityIdentifier = "nameField"
        
        latitudeField.accessibilityLabel = "latitudeField"
        latitudeField.accessibilityIdentifier = "latitudeField"
        
        longitudeField.accessibilityLabel = "longitudeField"
        longitudeField.accessibilityIdentifier = "longitudeField"
        
        submitButton.accessibilityLabel = "saveButton"
        submitButton.accessibilityIdentifier = "saveButton"
        
        cancelButton.accessibilityLabel = "cancelButton"
        cancelButton.accessibilityIdentifier = "cancelButton"
    }
    
    
    // MARK: Location
    
    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = 50
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
    }

    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let lastLocation = locations.last {
            currentLocation = lastLocation
        }
    }
    
    
    // MARK: IBActions
    
    @IBAction func useCurrentLocation(sender: AnyObject) {
        latitudeField.text = String(format: "%f", currentLocation.coordinate.latitude)
        longitudeField.text = String(format: "%f", currentLocation.coordinate.longitude)
    }
    
    @IBAction func submitButtonTapped(sender: AnyObject) {
        var latitude: Float
        var longitude: Float
        
        if let latitudeText = latitudeField.text {
            latitude = Float(latitudeText)!
            if let longitudeText = longitudeField.text {
                longitude = Float(longitudeText)!
                if let name = nameField.text {
                    let newLocation = Location.init(name: name, latitude: latitude, longitude: longitude)
                    LocationsDataStore.sharedInstance.locations.append(newLocation)
                }
                
                dismissViewControllerAnimated(true, completion: nil)
            }
        }
    }
    
    @IBAction func cancelButtonTapped(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}