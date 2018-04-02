//
//  WeatherDayTableViewCell.swift
//  Weather
//
//  Created by KONSTANTIN KUSAINOV on 31/03/2018.
//  Copyright © 2018 KONSTANTIN KUSAINOV. All rights reserved.
//

import UIKit
import SnapKit

fileprivate let kVInset = 18
fileprivate let kHInset = 8

class WeatherDayTableViewCell: UITableViewCell, CellReuseProtocol {
    
    typealias Model = TodayViewModel
    let titleLabel = UILabel()
    let valueTitleLabel = UILabel()
    let imageIcon: UIImageView = {
        let v = UIImageView(image: UIImage(named: "Arrow"))
        v.isHidden = true
        v.snp.makeConstraints({ (make) in
            let size = 35
            make.size.equalTo(CGSize(width: size, height: size))
        })
        return v;
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(valueTitleLabel)
        self.contentView.addSubview(imageIcon)
        self.titleLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().inset(kHInset)
            make.top.equalToSuperview().inset(kVInset)
            make.bottom.equalToSuperview().inset(kVInset)
            make.right.equalTo(self.valueTitleLabel.snp.left)
        }
        self.valueTitleLabel.snp.makeConstraints { (make) in
            make.right.equalToSuperview().inset(kHInset)
            make.centerY.equalTo(self.titleLabel.snp.centerY)
        }
        self.imageIcon.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.titleLabel)
            make.right.equalToSuperview().inset(kHInset)
        }
        self.titleLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.imageIcon.isHidden = true
        self.valueTitleLabel.isHidden = true
    }
    
    func configureForCell(model: TodayViewModel) {
        self.titleLabel.text = model.type.rawValue
        
        if model.type == .WindDirection {
            self.imageIcon.isHidden = false
            self.imageIcon.rotate(degrees: model.value as! Double)
        } else {
            self.valueTitleLabel.isHidden = false
            self.valueTitleLabel.text = model.value as? String
        }
    }
}
