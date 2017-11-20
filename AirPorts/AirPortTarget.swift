//
//  AirPortTarget.swift
//  AirPorts
//
//  Created by Tony Thomas on 2/3/17.
//  Copyright © 2017 Tony Thomas. All rights reserved.
//

import Foundation
import Moya

enum AirPortTarget: TargetType {
    case airportList
}

extension AirPortTarget {

    var baseURL: URL {
        return URL(string: "https://www.qantas.com.au")!
    }

    var path: String {
        return "/api/airports"
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var headers: [String: String]? {
        return nil
    }
    
    var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }
    
    var sampleData: Data {
        get {
            let json = "{\"airports\" :[{       \"code\": \"MEL\",       \"display_name\": \"Melbourne\",       \"international_airport\": true,       \"regional_airport\": false,       \"location\": {         \"latitude\": -37.666668,         \"longitude\": 144.83333       },       \"currency_code\": \"AUD\",       \"timezone\": \"Australia/Sydney\",       \"country\": {         \"code\": \"AU\",         \"display_name\": \"Australia\"       }     }]}"
            return json.data(using: .utf8)!
        }
    }
    
    var task: Task {
        get {
            return .requestPlain
        }
    }
    
    var validate: Bool {
        get {
            return false
        }
    }
    
    
}
