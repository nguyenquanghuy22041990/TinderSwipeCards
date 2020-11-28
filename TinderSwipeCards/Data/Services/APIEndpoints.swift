//
//  APIEndpoints.swift
//  TinderSwipeCards
//
//  Created by Huy Quang Nguyen on 11/21/20.
//

import Foundation
import Moya

private extension String {
    var URLEscapedString: String {
        return self.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlHostAllowed)!
    }
}

enum GetPeople {
    case get(String)
}

extension GetPeople: TargetType {
    var baseURL: URL {
        return URL(string: "https://randomuser.me/api/")!
    }
    
    var path: String {
        
        switch self {
        case .get( _):
            return ""
        }
        
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        switch self {
        case .get( _):
            return "".data(using: String.Encoding.utf8)!
        }
    }
    
    var task: Task {
          switch self {
            case .get(let results):
                return .requestParameters(parameters: ["results": results], encoding: URLEncoding.default)
         }
    }
    
    var headers: [String : String]? {
        return nil
    }
}

