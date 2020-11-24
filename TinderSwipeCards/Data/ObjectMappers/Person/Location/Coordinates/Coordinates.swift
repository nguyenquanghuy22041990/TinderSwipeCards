//
//  Coordinates.swift
//  TinderSwipeCards
//
//  Created by Huy Quang Nguyen on 11/21/20.
//

import Foundation
import Mapper

struct Coordinates: Mappable {
    let latitude: String?
    let longitude: String?
    
    init(map: Mapper) throws {
        latitude = map.optionalFrom("latitude")
        longitude = map.optionalFrom("longitude")
    }
}
