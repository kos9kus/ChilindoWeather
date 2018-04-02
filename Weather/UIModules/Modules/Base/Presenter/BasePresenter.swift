//
//  BaseBasePresenter.swift
//  Weather
//
//  Created by KONSTANTIN KUSAINOV on 30/03/2018.
//  Copyright © 2018 Konstantin. All rights reserved.
//

import UIKit

class BasePresenter: TableViewDataSource, BaseModuleInput, BaseViewOutput, BaseInteractorOutput {

    weak var view: BaseViewInput!
    var interactor: BaseInteractorInput!
    var router: BaseRouterInput!

	
	// MARK: BaseViewOutput
	
	func viewIsReady() {
		self.viewActionReloadData()
    }
	
	func viewActionReloadData() {
		self.interactor.fetch()
        self.view.visibleActivitySpinner(visible: true)
	}
    
    // MARK: BaseInteractorOutput
    
    func assignFetchData() {
        self.view.visibleActivitySpinner(visible: false)
        self.view.reloadData()
    }
    
    func handleError(error: ErrorDescriptor) {
        self.view.visibleActivitySpinner(visible: false)
        self.router.presentErrorAlert(error: error)
    }
    
    func showLocationErrorMessage(message: String) {
        self.view.hiddenReloadUI(hide: false)
        self.view.setMessageTitle(message: message)
    }
    
    func hideError() {
        self.view.hiddenReloadUI(hide: true)
    }
}
