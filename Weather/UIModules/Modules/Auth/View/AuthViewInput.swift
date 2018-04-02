//
//  AuthAuthViewInput.swift
//  Weather
//
//  Created by KONSTANTIN KUSAINOV on 01/04/2018.
//  Copyright © 2018 Konstantin. All rights reserved.
//

protocol AuthViewInput: class {

    /**
        @author KONSTANTIN KUSAINOV
        Setup initial state of the view
    */

    func setupInitialState()
    func setUpGuestUser(isGuest: Bool)
    func setupUserName(username: String)
    func setupEmail(email: String)
}
