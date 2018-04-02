//
//  AuthAuthConfigurator.swift
//  Weather
//
//  Created by KONSTANTIN KUSAINOV on 01/04/2018.
//  Copyright © 2018 Konstantin. All rights reserved.
//

import UIKit

class AuthModuleConfigurator {

    func configureModuleForViewInput<UIViewController>(viewInput: UIViewController) {

        if let viewController = viewInput as? AuthViewController {
            configure(viewController: viewController)
        }
    }

    private func configure(viewController: AuthViewController) {

        let router = AuthRouter(view: viewController)

        let presenter = AuthPresenter()
        presenter.view = viewController
        presenter.router = router

        let interactor = AuthInteractor()
        interactor.output = presenter

        presenter.interactor = interactor
        viewController.output = presenter
    }
}
