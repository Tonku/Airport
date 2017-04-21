//
//  MapTableViewCell.swift
//  AirPorts
//
//  Created by Tony Thomas on 22/2/17.
//  Copyright © 2017 Tony Thomas. All rights reserved.
//

import UIKit
import MapKit

class MapTableViewCell: UITableViewCell {

    lazy var mapView: MKMapView = {
        let label = MKMapView()
        return label
    }()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        contentView.addSubview(mapView)
        accessibilityLabel  = "map-view"
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        mapView.frame = contentView.bounds
    }

    func setLocation(location: Location?) {
        guard let logitude = location?.longitude.value, let latitude = location?.latitude.value else {
            return
        }
        let annotation = MKPointAnnotation()
        let centerCoordinate = CLLocationCoordinate2D(latitude: latitude, longitude:logitude)
        annotation.coordinate = centerCoordinate
        annotation.title = "Title"
        mapView.addAnnotation(annotation)

        let mapCenter = CLLocationCoordinate2DMake(latitude, logitude)
        let span = MKCoordinateSpanMake(0.1, 0.1)
        let region = MKCoordinateRegionMake(mapCenter, span)
        mapView.region = region
    }
}
