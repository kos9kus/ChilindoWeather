//
//  WeeklyWeeklyViewOutput.swift
//  Weather
//
//  Created by KONSTANTIN KUSAINOV on 21/03/2018.
//  Copyright © 2018 Konstantin. All rights reserved.
//

protocol WeeklyViewOutput: BaseViewOutput {
    func titleForHeader(index: Int) -> String
}
