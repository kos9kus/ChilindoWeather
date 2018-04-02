//
//  LocationService.swift
//  Weather
//
//  Created by k.kusainov on 29/03/2018.
//  Copyright © 2018 KONSTANTIN KUSAINOV. All rights reserved.
//

import Foundation
import SwiftLocation

extension LocationError: ErrorDescriptorProtocol {
    var descriptor: ErrorDescriptor {
		let title = "Location error"
		var message = ""
		switch self {
		case .denied, .restricted, .notDetermined:
			message = "Access is restricted. Allow location in Settings"
		case .timedout:
			message = "Timeout"
		case .other(let description):
			message = description
		default:
			message = "Internal error"
			break
		}
        return ErrorDescriptor(title: title, message: message)
    }
}

class LocationService {
	enum AccessGranted: ErrorDescriptorProtocol {
		case Idle, Success, Failed
		
		var descriptor: ErrorDescriptor {
			var title = "Location access error"
			var message = ""
			switch self {
			case .Idle:
				message = "Not determined"
			case .Failed:
				message = "Access is restricted"
			case .Success:
				title = "Location Success"
				message = "Access is granted"
			}
			return ErrorDescriptor(title: title, message: message)
		}
	}
    
    
	func requestAuthorizationLocation(accessGranted: @escaping (AccessGranted) -> ()) {
        if Locator.authorizationStatus == .authorizedWhenInUse {
            accessGranted(.Success)
        }
        
		Locator.requestAuthorizationIfNeeded(.whenInUse)
		_ = Locator.events.listen { newStatus in
			print("Authorization status changed to \(newStatus)")
			switch newStatus {
			case .notDetermined:
				accessGranted(.Idle)
			case .authorizedAlways, .authorizedWhenInUse:
				accessGranted(.Success)
				break
			default:
				accessGranted(.Failed)
				break
			}
		}
	}
	
	func requestPosition(successCompletion: @escaping (Position) -> (), failureCompletion: @escaping (ErrorDescriptorProtocol) -> ()) {
		Locator.currentPosition(accuracy: .city, timeout: Timeout.after(60), onSuccess: { (location) in
			let p = Position(lon: Float(location.coordinate.longitude), lat: Float(location.coordinate.latitude))
			successCompletion(p)
		}) { (error, lastLocation) in
			if let l = lastLocation {
				let p = Position(lon: Float(l.coordinate.longitude), lat: Float(l.coordinate.latitude))
				successCompletion(p)
			} else {
				failureCompletion(error)
			}
		}
	}
}
