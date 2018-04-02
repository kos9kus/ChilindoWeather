//
//  DataExt.swift
//  Weather
//
//  Created by KONSTANTIN KUSAINOV on 22/03/2018.
//  Copyright © 2018 KONSTANTIN KUSAINOV. All rights reserved.
//

import Foundation

extension Data {
    func utfStringData() -> String? {
        return String(data: self, encoding: .utf8)
    }
}
