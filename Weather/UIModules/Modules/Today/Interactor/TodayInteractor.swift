//
//  TodayTodayInteractor.swift
//  Weather
//
//  Created by KONSTANTIN KUSAINOV on 21/03/2018.
//  Copyright © 2018 Konstantin. All rights reserved.
//

import Foundation

protocol TodayViewModelRelatableProtocol {
}

extension String: TodayViewModelRelatableProtocol {
}

extension Double: TodayViewModelRelatableProtocol {
}

struct TodayViewModel {
    enum CellWeatherType: String {
        case Name = "City", Temp = "Temperature", MinTemp = "Min Temp", MaxTemp = "Max Temp", Wind = "Wind speed", WindDirection = "Wind direction"
    }

    private let TempKindValue = "Kelvin"
    private let WindSpeedKindValue = "meter/sec"
    let type: CellWeatherType
    let day: WeatherDay
    
    var value: TodayViewModelRelatableProtocol {
        switch self.type {
        case .Name:
            return self.day.name ?? "Unknown city"
        case .WindDirection:
            return self.day.wind.deg
        case .Temp:
            return self.formateValue(value: String(self.day.main.temp), kind: TempKindValue)
        case .MaxTemp:
            return self.formateValue(value: String(self.day.main.temp_max), kind: TempKindValue)
        case .MinTemp:
            return self.formateValue(value: String(self.day.main.temp_min), kind: TempKindValue)
        case .Wind:
            return self.formateValue(value: String(self.day.wind.speed), kind: WindSpeedKindValue)
        }
    }
    
    private func formateValue(value: String, kind: String) -> String {
        return value + " " + kind
    }
}

class TodayInteractor: BaseInteractor, TodayInteractorInput {

    var items: [TodayViewModel] = []
    
	private weak var todayOutput: TodayInteractorOutput!
	override weak var output: BaseInteractorOutput! {
		get {
			return todayOutput
		}
		set {
			guard let o = newValue as? TodayInteractorOutput else {
				fatalError()
			}
			todayOutput = o
        }
    }
    
    // MARK: BaseInteractorProtocol
    
    override func makeRequest(position: Position) {
        self.networkService.fetchTodayWeather(position: position, completion: { [unowned self] (day) in
            let items = [
                TodayViewModel(type: .Name, day: day),
                TodayViewModel(type: .Temp, day: day),
                TodayViewModel(type: .MinTemp, day: day),
                TodayViewModel(type: .MaxTemp, day: day),
                TodayViewModel(type: .Wind, day: day),
                TodayViewModel(type: .WindDirection, day: day),
            ];
            DispatchQueue.main.async {
                self.items = items
                self.todayOutput.assignFetchData()
            }
        }) { [unowned self] (status) in
            DispatchQueue.main.async {
                self.handleParserErrorMainThread(status: status)
            }
        }
    }
}
