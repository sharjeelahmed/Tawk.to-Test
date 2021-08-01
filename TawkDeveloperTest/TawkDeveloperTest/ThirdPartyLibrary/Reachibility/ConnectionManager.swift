//
//  ConnectionManager.swift
//  TawkDeveloperTest
//
//  Created by Shairjeel Ahmed on 01/08/2021.
//

import Foundation

class ConnectionManager {
	
	static let sharedInstance = ConnectionManager()
	private var reachability : Reachability!
	
	func observeReachability(){
		self.reachability = try? Reachability()
		NotificationCenter.default.addObserver(self, selector:#selector(self.reachabilityChanged), name: NSNotification.Name.reachabilityChanged, object: nil)
		do {
			try self.reachability.startNotifier()
		}
		catch(let error) {
			print("Error occured while starting reachability notifications : \(error.localizedDescription)")
		}
	}
	
	
	
	@objc func reachabilityChanged(note: Notification) {
		let reachability = note.object as! Reachability
		NotificationCenter.default.post(name: .reachibilityChanges, object: nil, userInfo: ["key": "Value"])

		switch reachability.connection {
		case .cellular:
			print("Network available via Cellular Data.")
			break
		case .wifi:
			print("Network available via WiFi.")
			break
		case .none:
			print("Network is not available.")
			break
		case .unavailable:
			print("Network is  unavailable.")
			break
		}
	}
	
	func hasConnectivity() -> Bool {
		do {
			let reachability: Reachability = try Reachability()
			let networkStatus = reachability.connection
			
			switch networkStatus {
			case .unavailable:
				return false
			case .wifi, .cellular:
				return true
			}
		}
		catch {
			return false
		}
	}
	
}

extension Notification.Name {
	static let reachibilityChanges = Notification.Name("reachibilityChanges")
}



