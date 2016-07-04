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
        self.setupAccessibilityLabels()
        self.setupLocationManager()
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(true)
        self.locationManager.stopUpdatingLocation()
    }
    
    func setupAccessibilityLabels() {
        self.nameField.accessibilityLabel = "nameField"
        self.nameField.accessibilityIdentifier = "nameField"
        
        self.latitudeField.accessibilityLabel = "latitudeField"
        self.latitudeField.accessibilityIdentifier = "latitudeField"
        
        self.longitudeField.accessibilityLabel = "longitudeField"
        self.longitudeField.accessibilityIdentifier = "longitudeField"
        
        self.submitButton.accessibilityLabel = "saveButton"
        self.submitButton.accessibilityIdentifier = "saveButton"
        
        self.cancelButton.accessibilityLabel = "cancelButton"
        self.cancelButton.accessibilityIdentifier = "cancelButton"
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
        self.latitudeField.text = String(format: "%f", self.currentLocation.coordinate.latitude)
        self.longitudeField.text = String(format: "%f", self.currentLocation.coordinate.longitude)
    }
    
    @IBAction func submitButtonTapped(sender: AnyObject) {
        var latitude: Float
        var longitude: Float
        
        if let latitudeText = self.latitudeField.text {
            latitude = Float(latitudeText)!
            if let longitudeText = self.longitudeField.text {
                longitude = Float(longitudeText)!
                if let name = self.nameField.text {
                    let newLocation = Location.init(name: name, latitude: latitude, longitude: longitude)
                    LocationsDataStore.sharedInstance.locations.append(newLocation)
                }
                
                self.dismissViewControllerAnimated(true, completion: nil)
            }
        }
    }
    
    @IBAction func cancelButtonTapped(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}
