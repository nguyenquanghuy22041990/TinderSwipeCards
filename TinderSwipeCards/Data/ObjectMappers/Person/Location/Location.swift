//
//  Location.swift
//  TinderSwipeCards
//
//  Created by Huy Quang Nguyen on 11/21/20.
//

import Foundation
import Mapper

struct Location: Mappable {
    let street: Street?
    let city: String?
    let state: String?
    let country: String?
    let postcode: String?
    let coordinates: Coordinates?
    let timezone: Timezone?
    
    init(map: Mapper) throws {
        street = map.optionalFrom("street")
        city = map.optionalFrom("city")
        state = map.optionalFrom("state")
        country = map.optionalFrom("country")
        postcode = map.optionalFrom("postcode")
        coordinates = map.optionalFrom("coordinates")
        timezone = map.optionalFrom("timezone")
    }
}
