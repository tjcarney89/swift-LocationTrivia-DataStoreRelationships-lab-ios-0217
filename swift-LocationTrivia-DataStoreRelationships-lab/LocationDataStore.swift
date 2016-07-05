//
//  LocationDataStore.swift
//  swift-LocationTrivia-DataStoreRelationships-lab
//
//  Created by Flatiron School on 6/30/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import Foundation

final class LocationsDataStore {
    
    static let sharedInstance = LocationsDataStore()
    private init() {
        generateStartingLocationsData()
    }
    
    var locations: [Location] = []
    
    func generateStartingLocationsData() {
        
        let empireState = Location.init(name: "The Empire State Building", latitude: 40.7484, longitude: -73.9857)
        let trivium1A = Trivium.init(content: "1,454 Feet Tall", likes: 4)
        let trivium1B = Trivium.init(content: "Cost $24,718,000 to build", likes: 2)
        empireState.trivia.appendContentsOf([trivium1A, trivium1B])
        
        let bowlingGreen = Location.init(name: "Bowling Green", latitude: 41.3739, longitude: -83.6508)
        let trivium2A = Trivium.init(content: "NYC's oldest park", likes: 8)
        let trivium2B = Trivium.init(content: "Made a park in 1733", likes: 2)
        let trivium2C = Trivium.init(content: "Charging Bull was created in 1989", likes: 0)
        bowlingGreen.trivia.appendContentsOf([trivium2A, trivium2B, trivium2C])
        
        let ladyLiberty = Location.init(name: "Statue Of Liberty", latitude: 40.6892, longitude: -74.0444)
        let trivium3A = Trivium.init(content: "Gift from France", likes: 6)
        ladyLiberty.trivia.append(trivium3A)
        
        locations.appendContentsOf([bowlingGreen, empireState, ladyLiberty])
    }
}
