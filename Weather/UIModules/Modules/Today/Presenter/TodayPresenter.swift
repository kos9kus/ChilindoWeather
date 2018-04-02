//
//  TodayTodayPresenter.swift
//  Weather
//
//  Created by KONSTANTIN KUSAINOV on 21/03/2018.
//  Copyright © 2018 Konstantin. All rights reserved.
//

import UIKit

class TodayPresenter: BasePresenter, TodayModuleInput, TodayViewOutput, TodayInteractorOutput {

	private weak var todayView: TodayViewInput!
	override weak var view: BaseViewInput! {
		get {
			return todayView
		}
		set {
			guard let v = newValue as? TodayViewInput else {
				fatalError()
			}
			todayView = v
		}
	}
	
	private var todayInteractor: TodayInteractorInput!
	override var interactor: BaseInteractorInput! {
		get {
			return todayInteractor
		}
		set {
			guard let i = newValue as? TodayInteractorInput else {
				fatalError()
			}
			todayInteractor = i
		}
	}
	
    private var day: WeatherDay?

    // MARK: TableViewDataSource

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.todayInteractor.items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WeatherDayTableViewCell.cellReuseIdentifier) as? WeatherDayTableViewCell  else {
            fatalError("Unexpected type")
        }
        
        cell.configureForCell(model: self.todayInteractor.items[indexPath.row])
        
        return cell
    }
}
