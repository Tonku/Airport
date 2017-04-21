//
//  HeaderTitleView.swift
//  AirPorts
//
//  Created by Tony Thomas on 22/2/17.
//  Copyright © 2017 Tony Thomas. All rights reserved.
//

import UIKit

class DetailTableHeaderTitleView: UITableViewHeaderFooterView {

    lazy var header: UILabel = {
        let label = UILabel()
        let fontSize: CGFloat = UIDevice.isPad() ? 32 : 24
        label.font = UIFont.systemFont(ofSize: fontSize, weight: UIFontWeightMedium)
        label.textAlignment = .center
        return label
    }()

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        contentView.addSubview(header)
        contentView.backgroundColor = UIColor.flatWhite
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        header.frame = bounds
    }

}
