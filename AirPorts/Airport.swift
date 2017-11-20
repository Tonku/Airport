//
//  Airport.swift
//  AirPorts
//
//  Created by Tony Thomas on 15/2/17.
//  Copyright © 2017 Tony Thomas. All rights reserved.
//

import UIKit
import RealmSwift

class AirPort: Object {

    @objc dynamic var code: String = ""
    @objc dynamic var display_name: String = ""
    @objc dynamic var currency_code: String = ""
    @objc dynamic var timezone: String? = ""
    @objc dynamic var international_airport: Bool = false
    @objc dynamic var regional_airport: Bool = false
    @objc dynamic var country: Country? = Country()
    @objc dynamic var location: Location? = Location()
    
}
