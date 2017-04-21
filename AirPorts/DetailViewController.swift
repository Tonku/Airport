//
//  DetailViewController.swift
//  AirPorts
//
//  Created by Tony Thomas on 21/2/17.
//  Copyright © 2017 Tony Thomas. All rights reserved.
//

import UIKit
import MapKit

class DetailViewController: UIViewController {

    let keyValueCellReuseID = "kKeyValueCellReuseID"
    let headerViewReuseUD = "kHeaderViewReuseID"
    let mapCellReuseID = "kMapCellReuseID"

    lazy var tableView: UITableView = {
        let tv = UITableView(frame: CGRect.zero, style: .plain)
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.register(DetailTableViewCell.self, forCellReuseIdentifier: self.keyValueCellReuseID)
        tv.register(MapTableViewCell.self, forCellReuseIdentifier: self.mapCellReuseID)
        tv.register(DetailTableHeaderTitleView.self, forHeaderFooterViewReuseIdentifier: self.headerViewReuseUD)
        tv.estimatedRowHeight = 50
        tv.separatorStyle = .none
        tv.dataSource = self
        tv.delegate = self
        tv.accessibilityLabel = "detail-tableview"
        return tv
    }()

    var detailVieModel: AirPortDetailViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Airport"
        view.addSubview(tableView)
        tableView.reloadData()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        tableView.reloadData()
    }

    override var shouldAutorotate: Bool {
        return true
    }
}

extension DetailViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        var cellToReturn: UITableViewCell

        if indexPath.row > 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: keyValueCellReuseID) as! DetailTableViewCell
            cellToReturn = cell
            cell.backgroundColor = UIColor.white
            if (indexPath.row % 2) != 0 {
                cell.backgroundColor = UIColor.flatWhite
            }
            switch indexPath.row {
            case 1:
                cell.keyLabel.text = "Country"
                cell.valueLabel.text = detailVieModel.country
            case 2:
                cell.keyLabel.text = "Currency"
                cell.valueLabel.text = detailVieModel.currency
            case 3:
                cell.keyLabel.text = "Time Zone"
                cell.valueLabel.text = detailVieModel.timeZone
            case 4:
                cell.keyLabel.text = "International Airport"
                cell.valueLabel.text = detailVieModel.isInternationalAirport
            case 5:
                cell.keyLabel.text = "Regional Airport"
                cell.valueLabel.text = detailVieModel.isRegionalAirport
            default:
                fatalError()
            }
        } else {
            switch indexPath.row {
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: mapCellReuseID) as! MapTableViewCell
                cell.setLocation(location: detailVieModel.airPort.location)
                cellToReturn = cell
            default:
                fatalError()
            }
        }
        return cellToReturn
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}

extension DetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 200
        } else {
            return UITableViewAutomaticDimension
        }
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: headerViewReuseUD) as! DetailTableHeaderTitleView
        headerView.header.text = detailVieModel.airPortName
        return headerView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UIDevice.isPad() ? 50 : 40
    }
}
