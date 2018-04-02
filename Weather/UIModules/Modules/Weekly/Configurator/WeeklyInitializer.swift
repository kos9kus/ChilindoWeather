//
//  WeeklyWeeklyInitializer.swift
//  Weather
//
//  Created by KONSTANTIN KUSAINOV on 21/03/2018.
//  Copyright © 2018 Konstantin. All rights reserved.
//

import UIKit

class WeeklyModuleInitializer: NSObject {

    @IBOutlet weak var weeklyViewController: WeeklyViewController!

    override func awakeFromNib() {

        let configurator = WeeklyModuleConfigurator()
        configurator.configureModuleForViewInput(viewInput: weeklyViewController)
    }

}
