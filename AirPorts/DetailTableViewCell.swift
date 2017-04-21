//
//  DetailTableViewCell.swift
//  AirPorts
//
//  Created by Tony Thomas on 22/2/17.
//  Copyright © 2017 Tony Thomas. All rights reserved.
//

import UIKit

class DetailTableViewCell: UITableViewCell {

    lazy var keyLabel: UILabel = {
        let label = UILabel()
        let fontSize: CGFloat = UIDevice.isPad() ? 22 : 18
        label.font = UIFont.systemFont(ofSize: fontSize, weight: UIFontWeightMedium)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.gray
        return label
    }()

    lazy var valueLabel: UILabel = {
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
        contentView.addSubview(keyLabel)
        contentView.addSubview(valueLabel)
        let views = ["airPort": keyLabel, "country": valueLabel]
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[airPort][country]-|", options: [], metrics: nil, views: views))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[airPort]-|", options: [], metrics: nil, views: views))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[country]-|", options: [], metrics: nil, views: views))
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
