//
//  Trivium.swift
//  swift-LocationTrivia-DataStoreRelationships-lab
//
//  Created by Flatiron School on 6/27/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import Foundation


class Trivium {

    var likes: Int = 0
    var content: String
    
    convenience init () {
        self.init(content: "", likes: 0)
    }
    
    init(content: String, likes: Int) {
        self.content = content
        self.likes = likes
    }
    
}
