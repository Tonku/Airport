//
//  AirportListViewTest.swift
//  AirPorts
//
//  Created by Tony Thomas on 25/2/17.
//  Copyright © 2017 Tony Thomas. All rights reserved.
//

import UIKit
import KIF
import Nimble
@testable import AirPorts

class AirportUITest: KIFTestCase {

    override func beforeAll() {
        super.beforeAll()
        //useTestDatabase()
    }

    func testUI() {
        welcomeScreenTest()
        airPortListTest()
        searchTest()
        detailsTest()
        goBackToAirPortListTest()
    }
    func welcomeScreenTest() {
        if isFirstTime() {
            waitForWelcomeScreen()
            waitWelcomeScreenDisapper()
        }
    }
    
    func airPortListTest() {
        waitForMainListWithAirPortNames()
    }
    
    func searchTest() {
        clearSearchText()
        enterSearchText(text: "Melbourne")
        expectToSeeAirPortInList(name: "Melbourne", country: "Australia", atRow: 0)
    }
    
    func detailsTest() {
        tapOnAirportListRow(0)
        waitForDetailViewToAppear()
        expectToSeeMapViewAtRow(0)
        expectToSeeAirPortDetailsWithTitle(key: "Country", value: "Australia", atRow: 1)
        expectToSeeAirPortDetailsWithTitle(key: "Currency", value: "AUD", atRow: 2)
        expectToSeeAirPortDetailsWithTitle(key: "Time Zone", value: "Australia/Sydney", atRow: 3)
        expectToSeeAirPortDetailsWithTitle(key: "International Airport", value: "Yes", atRow: 4)
        expectToSeeAirPortDetailsWithTitle(key: "Regional Airport", value: "No", atRow: 5)
    }

    func goBackToAirPortListTest() {
        goBackToParentListView()
    }
}

extension AirportUITest {

    func isFirstTime()->Bool {
        return !UserDefaults.standard.bool(forKey: "kLocalDBAvailable")
    }

    func waitForWelcomeScreen() {
        tester().waitForView(withAccessibilityLabel: "welcome")
        //ensure app name label visible
        tester().waitForView(withAccessibilityLabel: "welcome-appName")
        //ensure loading animation visible
        tester().waitForView(withAccessibilityLabel: "welcome-animation")
        //ensure welcome message visible
        tester().waitForView(withAccessibilityLabel: "welcome-message")
    }

    func waitWelcomeScreenDisapper() {
        tester().usingTimeout(120).waitForAbsenceOfView(withAccessibilityLabel: "welcome")
    }

    func waitForMainListWithAirPortNames() {
        let tableView = tester().waitForView(withAccessibilityLabel: "main-list") as! UITableView
        tester().waitForView(withAccessibilityLabel: "search-bar")
        let numberOfRows = tableView.numberOfRows(inSection: 0)
        expect(numberOfRows) > 0
    }

    func tapOnAirportListRow(_ row: Int) {
        let indexPath = IndexPath(row: row, section: 0)
        let airPortList = tester().waitForView(withAccessibilityLabel: "main-list") as! UITableView!
        tester().tapRow(at: indexPath, in: airPortList)
    }

    func waitForDetailViewToAppear() {
        //detailview tableview
        tester().waitForView(withAccessibilityLabel: "detail-tableview")
    }

    func expectToSeeDetailsOfAirport(title: String) {
        tester().waitForView(withAccessibilityLabel: "airport-name")
    }


    func expectToSeeAirPortDetailsWithTitle(key: String, value: String, atRow row: NSInteger) {
        let indexPath = NSIndexPath(row: row, section: 0)
        let detailTableView = tester().waitForView(withAccessibilityLabel: "detail-tableview") as! UITableView!
        let cell = tester().waitForCell(at: indexPath as IndexPath, in: detailTableView) as! DetailTableViewCell
        expect(cell.keyLabel.text) == key
        expect(cell.valueLabel.text) == value
    }

    func expectToSeeMapViewAtRow(_ row: Int) {
        let indexPath = NSIndexPath(row: row, section: 0)
        let detailTableView = tester().waitForView(withAccessibilityLabel: "detail-tableview") as! UITableView!
        let cell = tester().waitForCell(at: indexPath as IndexPath, in: detailTableView)
        expect(cell?.accessibilityLabel) == "map-view"
    }

    func goBackToParentListView()  {
        if let navigationController = UIApplication.shared.keyWindow?.rootViewController as? UINavigationController {
            navigationController.popToRootViewController(animated: false)
            tester().waitForView(withAccessibilityLabel: "main-list")
            clearSearchText()
        }
    }

    func clearSearchText() {
        tester().clearText(fromAndThenEnterText: "", intoViewWithAccessibilityLabel: "search-bar")
    }

    func enterSearchText(text: String)  {
        tester().clearText(fromAndThenEnterText: text, intoViewWithAccessibilityLabel: "search-bar")
    }

    func expectToSeeAirPortInList(name: String, country: String, atRow row: NSInteger) {
        let indexPath = NSIndexPath(row: row, section: 0)
        let airPortList = tester().waitForView(withAccessibilityLabel: "main-list") as! UITableView!
        let cell = tester().waitForCell(at: indexPath as IndexPath, in: airPortList) as! MainTableViewCell
        expect(cell.airPort.text) == name
        expect(cell.country.text) == country
    }
    
}

