//
//  BaseBaseViewInput.swift
//  Weather
//
//  Created by KONSTANTIN KUSAINOV on 30/03/2018.
//  Copyright © 2018 Konstantin. All rights reserved.
//

protocol BaseViewInput: class {

    /**
        @author KONSTANTIN KUSAINOV
        Setup initial state of the view
    */

    func setupInitialState()
    func hiddenReloadUI(hide: Bool)
    func setMessageTitle(message: String)
    func visibleActivitySpinner(visible: Bool)
    func reloadData()
}
