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
