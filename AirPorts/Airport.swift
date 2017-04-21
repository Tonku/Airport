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

    dynamic var code: String = ""
    dynamic var display_name: String = ""
    dynamic var currency_code: String = ""
    dynamic var timezone: String = ""
    dynamic var international_airport: Bool = false
    dynamic var regional_airport: Bool = false
    dynamic var country: Country? = Country()
    dynamic var location: Location? = Location()
    
}
