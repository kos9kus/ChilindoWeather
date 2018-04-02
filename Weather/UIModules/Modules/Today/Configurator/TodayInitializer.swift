//
//  TodayTodayInitializer.swift
//  Weather
//
//  Created by KONSTANTIN KUSAINOV on 21/03/2018.
//  Copyright © 2018 Konstantin. All rights reserved.
//

import UIKit

class TodayModuleInitializer: NSObject {

    //Connect with object on storyboard
    @IBOutlet weak var todayViewController: TodayViewController!

    override func awakeFromNib() {

        let configurator = TodayModuleConfigurator()
        configurator.configureModuleForViewInput(viewInput: todayViewController)
    }

}
