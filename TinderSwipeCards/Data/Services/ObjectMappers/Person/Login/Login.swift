//
//  Password.swift
//  TinderSwipeCards
//
//  Created by Huy Quang Nguyen on 11/21/20.
//

import Foundation
import Mapper

struct Login: Mappable {
    let password: String?
    
    init(map: Mapper) throws {
        password = map.optionalFrom("password")
    }
}
