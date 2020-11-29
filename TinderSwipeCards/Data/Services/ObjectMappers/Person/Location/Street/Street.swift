//
//  Street.swift
//  TinderSwipeCards
//
//  Created by Huy Quang Nguyen on 11/21/20.
//

import Foundation
import Mapper

struct Street: Mappable {
    let number: Int?
    let name: String?
    
    init(map: Mapper) throws {
        number = map.optionalFrom("number")
        name = map.optionalFrom("name")
    }
}
