//
//  APIService.swift
//  AirPorts
//
//  Created by Tony Thomas on 28/2/17.
//  Copyright © 2017 Tony Thomas. All rights reserved.
//


import Alamofire
import Moya

final class APIService {


    static let httpSuccessCode: Int = 200
    var airPortsProvider = MoyaProvider<AirPortTarget>()

    static var shared: APIService {
        return APIService()
    }

    func getAirPortList(completion: @escaping ([[String: Any]]?, AppError?)->Void) {
        airPortsProvider.request(.airportList) { (response) in
            switch(response) {
            case let .success(moyaResponse):
                if moyaResponse.statusCode == APIService.httpSuccessCode {
                    do {
                        let data = try moyaResponse.mapJSON()
                        if let json = data as? [String: Any],
                            let airPorts = json["airports"] as? [[String:Any]]{
                            completion(airPorts, nil)
                            return
                        } else {
                            completion(nil, AppError.unknownJSONFormat)
                            return
                        }
                    } catch {
                        completion(nil, AppError.unknownJSONFormat)
                        return
                    }
                }
                completion(nil, AppError.httpError(moyaResponse.statusCode))
            case let .failure(error):
                switch error {
                case let .underlying(uError) where uError.0._code == NSURLErrorNotConnectedToInternet:
                    completion(nil, AppError.noInternetConnection)
                case let .underlying(uError) where uError.0._code == NSURLErrorTimedOut:
                    completion(nil, AppError.requestTimeout)
                default:
                    completion(nil, AppError.unknownError)
                }
            }
        }
    }
}
