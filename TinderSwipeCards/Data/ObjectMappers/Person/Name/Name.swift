//
//  Name.swift
//  TinderSwipeCards
//
//  Created by Huy Quang Nguyen on 11/21/20.
//

import Foundation
import Mapper

struct Name: Mappable {
    let title: String?
    let first: String?
    let last: String?
    
    init(map: Mapper) throws {
        title = map.optionalFrom("title")
        first = map.optionalFrom("first")
        last = map.optionalFrom("last")
    }
}
