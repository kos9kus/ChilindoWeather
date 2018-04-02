//
//  WeatherServiceTests.swift
//  WeatherTests
//
//  Created by KONSTANTIN KUSAINOV on 21/03/2018.
//  Copyright © 2018 KONSTANTIN KUSAINOV. All rights reserved.
//

import XCTest
import SwiftDate
@testable import Weather

class WeatherServiceTests: XCTestCase {
    
    let service = WeatherService()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testFetchWeekWeather() {
        let exp = expectation(description: "testFetchWeekWeather")
		service.fetchWeekWeather(position: Position(lon: 139.01, lat: 35.02), completion: { (week) in
            print(week)
            let todayDays = week.list.filter({ (day) -> Bool in
                let dayDate = Date(timeIntervalSince1970: day.dt)
                return dayDate.isToday && dayDate.isAfternoon
            })
            print(todayDays)
            let tomorrowDays = week.list.filter({ (day) -> Bool in
                let dayDate = Date(timeIntervalSince1970: day.dt)
                let tomorrowDate = Date() + 1.day
        
                return dayDate.isInSameDayOf(date: tomorrowDate) && dayDate.isAfternoon
            })
            print(tomorrowDays)
			exp.fulfill()
		}, failure: { (status) in
			print(status.descriptor)
			XCTAssert(false)
			exp.fulfill()
		})
        
        waitForExpectations(timeout: 3)
    }
	
	func testFetchTodayWeather() {
		let exp = expectation(description: "testFetchTodayWeather")
		service.fetchTodayWeather(position: Position(lon: 139.01, lat: 35.02), completion: { (day) in
			print(day)
			exp.fulfill()
		}, failure: { (status) in
			print(status.descriptor)
			XCTAssert(false)
			exp.fulfill()
		})
		
		waitForExpectations(timeout: 3)
	}
    
}
