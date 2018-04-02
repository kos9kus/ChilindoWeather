//
//  UserService.swift
//  Weather
//
//  Created by KONSTANTIN KUSAINOV on 02/04/2018.
//  Copyright © 2018 KONSTANTIN KUSAINOV. All rights reserved.
//

import Foundation
import GoogleSignIn

class UserService: NSObject, GIDSignInDelegate {
    
    private(set) var user: User? {
        didSet {
            self.user != nil ? self.successSignIn?() : self.successSignOut?()
        }
    }
    
    var successSignIn: (() -> ())?
    var successSignOut: (() -> ())?
    var completionFailure: ((_ error: ErrorDescriptor) -> ())?
    
    override init() {
        super.init()
        GIDSignIn.sharedInstance().clientID = "1056142528185-nrrq2kgq4f5m3cesvaencmfb3hid7584.apps.googleusercontent.com"
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().signInSilently()
        if let user = GIDSignIn.sharedInstance().currentUser {
            self.setCurrentUser(user: user)
        }
    }
    
    func signOut() {
        GIDSignIn.sharedInstance().disconnect()
    }
    
    private func setCurrentUser(user: GIDGoogleUser) {
        self.user = User(name: user.profile.name, email: user.profile.email)
    }
    
    // MARK: GIDSignInDelegate
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
        if let error = error as NSError? {
            print("\(error.localizedDescription)")
            let title = "Sign in error"
            switch error.code {
            case -4, -5:
                break
            case -2:
                let message = "Keychain problem"
                self.completionFailure?(ErrorDescriptor(title: title, message: message))
            default:
                let message = "Unknown"
                self.completionFailure?(ErrorDescriptor(title: title, message: message))
            }
        } else {
            self.setCurrentUser(user: user)
        }
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error?) {
        if let e = error {
            self.completionFailure?(ErrorDescriptor(title: "Sign out error", message: e.localizedDescription))
            self.setCurrentUser(user: GIDSignIn.sharedInstance().currentUser)
        } else {
            self.user = nil
        }
    }
}
