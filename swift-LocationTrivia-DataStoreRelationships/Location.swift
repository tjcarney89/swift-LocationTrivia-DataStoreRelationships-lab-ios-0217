//
//  Location.swift
//  swift-LocationTrivia-DataStoreRelationships
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
    
    func stringByTruncatingNameToLength(length: Int) -> String {
        if length > self.name.characters.count {return self.name}
        return String(self.name.characters.dropLast(self.name.characters.count - length))
        
        /* solution with substring
         
         return self.name.substring(to: self.name.index(self.name.startIndex, offsetBy: length))
         
         */
    }
    
    func hasValidData() -> Bool {
        if self.name.characters.count == 0 {return false}
        if self.latitude < -90.0 || self.latitude > 90.0 {return false}
        if self.longitude <= -180.0 || self.longitude > 180.0 {return false}
        return true
    }
    
    func triviumWithMostLikes() -> Trivium? {
        if self.trivia.count == 0 {return nil}
        var triviumWithMostLikes = self.trivia[0]
        for currentTrivium in self.trivia {
            if triviumWithMostLikes.likes < currentTrivium.likes {triviumWithMostLikes = currentTrivium}
        }
        return triviumWithMostLikes
        
        /** solution with NSSortDescriptor
         
         NSSortDescriptor *sortByLikesDesc = [NSSortDescriptor sortDescriptorWithKey:@"likes"
         ascending:NO];
         NSArray *triviumByLikes = [self.trivia sortedArrayUsingDescriptors:@[sortByLikesDesc]];
         
         return triviumByLikes[0];
         */
    }
    
}
