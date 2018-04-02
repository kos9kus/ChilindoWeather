//
//  AuthAuthPresenter.swift
//  Weather
//
//  Created by KONSTANTIN KUSAINOV on 01/04/2018.
//  Copyright © 2018 Konstantin. All rights reserved.
//


class AuthPresenter: AuthModuleInput, AuthViewOutput, AuthInteractorOutput {

    weak var view: AuthViewInput!
    var interactor: AuthInteractorInput!
    var router: AuthRouterInput!

    func viewIsReady() {
        self.view.setupInitialState()
        self.interactor.fetchUser()
    }
    
    func didSignOutAction() {
        self.interactor.deleteUser()
    }
    
    // MARK: AuthInteractorOutput
    
    func handleError(error: ErrorDescriptor) {
        self.router.presentErrorAlert(error: error)
    }
    
    func loadUser(user: User) {
        self.view.setUpGuestUser(isGuest: false)
        self.view.setupUserName(username: user.name)
        self.view.setupEmail(email: user.email)
    }
    
    func unloadUser() {
        self.view.setUpGuestUser(isGuest: true)
    }
}
