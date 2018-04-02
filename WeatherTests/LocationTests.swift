//
//  LocationTests.swift
//  WeatherTests
//
//  Created by k.kusainov on 29/03/2018.
//  Copyright © 2018 KONSTANTIN KUSAINOV. All rights reserved.
//

import XCTest
import SwiftLocation
@testable import Weather

class LocationTests: XCTestCase {
	
	let service = LocationService()
	
	override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    func testRequestAuthorizationGranted() {
		let exp = expectation(description: "testRequestAuthorizationGranted")
		service.requestAuthorizationLocation { (access) in
			XCTAssertFalse(access == LocationService.AccessGranted.Failed)
			if access != LocationService.AccessGranted.Idle {
				exp.fulfill()
			}
		}
		
		waitForExpectations(timeout: 30)
	}
	
	func testRequestPosition() {
		let exp = expectation(description: "testRequestPosition")
		service.requestPosition(successCompletion: { (position) in
			print(position)
			exp.fulfill()
		}) { (error) in
			print(error)
			XCTAssert(false)
			exp.fulfill()
		}
		
		waitForExpectations(timeout: 30)
	}
    
}
