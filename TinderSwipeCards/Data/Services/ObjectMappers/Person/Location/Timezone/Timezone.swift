//
//  Timezone.swift
//  TinderSwipeCards
//
//  Created by Huy Quang Nguyen on 11/21/20.
//

import Foundation
import Mapper

struct Timezone: Mappable {
    let offset: String?
    let description: String?
    
    init(map: Mapper) throws {
        offset = map.optionalFrom("offset")
        description = map.optionalFrom("description")
    }
}
