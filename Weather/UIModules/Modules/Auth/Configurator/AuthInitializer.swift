//
//  AuthAuthInitializer.swift
//  Weather
//
//  Created by KONSTANTIN KUSAINOV on 01/04/2018.
//  Copyright © 2018 Konstantin. All rights reserved.
//

import UIKit

class AuthModuleInitializer: NSObject {

    //Connect with object on storyboard
    @IBOutlet weak var authViewController: AuthViewController!

    override func awakeFromNib() {

        let configurator = AuthModuleConfigurator()
        configurator.configureModuleForViewInput(viewInput: authViewController)
    }

}
