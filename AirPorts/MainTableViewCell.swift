//
//  MainTableViewCell.swift
//  AirPorts
//
//  Created by Tony Thomas on 20/2/17.
//  Copyright © 2017 Tony Thomas. All rights reserved.
//

import UIKit

class MainTableViewCell: UITableViewCell {

    lazy var airPort: UILabel = {
        let label = UILabel()
        let fontSize: CGFloat = UIDevice.isPad() ? 22 : 18
        label.font = UIFont.systemFont(ofSize: fontSize, weight: UIFontWeightMedium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var country: UILabel = {
        let label = UILabel()
        let fontSize: CGFloat = UIDevice.isPad() ? 18 : 16
        label.font = UIFont.systemFont(ofSize: fontSize, weight: UIFontWeightMedium)
        label.textColor = UIColor.gray
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        return label
    }()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layoutMargins = UIEdgeInsets.zero
        separatorInset = UIEdgeInsets.zero
        selectionStyle = .none
        contentView.addSubview(airPort)
        contentView.addSubview(country)
        let views = ["airPort": airPort, "country": country]
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-5-[airPort][country]-5-|", options: [], metrics: nil, views: views))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-8-[airPort]-8-|", options: [], metrics: nil, views: views))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-8-[country]-8-|", options: [], metrics: nil, views: views))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
