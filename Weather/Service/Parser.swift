//
//  Parser.swift
//  Weather
//
//  Created by KONSTANTIN KUSAINOV on 28/03/2018.
//  Copyright © 2018 KONSTANTIN KUSAINOV. All rights reserved.
//

import Foundation

enum ParserStatus: ErrorDescriptorProtocol {
    case Success, InvalidData, InternalError(NSError), ServerError, ClientError, UnknownError
	
	var descriptor: ErrorDescriptor {
		var title = "Network error"
		var message = ""
		switch self {
		case .ClientError:
			message = "Client error: 4** http error"
		case .ServerError:
			message = "Server error"
		case .InvalidData:
			title = "Cant parse response"
			message = "Invalid server response data"
		case .Success:
			title = "Network Success"
			message = "No error"
		case .InternalError(let error):
			message = error.localizedDescription
		default:
			message = "Unknown internal error"
		}
		return ErrorDescriptor(title: title, message: message)
	}
}

class Parser {
    private let jsonDecoder = JSONDecoder()
    
    func parseError(response: HTTPURLResponse?, error: Error?) -> ParserStatus {
        if let e = error as NSError?  {
            return .InternalError(e)
        } else if let r = response {
            switch r.statusCode {
            case 200...299:
                return .Success
            case 400...499:
                return .ClientError
            case 500...599:
                return .ServerError
            default:
                return .UnknownError
            }
        }
        return .UnknownError
    }
    
    func parseData<T>(data: Data, completion: @escaping (T?, ParserStatus) -> ()) where T: Decodable {
        do {
            let parsedData = try jsonDecoder.decode(T.self, from: data)
            completion(parsedData, .Success)
        } catch {
            completion(nil, .InvalidData)
        }
    }
}
