//
//  WeeklyWeeklyViewController.swift
//  Weather
//
//  Created by KONSTANTIN KUSAINOV on 21/03/2018.
//  Copyright © 2018 Konstantin. All rights reserved.
//

import UIKit

class WeeklyViewController: BaseViewController, WeeklyViewInput {

    @IBOutlet var cityNameLabel: UILabel!
    var weeklyOutput: WeeklyViewOutput!
    override var output: BaseViewOutput! {
        get {
            return weeklyOutput
        }
        set {
            guard let o = newValue as? WeeklyViewOutput else {
                fatalError()
            }
            weeklyOutput = o
        }
    }

    // MARK: Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: WeeklyViewInput
    
    func setCityTitleName(title: String) {
        self.cityNameLabel.text = title
    }
    
    // MARK: UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: WeatherTableViewHeaderFooterView.cellReuseIdentifier) as? WeatherTableViewHeaderFooterView else {
            fatalError("Unexpected header type")
        }
        header.configureForCell(model: self.weeklyOutput.titleForHeader(index: section))
        return header
    }
}
