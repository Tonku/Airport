//
//  Utilities.swift
//  AirPorts
//
//  Created by Tony Thomas on 20/2/17.
//  Copyright © 2017 Tony Thomas. All rights reserved.
//

import UIKit

extension UIDevice {
    static func isPad() -> Bool {
       return UIDevice.current.userInterfaceIdiom == .pad
    }
}

enum AppError: Error {
    case realmWriteError
    case realmReadError
    case unknownJSONFormat
    case requestTimeout
    case noInternetConnection
    case httpError(Int)
    case unknownError

    var errorDetails: String {
        get {
            switch self {
            case .realmWriteError:
                return "Cannot write to local database"
            case .realmReadError:
                return "Cannot read from local database"
            case .unknownJSONFormat:
                return "The data format is incorret"
            case .requestTimeout:
                return "The newtork is too slow or no network, please try later"
            case .noInternetConnection:
                return "The Internet connection appears to be offline."
            case let .httpError(statusCode):
                switch statusCode {
                case 400:
                    return "request contains incorrect syntax."
                case 403:
                    return "Access to data is denied"
                case 404:
                    return "Could not found the required information online"
                case 500...510:
                    return "Server error"
                default:
                    return "An unknown error occured"
                }
            case .unknownError:
                return "An unknown error occured"
            }
        }
    }
}
