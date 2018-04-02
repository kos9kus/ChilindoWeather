//
//  BaseBaseViewOutput.swift
//  Weather
//
//  Created by KONSTANTIN KUSAINOV on 30/03/2018.
//  Copyright © 2018 Konstantin. All rights reserved.
//

protocol BaseViewOutput {

    /**
        @author KONSTANTIN KUSAINOV
        Notify presenter that view is ready
    */

    func viewIsReady()
	func viewActionReloadData()
}
