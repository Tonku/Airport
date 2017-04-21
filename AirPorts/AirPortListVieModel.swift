//
//  AirPortListVieModel.swift
//  AirPorts
//
//  Created by Tony Thomas on 15/2/17.
//  Copyright © 2017 Tony Thomas. All rights reserved.
//

import RealmSwift
import RxSwift
import RxCocoa

final class AirPortListVieModel {

    let dbKey = "kLocalDBAvailable"
    lazy var localDB = LocalDB()
    var searchText = Variable<String?>("")
    var airPorts = Variable<[AirPort]>([])
    let disposeBag = DisposeBag()

    func wireRX() {
        searchText.asObservable().flatMapLatest { searchString -> Observable<[AirPort]> in
            return self.findAirports(searchQuery: searchString!)
            }.bindTo(airPorts).addDisposableTo(disposeBag)
    }
    
    func hasLoocalDB()->Bool {
        return UserDefaults.standard.bool(forKey: dbKey)
    }
    
    func callAPIandPopulateDB(completion:@escaping (AppError?)->Void)  {
        //Set the timeout
        APIService.shared.getAirPortList { [weak self] (json, error) in
            guard let json = json else {
                completion(error)
                return
            }
            do {
                try self?.localDB.writeJSON(type: AirPort.self, json: json)
            } catch {
                print(AppError.realmWriteError.errorDetails)
            }
            if let unWrappedSelf = self {
                UserDefaults.standard.set(true, forKey: unWrappedSelf.dbKey)
            }
            completion(nil)
        }
    }

    func airPortAtIndex(index: NSIndexPath) -> AirPort? {
        var airPort: AirPort? = nil
        if index.row < airPorts.value.count {
            airPort = airPorts.value[index.row]
        }
        return airPort
    }

    func findAirports(searchQuery: String) -> Observable<[AirPort]> {
        return Observable.create { [weak self] observer in
            let predicate = NSPredicate(format: "display_name CONTAINS[c] %@", searchQuery)
            let sortBlock = { (airport1: AirPort, airport2: AirPort) in
                return airport1.display_name.caseInsensitiveCompare(airport2.display_name) == .orderedAscending ? true : false
            }
            self?.localDB.queryDB(type: AirPort.self, predicate: predicate, sortProc: sortBlock, completion: { (airports, error) in
                if (error != nil) {
                    observer.onError(AppError.realmReadError)
                } else {
                    observer.onNext(airports)
                }
            })
            return Disposables.create()
        }
    }
}
