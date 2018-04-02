//
//  BaseBaseViewController.swift
//  Weather
//
//  Created by KONSTANTIN KUSAINOV on 30/03/2018.
//  Copyright © 2018 Konstantin. All rights reserved.
//

import UIKit
import SnapKit

class BaseViewController: UIViewController, BaseViewInput, UITableViewDelegate {

    @IBOutlet var tableView: UITableView!
    private var warningLabel: UILabel = {
        let l = UILabel()
        l.numberOfLines = 2
        l.textAlignment = .center
        return l
    }()
    private var reloadButton: UIButton = {
        let b = UIButton(type: .roundedRect)
        b.setTitle("Reload", for: .normal)
        b.addTarget(self, action: #selector(didActionControl), for: UIControlEvents.touchUpInside)
        return b;
    }()
    private var refresher: UIRefreshControl = {
        let v = UIRefreshControl()
        v.addTarget(self, action: #selector(didActionControl), for: UIControlEvents.valueChanged)
        return v
    }()
    
    var output: BaseViewOutput!

    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.warningLabel)
        self.view.addSubview(self.reloadButton)

        self.warningLabel.snp.makeConstraints({ (make) in
            make.left.equalToSuperview().inset(20)
            make.right.equalToSuperview().inset(20)
            make.top.equalToSuperview().inset(80)
        })
        self.reloadButton.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 100, height: 25))
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        
        self.tableView.register(WeatherTableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: WeatherTableViewHeaderFooterView.cellReuseIdentifier)
        self.tableView.register(WeatherDayTableViewCell.self, forCellReuseIdentifier: WeatherDayTableViewCell.cellReuseIdentifier)
        self.tableView.delegate = self
        self.tableView.dataSource = self.output as? UITableViewDataSource
        self.tableView.refreshControl = self.refresher
        output.viewIsReady()
    }


    // MARK: BaseViewInput
    func setupInitialState() {
    }
    
    func hiddenReloadUI(hide: Bool) {
        self.reloadButton.isHidden = hide
        self.warningLabel.isHidden = hide
        self.tableView.isHidden = !hide
    }
    
    func setMessageTitle(message: String) {
        self.warningLabel.text = message
    }
    
    func visibleActivitySpinner(visible: Bool) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = visible
        if !visible {
            self.refresher.endRefreshing()
        }
    }
    
    func reloadData() {
        self.tableView.reloadData()
    }
    
     // MARK: Actions
    
    @objc func didActionControl() {
        self.output.viewActionReloadData()
    }
    
    // MARK: UITableViewDelegate
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: WeatherTableViewHeaderFooterView.cellReuseIdentifier) as? WeatherTableViewHeaderFooterView  else { fatalError("Unexpected header type") }
        
        let todayData = WeatherDate.nowDate
        header.configureForCell(model: todayData)
        return header
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
