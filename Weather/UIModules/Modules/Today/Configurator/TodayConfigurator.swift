//
//  TodayTodayConfigurator.swift
//  Weather
//
//  Created by KONSTANTIN KUSAINOV on 21/03/2018.
//  Copyright © 2018 Konstantin. All rights reserved.
//

import UIKit

class TodayModuleConfigurator {

    func configureModuleForViewInput<UIViewController>(viewInput: UIViewController) {

        if let viewController = viewInput as? TodayViewController {
            configure(viewController: viewController)
        }
    }

    private func configure(viewController: TodayViewController) {

        let router = TodayRouter(view: viewController)

        let presenter = TodayPresenter()
        presenter.view = viewController
        presenter.router = router

        let interactor = TodayInteractor()
        interactor.output = presenter

        presenter.interactor = interactor
        viewController.output = presenter
    }

}
