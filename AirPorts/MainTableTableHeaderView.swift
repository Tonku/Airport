//
//  MainTableTableHeaderView.swift
//  AirPorts
//
//  Created by Tony Thomas on 21/2/17.
//  Copyright © 2017 Tony Thomas. All rights reserved.
//

import UIKit
import ChameleonFramework

class MainTableTableHeaderView: UITableViewHeaderFooterView {
    
    lazy var airPort: UILabel = {
        let label = UILabel()
        let fontSize: CGFloat = UIDevice.isPad() ? 22 : 18
        label.font = UIFont.systemFont(ofSize: fontSize, weight: UIFont.Weight.medium)
        label.textColor = UIColor.white
        label.text = "Airport"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var country: UILabel = {
        let label = UILabel()
        let fontSize: CGFloat = UIDevice.isPad() ? 18 : 16
        label.font = UIFont.systemFont(ofSize: fontSize, weight: UIFont.Weight.medium)
        label.textColor = UIColor.gray
        label.textAlignment = .right
        label.textColor = UIColor.white
        label.text = "Country"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = UIColor.flatMint
        contentView.addSubview(airPort)
        contentView.addSubview(country)

        let views = ["airPort": airPort, "country": country]
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[airPort][country]-|", options: [], metrics: nil, views: views))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[airPort]-|", options: [], metrics: nil, views: views))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[country]-|", options: [], metrics: nil, views: views))
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
