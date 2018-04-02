//
//  Types.swift
//  Weather
//
//  Created by KONSTANTIN KUSAINOV on 28/03/2018.
//  Copyright © 2018 KONSTANTIN KUSAINOV. All rights reserved.
//

import Foundation

struct Weather: Decodable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct Main: Decodable {
    let temp: Float
    let pressure: Float
    let humidity: Int
    let temp_min: Float
    let temp_max: Float
}

struct Wind: Decodable {
    let speed: Float
    let deg: Double
}

struct WeatherDay: Decodable {
    let weather: [Weather]
    let main: Main
    let wind: Wind
    let name: String?
    let dt: Double
}

struct WeatherWeek: Decodable {
    let name: String
    let list: [WeatherDay]
    
    enum WeatherWeekKeys: String, CodingKey {
        case city
        case list
    }
    enum CityKeys: String, CodingKey {
        case name
    }
    
    init(from decoder: Decoder) throws {
        let allValues = try decoder.container(keyedBy: WeatherWeekKeys.self)
        let city = try allValues.nestedContainer(keyedBy: CityKeys.self, forKey: .city)
        list = try allValues.decode([WeatherDay].self, forKey: .list)
        name = try city.decode(String.self, forKey: .name)
    }
}

struct Position {
    let lon: Float
    let lat: Float
}

protocol ErrorDescriptorProtocol {
	var descriptor: ErrorDescriptor {get}
}

struct ErrorDescriptor {
    let title: String
    let message: String
}

struct User {
    let name: String
    let email: String
}

