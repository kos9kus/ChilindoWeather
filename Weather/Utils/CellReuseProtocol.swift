//
//  CellReuseProtocol.swift
//  Weather
//
//  Created by KONSTANTIN KUSAINOV on 31/03/2018.
//  Copyright © 2018 KONSTANTIN KUSAINOV. All rights reserved.
//


protocol CellReuseProtocol {
    associatedtype Model
    func configureForCell(model: Model)
    static var cellReuseIdentifier : String {get}
}

extension CellReuseProtocol {
    static var cellReuseIdentifier: String {
        return String(describing: Self.self)
    }
}
