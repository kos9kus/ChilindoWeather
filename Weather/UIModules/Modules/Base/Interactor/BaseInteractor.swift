//
//  BaseBaseInteractor.swift
//  Weather
//
//  Created by KONSTANTIN KUSAINOV on 30/03/2018.
//  Copyright © 2018 Konstantin. All rights reserved.
//

import Foundation

class BaseInteractor: BaseInteractorInput {

    weak var output: BaseInteractorOutput!
    
    let networkService = WeatherService()
    let locationService = LocationService()
    
    func fetch() {
        self.locationService.requestAuthorizationLocation { [unowned self] (access) in
            switch access {
            case .Success:
                self.output.hideError()
                self.locationService.requestPosition(successCompletion: { (position) in
                    self.makeRequest(position: position)
                }, failureCompletion: { (error) in
                    self.output.handleError(error: error.descriptor)
                    self.output.showLocationErrorMessage(message: error.descriptor.message)
                })
                break
			case .Failed:
				self.output.handleError(error: access.descriptor)
                self.output.showLocationErrorMessage(message: access.descriptor.message)
            default:
                break
            }
        }
    }
    
    func makeRequest(position: Position) {}
    
    func handleParserErrorMainThread(status: ParserStatus) {
        DispatchQueue.main.async {
            self.output.handleError(error: status.descriptor)
        }
    }
}
