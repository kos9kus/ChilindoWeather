//
//  AuthAuthConfiguratorTests.swift
//  Weather
//
//  Created by KONSTANTIN KUSAINOV on 01/04/2018.
//  Copyright © 2018 Konstantin. All rights reserved.
//

import XCTest

class AuthModuleConfiguratorTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testConfigureModuleForViewController() {

        //given
        let viewController = AuthViewControllerMock()
        let configurator = AuthModuleConfigurator()

        //when
        configurator.configureModuleForViewInput(viewInput: viewController)

        //then
        XCTAssertNotNil(viewController.output, "AuthViewController is nil after configuration")
        XCTAssertTrue(viewController.output is AuthPresenter, "output is not AuthPresenter")

        let presenter: AuthPresenter = viewController.output as! AuthPresenter
        XCTAssertNotNil(presenter.view, "view in AuthPresenter is nil after configuration")
        XCTAssertNotNil(presenter.router, "router in AuthPresenter is nil after configuration")
        XCTAssertTrue(presenter.router is AuthRouter, "router is not AuthRouter")

        let interactor: AuthInteractor = presenter.interactor as! AuthInteractor
        XCTAssertNotNil(interactor.output, "output in AuthInteractor is nil after configuration")
    }

    class AuthViewControllerMock: AuthViewController {

        var setupInitialStateDidCall = false

        override func setupInitialState() {
            setupInitialStateDidCall = true
        }
    }
}
