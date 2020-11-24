//
//  Picture.swift
//  TinderSwipeCards
//
//  Created by Huy Quang Nguyen on 11/21/20.
//

import Foundation
import Mapper

struct Picture: Mappable {
    let large: String?
    let medium: String?
    let thumbnail: String?
    
    init(map: Mapper) throws {
        large = map.optionalFrom("large")
        medium = map.optionalFrom("medium")
        thumbnail = map.optionalFrom("thumbnail")
    }
}

