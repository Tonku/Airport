//
//  Location.swift
//  AirPorts
//
//  Created by Tony Thomas on 15/2/17.
//  Copyright © 2017 Tony Thomas. All rights reserved.
//

import UIKit
import RealmSwift

class Location: Object {

    let latitude = RealmOptional<Double>()
    let longitude = RealmOptional<Double>()
    
}
