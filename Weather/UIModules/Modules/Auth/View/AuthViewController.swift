//
//  AuthAuthViewController.swift
//  Weather
//
//  Created by KONSTANTIN KUSAINOV on 01/04/2018.
//  Copyright © 2018 Konstantin. All rights reserved.
//

import UIKit
import GoogleSignIn

class AuthViewController: UIViewController, AuthViewInput, GIDSignInUIDelegate {

    var output: AuthViewOutput!
    @IBOutlet weak var signInGoogleButton: GIDSignInButton!
    @IBOutlet var GuestView: UIView!
    @IBOutlet var UserView: UIView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var emailLabel: UILabel!
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance().uiDelegate = self
        output.viewIsReady()
    }
    
    private func clearUserLabels() {
        self.nameLabel.text = nil
        self.emailLabel.text = nil
    }

    // MARK: AuthViewInput
    func setupInitialState() {
        self.GuestView.isHidden = false
        self.UserView.isHidden = true
    }
    
    func setUpGuestUser(isGuest: Bool) {
        if isGuest {
            self.clearUserLabels()
        }
        self.GuestView.isHidden = !isGuest
        self.UserView.isHidden = isGuest
    }
    
    func setupEmail(email: String) {
        self.emailLabel.text = email
    }
    
    func setupUserName(username: String) {
        self.nameLabel.text = username
    }
    
    // MARK: Actions
    
    @IBAction func didTapLogOut(_ sender: UIButton) {
        self.output.didSignOutAction()
    }
}
