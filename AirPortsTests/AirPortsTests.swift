//
//  AirPortsTests.swift
//  AirPortsTests
//
//  Created by Tony Thomas on 5/3/17.
//  Copyright © 2017 Tony Thomas. All rights reserved.
//

import Foundation
import Quick
import Nimble
import Moya

@testable import AirPorts

class AirportTests: QuickSpec {

    override func spec() {

        describe("Testing API call and populate the local DB") {
            var airportList: [[String: Any]]?
            var appError: AppError?
            let localDB = LocalDB()
            let apiService = APIService()

            beforeEach {
                appError = nil
                airportList = nil
            }

            context("Reading data from server Success") {
                beforeEach {
                    apiService.airPortsProvider = MoyaProvider<AirPortTarget>(stubClosure: MoyaProvider.immediatelyStub)
                    apiService.getAirPortList(completion: { (json, error) in
                        airportList = json!
                    })
                }
                it("Return a list of airports") {
                    expect(airportList).toEventuallyNot(beNil())
                }
            }

            context("test http error") {
                beforeEach {
                    let endpointResolution: MoyaProvider<AirPortTarget>.EndpointClosure = { target in
                        let url = target.baseURL.appendingPathComponent(target.path).absoluteString
                        return Endpoint(url: url, sampleResponseClosure: {.networkResponse(404, Data())}, method: target.method, parameters: target.parameters)
                    }
                    let provider = MoyaProvider<AirPortTarget>(endpointClosure: endpointResolution, stubClosure: MoyaProvider.immediatelyStub)
                    apiService.airPortsProvider = provider
                    apiService.getAirPortList(completion: { (json, error) in
                        appError = error!
                    })
                }
                it("Return a 404 error") {
                    expect(appError).toEventuallyNot(beNil())
                    expect(appError?.errorDetails) == "Could not found the required information online"
                }
            }

            context("Database insert") {
                beforeEach {
                    apiService.airPortsProvider = MoyaProvider<AirPortTarget>(stubClosure: MoyaProvider.immediatelyStub)
                    apiService.getAirPortList(completion: { (json, error) in
                        try! localDB.writeJSON(type: AirPort.self, json: json!)
                    })
                }
                it("Database contains one AirPort") {
                    let predicate = NSPredicate(format: "display_name CONTAINS[c] %@", "")
                    let sortBlock = { (airport1: AirPort, airport2: AirPort) in
                        return airport1.display_name.caseInsensitiveCompare(airport2.display_name) == .orderedAscending ? true : false
                    }
                    localDB.queryDB(type: AirPort.self, predicate: predicate, sortProc: sortBlock, completion: { (airports, error) in
                        expect(airports.count) == 1
                        expect(airports.first?.code) == "MEL"
                        expect(airports.first?.display_name) == "Melbourne"
                        expect(airports.first?.country?.display_name) == "Australia"
                        expect(airports.first?.currency_code) == "AUD"
                        expect(airports.first?.international_airport) == true
                        expect(airports.first?.regional_airport) == false
                        expect(airports.first?.timezone) == "Australia/Sydney"
                    })
                }
            }
        }
    }
}
