//
//  CheckNetworkManager.swift
//  TinderSwipeCards
//
//  Created by Huy Quang Nguyen on 11/26/20.
//

import Foundation
import Reachability

protocol CheckNetworkManager {
    func checkNetworkConnection(onConnected:@escaping () -> Void, onNetworkError:@escaping ()-> Void)
}

class ReachabilityCheckNetworkManager: CheckNetworkManager {
    
    func checkNetworkConnection(onConnected:@escaping() -> Void, onNetworkError:@escaping ()-> Void) {
        //declare this property where it won't go out of scope relative to your listener
        let reachability = try! Reachability()

        reachability.whenReachable = { reachability in
            reachability.stopNotifier()
            onConnected()
        }
        reachability.whenUnreachable = { _ in
            reachability.stopNotifier()
            onNetworkError()
        }

        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }
    
    
}
