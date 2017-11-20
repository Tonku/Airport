//
//  HeaderTableViewCell.swift
//  AirPorts
//
//  Created by Tony Thomas on 22/2/17.
//  Copyright © 2017 Tony Thomas. All rights reserved.
//

import UIKit

class HeaderTableViewCell: UITableViewCell {

    lazy var header: UILabel = {
        let label = UILabel()
        let fontSize: CGFloat = UIDevice.isPad() ? 32 : 24
        label.font = UIFont.systemFont(ofSize: fontSize, weight: UIFont.Weight.medium)
        label.textAlignment = .center
        return label
    }()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layoutMargins = UIEdgeInsets.zero
        separatorInset = UIEdgeInsets.zero
        selectionStyle = .none
        contentView.addSubview(header)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        header.frame = contentView.bounds
    }
}
