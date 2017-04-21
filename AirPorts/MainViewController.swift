//
//  MainViewController.swift
//  AirPorts
//
//  Created by Tony Thomas on 14/2/17.
//  Copyright © 2017 Tony Thomas. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import RxOptional

class MainViewController: UIViewController {

    lazy var tableView: UITableView = {
        let tv = UITableView(frame: CGRect.zero, style: .plain)
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.register(MainTableViewCell.self, forCellReuseIdentifier: self.kCellReuseID)
        tv.register(MainTableTableHeaderView.self, forHeaderFooterViewReuseIdentifier: self.headerViewReuseUD)
        tv.rowHeight = UITableViewAutomaticDimension
        tv.estimatedRowHeight = 50
        tv.delegate = self
        tv.cellLayoutMarginsFollowReadableWidth = false
        tv.accessibilityLabel = "main-list"
        return tv
    }()

    lazy var searchBar: UISearchBar = {
        let sb = UISearchBar()
        sb.placeholder = "Search Airport"
        sb.returnKeyType = .done
        sb.delegate = self
        sb.autocorrectionType = .no
        sb.autocapitalizationType = .none
        sb.accessibilityLabel = "search-bar"
        return sb
    }()

    lazy var loadingViewController: LoadingViewViewController = {
        let vc = LoadingViewViewController(nibName: "LoadingViewViewController", bundle: nil)
        return vc
    }()

    let kCellReuseID = "kCellReuseID"
    let headerViewReuseUD = "kCellHearderReuseID"
    private var keyboardHeight = 0
    private let searchbarHeight = 44
    let disposeBag = DisposeBag()
    let viewModel = AirPortListVieModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        view.addSubview(tableView)
        view.addSubview(searchBar)

        // Do any additional setup after loading the view, typically from a nib.
        if !viewModel.hasLoocalDB() {
            showLoadingViewController(show: true)
            viewModel.callAPIandPopulateDB { [weak self ] (error) in
                DispatchQueue.main.async {
                    if (error != nil) {
                        self?.loadingViewController.alertLabel.text = error!.errorDetails
                    } else {
                        self?.setupRX()
                        self?.showLoadingViewController(show: false)
                    }
                }
            }
        } else {
            setupRX()
        }

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidDisappear(notification:)), name: NSNotification.Name.UIKeyboardDidHide, object: nil)
        setupLayout()
    }

    func setupRX() {
        viewModel.wireRX()
        enableRx()
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    func keyboardWillAppear(notification: NSNotification) {
        if let userInfo = notification.userInfo,
            let keyboardRect = (userInfo[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            keyboardHeight  = Int(keyboardRect.height)
            setupLayout()
        }
    }

    func keyboardDidDisappear(notification: NSNotification) {
        keyboardHeight = 0
        setupLayout()
    }

    func enableRx() {

        searchBar.rx.text
            .filterNil()
            .debounce(0.2, scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .bindTo(viewModel.searchText)
            .addDisposableTo(disposeBag)

        viewModel.airPorts.asObservable().bindTo(tableView.rx.items(cellIdentifier: self.kCellReuseID, cellType: MainTableViewCell.self)) { (row, element, cell) in
            cell.airPort.text = element.display_name
            cell.country.text = element.country?.display_name }
            .addDisposableTo(disposeBag)
        
        tableView.rx.itemSelected.subscribe(onNext: { [weak self] indexPath in
            if self?.searchBar.isFirstResponder == true {
                self?.searchBar.resignFirstResponder()
            }
            if let airPort = self?.viewModel.airPortAtIndex(index: indexPath as NSIndexPath) {
                let viewViewController = DetailViewController()
                viewViewController.detailVieModel = AirPortDetailViewModel(airPort: airPort)
                self?.navigationController?.pushViewController(viewViewController, animated: true)
            }
        }).addDisposableTo(disposeBag)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func setupLayout() {
        view.removeConstraints(view.constraints)
        let matrics = [
                       "searchBarHeight": searchbarHeight,
                       "bottomPadding": keyboardHeight]
        let views: [String: Any] = [ "tableView": tableView]
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[tableView]-bottomPadding-|",
                                                           options: [],
                                                           metrics: matrics,
                                                           views: views))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[tableView]-0-|",
                                                           options: [],
                                                           metrics: matrics,
                                                           views: views))

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        navigationItem.titleView = searchBar
        loadingViewController.view.bounds = view.bounds
    }

    func showLoadingViewController(show: Bool) {
        if show {
        searchBar.isHidden = true
        addChildViewController(loadingViewController)
        view.addSubview(loadingViewController.view)
        loadingViewController.view.frame = view.bounds
        } else {
            searchBar.isHidden = false
            loadingViewController.removeFromParentViewController()
            loadingViewController.view.removeFromSuperview()
        }
    }

}

extension MainViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: headerViewReuseUD) as! MainTableTableHeaderView
        return headerView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UIDevice.isPad() ? 50 : 40
    }
}

