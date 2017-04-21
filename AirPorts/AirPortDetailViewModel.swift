//
//  AirPortDetailViewModel.swift
//  AirPorts
//
//  Created by Tony Thomas on 22/2/17.
//  Copyright © 2017 Tony Thomas. All rights reserved.
//



final class AirPortDetailViewModel {

    let airPort: AirPort
    var isInternationalAirport: String {
        get {
            return airPort.international_airport ? "Yes" : "No"
        }
    }

    var isRegionalAirport: String {
        get {
            return airPort.regional_airport ? "Yes" : "No"
        }
    }

    var timeZone: String {
        get {
            return airPort.timezone.isEmpty ? "Not available" : airPort.timezone
        }
    }

    var currency: String {
        get {
            return airPort.currency_code
        }
    }

    var country: String {
        get {
            if let country = airPort.country {
                return country.display_name
            }
            return "Not avilable"
        }
    }

    var airPortName: String {
        get {
            return airPort.display_name
        }
    }

    init(airPort: AirPort) {
        self.airPort = airPort
    }
}
