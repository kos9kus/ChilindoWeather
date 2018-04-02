//
//  UIViewExt.swift
//  Weather
//
//  Created by KONSTANTIN KUSAINOV on 01/04/2018.
//  Copyright © 2018 KONSTANTIN KUSAINOV. All rights reserved.
//

import UIKit

extension UIView {
    
    func rotate(degrees: Double) {
        let radians = Measurement(value: degrees, unit: UnitAngle.degrees).converted(to: .radians).value
        self.transform = CGAffineTransform(rotationAngle: CGFloat(radians));
    }
}
