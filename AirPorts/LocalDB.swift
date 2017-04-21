//
//  AsyncDB.swift
//  AirPorts
//
//  Created by Tony Thomas on 20/2/17.
//  Copyright © 2017 Tony Thomas. All rights reserved.
//

import RealmSwift

final class LocalDB {
    let serialQueue = DispatchQueue(label: "dbqueue")
    func queryDB <T : RealmSwift.Object> (type: T.Type, predicate: NSPredicate, sortProc: (T, T)->Bool, completion: ([T], NSError?)->Void)  {
        serialQueue.sync {
            do {
                let realm = try RealmProvider.realm()
                let result = realm.objects(type.self).filter(predicate).sorted(by: sortProc)
                completion(Array(result), nil)
            } catch let error as NSError {
                completion([], error)
            }
        }
    }

    func writeJSON <T : RealmSwift.Object> (type: T.Type, json: [[String:Any]]) throws {
        let realm = try RealmProvider.realm()
        try realm.write {
            for airPort in json {
                realm.create(type.self, value: airPort, update: false)
            }
        }
    }
    
}


class RealmProvider {
    class func realm() throws -> Realm {
        if let _ = NSClassFromString("QuickSpec") {
           return try Realm(configuration: Realm.Configuration(fileURL: nil, inMemoryIdentifier: "airPortTest", syncConfiguration: nil, encryptionKey: nil, readOnly: false, schemaVersion: 0, migrationBlock: nil, deleteRealmIfMigrationNeeded: false, objectTypes: nil))
        } else {
            return try Realm();
            
        }
    }
}


