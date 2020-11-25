//
//  CustomError.swift
//  TinderSwipeCardsTests
//
//  Created by Huy Quang Nguyen on 11/25/20.
//

import Foundation

enum MockError: Error {
    case first(message: String)
    case second(message: String)

    var localizedDescription: String { return "Some description here!" }
}
