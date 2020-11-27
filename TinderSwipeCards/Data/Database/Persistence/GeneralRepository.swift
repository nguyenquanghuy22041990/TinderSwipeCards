//
//  PersonRepository.swift
//  TinderSwipeCards
//
//  Created by Huy Quang Nguyen on 11/27/20.
//

import Foundation

class GeneralRepository {
    
    static let sharedInstance:GeneralRepository! = GeneralRepository()
    
    var personRepository = AnyRepository<PersonObject>()
    
    private init() {
        
    }
}
