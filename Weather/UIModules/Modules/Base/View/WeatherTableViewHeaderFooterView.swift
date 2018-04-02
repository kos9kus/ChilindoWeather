//
//  WeatherTableViewHeaderFooterView.swift
//  Weather
//
//  Created by KONSTANTIN KUSAINOV on 31/03/2018.
//  Copyright © 2018 KONSTANTIN KUSAINOV. All rights reserved.
//

import UIKit

fileprivate let inset: CGFloat = 12

class WeatherTableViewHeaderFooterView: UITableViewHeaderFooterView, CellReuseProtocol {
    typealias Model = String
    let titleView: UILabel = {
        let v = UILabel()
        v.textColor = UIColor.red
        return v
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.backgroundView?.backgroundColor = UIColor.lightGray
        self.addSubview(self.titleView)
        self.titleView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().inset(inset)
            make.bottom.equalToSuperview().inset(inset)
            make.centerX.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureForCell(model: String) {
        self.titleView.text = model
    }
}
