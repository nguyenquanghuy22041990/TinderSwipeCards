//
//  Dob.swift
//  TinderSwipeCards
//
//  Created by Huy Quang Nguyen on 11/21/20.
//

import Foundation
import Mapper

struct Dob: Mappable {
    let date: String?
    let age: Int?
    
    init(map: Mapper) throws {
        date = map.optionalFrom("date")
        age = map.optionalFrom("age")
    }
}
