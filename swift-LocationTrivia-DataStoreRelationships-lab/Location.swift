//
//  Location.swift
//  swift-LocationTrivia-DataStoreRelationships-lab
//
//  Created by Flatiron School on 6/27/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import Foundation

class Location {
    
    let name: String
    let latitude: Float
    let longitude: Float
    var trivia: [Trivium]
    
    init (name: String, latitude: Float, longitude: Float, trivia: [Trivium] = []) {
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
        self.trivia = trivia
    }
    
    convenience init() {
        self.init(name: "", latitude: 0.0 , longitude: 0.0)
    }
    
    func stringByTruncatingNameToLength(_ length: Int) -> String {
        if length > self.name.characters.count {return self.name}
        return String(self.name.characters.dropLast(self.name.characters.count - length))
        
        /* solution with substring
         
         return name.substring(to: name.index(name.startIndex, offsetBy: length))
         
         */
    }
    
    func hasValidData() -> Bool {
        if name.characters.count == 0 {return false}
        if latitude < -90.0 || latitude > 90.0 {return false}
        if longitude <= -180.0 || longitude > 180.0 {return false}
        return true
    }
    
    func triviumWithMostLikes() -> Trivium? {
        if trivia.count == 0 {return nil}
        var triviumWithMostLikes = trivia[0]
        for currentTrivium in trivia {
            if triviumWithMostLikes.likes < currentTrivium.likes {triviumWithMostLikes = currentTrivium}
        }
        return triviumWithMostLikes
    }
}

class LocationsDataStore {
    var locations: [Location] = []
    static let sharedInstance = LocationsDataStore()
    private init() {}
    
    
    
    func generateStartingLocationsData() {
        
        let empireState = Location(name: "The Empire State Building", latitude: 40.7484, longitude: -73.9857)
        let trivium1A = Trivium(content: "1,454 Feet Tall", likes: 4)
        let trivium1B = Trivium(content: "Cost $24,718,000 to build", likes: 2)
        empireState.trivia.append(contentsOf:[trivium1A, trivium1B])
        
        let bowlingGreen = Location(name: "Bowling Green", latitude: 41.3739, longitude: -83.6508)
        let trivium2A = Trivium(content: "NYC's oldest park", likes: 8)
        let trivium2B = Trivium(content: "Made a park in 1733", likes: 2)
        let trivium2C = Trivium(content: "Charging Bull was created in 1989", likes: 0)
        bowlingGreen.trivia.append(contentsOf:[trivium2A, trivium2B, trivium2C])
        
        let ladyLiberty = Location(name: "Statue Of Liberty", latitude: 40.6892, longitude: -74.0444)
        let trivium3A = Trivium(content: "Gift from France", likes: 6)
        ladyLiberty.trivia.append(trivium3A)
        
        self.locations.append(contentsOf:[bowlingGreen, empireState, ladyLiberty])
    }
}
