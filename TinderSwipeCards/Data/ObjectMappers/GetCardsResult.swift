//
//  Result.swift
//  TinderSwipeCards
//
//  Created by Huy Quang Nguyen on 11/21/20.
//

import Foundation
import Mapper

struct GetCardsResult: Mappable {
    
    let people: [Person]
    
    init(map: Mapper) throws {
        people = try map.from("results")
    }
}
