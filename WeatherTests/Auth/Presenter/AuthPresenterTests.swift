//
//  AuthAuthPresenterTests.swift
//  Weather
//
//  Created by KONSTANTIN KUSAINOV on 01/04/2018.
//  Copyright © 2018 Konstantin. All rights reserved.
//

import XCTest

class AuthPresenterTest: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    class MockInteractor: AuthInteractorInput {

    }

    class MockRouter: AuthRouterInput {

    }

    class MockViewController: AuthViewInput {

        func setupInitialState() {

        }
    }
}
