//
//  TodayTodayViewController.swift
//  Weather
//
//  Created by KONSTANTIN KUSAINOV on 21/03/2018.
//  Copyright © 2018 Konstantin. All rights reserved.
//

import UIKit

class TodayViewController: BaseViewController, TodayViewInput {

	var todayOutput: TodayViewOutput!
	override var output: BaseViewOutput! {
		get {
			return todayOutput
		}
		set {
			guard let o = newValue as? TodayViewOutput else {
				fatalError()
			}
			todayOutput = o
		}
	}

    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
