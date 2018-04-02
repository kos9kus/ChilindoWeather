//
//  WeeklyWeeklyConfigurator.swift
//  Weather
//
//  Created by KONSTANTIN KUSAINOV on 21/03/2018.
//  Copyright © 2018 Konstantin. All rights reserved.
//

import UIKit

class WeeklyModuleConfigurator {

    func configureModuleForViewInput<UIViewController>(viewInput: UIViewController) {

        if let viewController = viewInput as? WeeklyViewController {
            configure(viewController: viewController)
        }
    }

    private func configure(viewController: WeeklyViewController) {

        let router = WeeklyRouter(view: viewController)

        let presenter = WeeklyPresenter()
        presenter.view = viewController
        presenter.router = router

        let interactor = WeeklyInteractor()
        interactor.output = presenter

        presenter.interactor = interactor
        viewController.output = presenter
    }

}
