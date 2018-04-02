//
//  AuthAuthInteractor.swift
//  Weather
//
//  Created by KONSTANTIN KUSAINOV on 01/04/2018.
//  Copyright © 2018 Konstantin. All rights reserved.
//

class AuthInteractor: AuthInteractorInput {

    weak var output: AuthInteractorOutput!
    private let userService = UserService()
    
    func fetchUser() {
        self.getUserService()
        
        self.userService.completionFailure = { [weak self] (error) in
            self?.output.handleError(error: error)
        }
        
        self.userService.successSignIn = { [weak self] in
            self?.getUserService()
        }
        
        self.userService.successSignOut = { [weak self] in
            self?.output.unloadUser()
        }
    }
    
    func deleteUser() {
        self.userService.signOut()
    }
    
    private func getUserService() {
        if let user = self.userService.user {
            self.output.loadUser(user: user)
        }
    }
}
