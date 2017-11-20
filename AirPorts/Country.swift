//
//  Country.swift
//  AirPorts
//
//  Created by Tony Thomas on 15/2/17.
//  Copyright © 2017 Tony Thomas. All rights reserved.
//

import UIKit
import RealmSwift

class Country: Object {
    
    @objc dynamic var code: String = ""
    @objc dynamic var display_name: String = ""

}
