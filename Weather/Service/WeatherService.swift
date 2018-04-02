//
//  WeatherService.swift
//  Weather
//
//  Created by KONSTANTIN KUSAINOV on 21/03/2018.
//  Copyright © 2018 KONSTANTIN KUSAINOV. All rights reserved.
//

import Foundation
import Alamofire

fileprivate enum Forecast: String {
    case Today = "weather", Week = "forecast"
}

class WeatherService {
	private let apiKey = "ca4acc449267ae1c22acc16e65acac0a"
    private let server = "http://api.openweathermap.org/data/2.5/"
    private let parser = Parser()

    private func request(position: Position, type: Forecast) -> String {
        return server + "\(type.rawValue)?APPID=\(apiKey)&lat=\(position.lat)&lon=\(position.lon)"
    }
    
    private func fetch(request: String, completion: @escaping (Data) -> (), failure: @escaping (ParserStatus) -> ()) {
        Alamofire.request(request).responseJSON { response in
            Logger.networkLog(request: request, response: response.response, data: response.data, error: response.result.error)
            
            if let data = response.data, response.result.isSuccess {
                completion(data)
            } else {
                failure(self.parser.parseError(response: response.response, error: response.error))
			}
        }
    }
	
	func fetchTodayWeather(position: Position, completion: @escaping (WeatherDay) -> (), failure: @escaping (ParserStatus) -> ()) {
        let request = self.request(position: position, type: .Today)
        self.fetch(request: request, completion: completion, failure: failure)
    }
    
    func fetchWeekWeather(position: Position, completion: @escaping (WeatherWeek) -> (), failure: @escaping (ParserStatus) -> ()) {
        let request = self.request(position: position, type: .Week)
		self.fetch(request: request, completion: completion, failure: failure)
    }
	
	internal func fetch<T>(request: String, completion: @escaping (T) -> (), failure: @escaping (ParserStatus) -> ()) where T: Decodable {
		self.fetch(request: request, completion: { (data) in
			self.parser.parseData(data: data, completion: { (week: T?, error) in
				if let w = week {
					completion(w)
				} else {
					failure(error)
				}
			})
		}, failure: { (error) in
			failure(error)
		})
	}
}
