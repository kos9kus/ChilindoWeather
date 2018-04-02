//
//  WeeklyWeeklyPresenter.swift
//  Weather
//
//  Created by KONSTANTIN KUSAINOV on 21/03/2018.
//  Copyright © 2018 Konstantin. All rights reserved.
//

import UIKit

class WeeklyPresenter: BasePresenter, WeeklyModuleInput, WeeklyViewOutput, WeeklyInteractorOutput {
    
    private weak var weekyView: WeeklyViewInput!
    override weak var view: BaseViewInput! {
        get {
            return weekyView
        }
        set {
            guard let v = newValue as? WeeklyViewInput else {
                fatalError()
            }
            weekyView = v
        }
    }
    
    private var weeklyInteractor: WeeklyInteractorInput!
    override var interactor: BaseInteractorInput! {
        get {
            return weeklyInteractor
        }
        set {
            guard let i = newValue as? WeeklyInteractorInput else {
                fatalError()
            }
            weeklyInteractor = i
        }
    }
    
    // MARK: BaseInteractorOutput
    
    override func assignFetchData() {
        super.assignFetchData()
        self.weekyView.setCityTitleName(title: self.weeklyInteractor.viewModel!.cityName)
    }
    
    // MARK: WeeklyViewOutput
    
    func titleForHeader(index: Int) -> String {
        return self.weeklyInteractor.viewModel!.items[index].dataString
    }
    
    // MARK: TableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let items = self.weeklyInteractor.viewModel?.items else {
            return 0
        }
        
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let items = self.weeklyInteractor.viewModel?.items else {
            return 0
        }
        
        return items[section].items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WeatherDayTableViewCell.cellReuseIdentifier) as? WeatherDayTableViewCell, let models =  self.weeklyInteractor.viewModel?.items[indexPath.section] else {
            fatalError("Unexpected type")
        }
        cell.configureForCell(model: models.items[indexPath.row])
        return cell
    }
}
