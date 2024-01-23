//
//  ReuseIdentifying.swift
//  HashTag
//
//  Created by Mohamed Shendy on 02/02/2023.
//

import Foundation
protocol ReuseIdentifying {
    static var reuseIdentifier: String { get }
}

extension ReuseIdentifying {
    static var reuseIdentifier: String {
        return String(describing: Self.self)
    }
}

