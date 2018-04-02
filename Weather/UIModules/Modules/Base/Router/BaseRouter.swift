//
//  BaseBaseRouter.swift
//  Weather
//
//  Created by KONSTANTIN KUSAINOV on 30/03/2018.
//  Copyright © 2018 Konstantin. All rights reserved.
//

import UIKit

class BaseRouter: BaseRouterInput {
    unowned let view: UIViewController
	init(view: UIViewController) {
		self.view = view
	}
    
    func presentErrorAlert(error: ErrorDescriptor) {
        let alertVC = UIAlertController(title: error.title, message: error.message, preferredStyle: .alert)
		let actionOk = UIAlertAction(title: "OK", style: .cancel, handler: nil)
		alertVC.addAction(actionOk)
        self.view.present(alertVC, animated: true)
    }
}
