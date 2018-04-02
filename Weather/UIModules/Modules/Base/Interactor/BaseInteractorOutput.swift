//
//  BaseBaseInteractorOutput.swift
//  Weather
//
//  Created by KONSTANTIN KUSAINOV on 30/03/2018.
//  Copyright © 2018 Konstantin. All rights reserved.
//

import Foundation

protocol BaseInteractorErrorOutput: class {
    func handleError(error: ErrorDescriptor)
}

protocol BaseInteractorOutput: BaseInteractorErrorOutput {
    func hideError()
    func showLocationErrorMessage(message: String)
    func assignFetchData()
}
