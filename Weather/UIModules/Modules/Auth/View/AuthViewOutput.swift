//
//  AuthAuthViewOutput.swift
//  Weather
//
//  Created by KONSTANTIN KUSAINOV on 01/04/2018.
//  Copyright © 2018 Konstantin. All rights reserved.
//

protocol AuthViewOutput {

    /**
        @author KONSTANTIN KUSAINOV
        Notify presenter that view is ready
    */

    func viewIsReady()
    func didSignOutAction()
}
