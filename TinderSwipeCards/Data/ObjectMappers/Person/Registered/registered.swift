//
//  registered.swift
//  TinderSwipeCards
//
//  Created by Huy Quang Nguyen on 11/21/20.
//

import Foundation
import Mapper

struct Registered: Mappable {
    let phone: String?
    let cell: String?
    
    init(map: Mapper) throws {
        phone = map.optionalFrom("phone")
        cell = map.optionalFrom("cell")
    }
}
