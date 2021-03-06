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
        self.getUserFromService()
        
        self.userService.completionFailure = { [weak self] (error) in
            self?.output.handleError(error: error)
        }
        
        self.userService.successSignIn = { [weak self] in
            self?.getUserFromService()
        }
        
        self.userService.successSignOut = { [weak self] in
            self?.output.unloadUser()
        }
    }
    
    func deleteUser() {
        self.userService.signOut()
    }
    
    private func getUserFromService() {
        if let user = self.userService.user {
            self.output.loadUser(user: user)
        }
    }
}
