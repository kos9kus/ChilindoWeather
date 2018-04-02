//
//  WeeklyWeeklyInteractor.swift
//  Weather
//
//  Created by KONSTANTIN KUSAINOV on 21/03/2018.
//  Copyright © 2018 Konstantin. All rights reserved.
//

import SwiftDate

struct WeeklyViewModel {
    struct CellViewModel {
        let dataString: String
        let items: [TodayViewModel]
    }
    let cityName: String
    let items: Array<CellViewModel>
}

class WeeklyInteractor: BaseInteractor, WeeklyInteractorInput {

    private weak var weeklyOutput: WeeklyInteractorOutput!
    override weak var output: BaseInteractorOutput! {
        get {
            return weeklyOutput
        }
        set {
            guard let o = newValue as? WeeklyInteractorOutput else {
                fatalError()
            }
            weeklyOutput = o
        }
    }
    
    private(set) var viewModel: WeeklyViewModel?
    
    override func makeRequest(position: Position) {
        self.networkService.fetchWeekWeather(position: position, completion: {[unowned self] (week) in
            let viewModel = self.createViewModel(week: week)
            DispatchQueue.main.async {
                self.viewModel = viewModel
                self.output.assignFetchData()
            }
        }) { [unowned self] (statueError) in
            DispatchQueue.main.async {
                self.handleParserErrorMainThread(status: statueError)
            }
        }
    }
    
    private func createViewModel(week: WeatherWeek) -> WeeklyViewModel {
        var items: [WeeklyViewModel.CellViewModel] = []
        let todayDays = week.list.filter({ (day) -> Bool in
            let dayDate = Date(timeIntervalSince1970: day.dt)
            return dayDate.isToday
        })
        if let day = todayDays.first {
            items.append(self.createTodayViewModel(day: day, minMaxInclude: true))
        }
        
        for i in 1...4 {
            let nextDay = week.list.filter({ (day) -> Bool in
                let dayDate = Date(timeIntervalSince1970: day.dt)
                let tomorrowDate = Date() + i.day
                return dayDate.isInSameDayOf(date: tomorrowDate) && dayDate.isAfternoon
            })
            if let day = nextDay.first {
                items.append(self.createTodayViewModel(day: day))
            }
        }
        
        return WeeklyViewModel(cityName: week.name, items: items)
    }
    
    private func createTodayViewModel(day: WeatherDay, minMaxInclude: Bool = false) -> WeeklyViewModel.CellViewModel {
        
        var items = [
            TodayViewModel(type: .Temp, day: day),
            TodayViewModel(type: .Wind, day: day),
            TodayViewModel(type: .WindDirection, day: day),
            ];
        if minMaxInclude {
            items.append(TodayViewModel(type: .MinTemp, day: day))
            items.append(TodayViewModel(type: .MaxTemp, day: day))
        }
        let dataString = WeatherDate.formattedDataString(timeInterval: day.dt)
        
        return WeeklyViewModel.CellViewModel(dataString: dataString, items: items)
    }
}
