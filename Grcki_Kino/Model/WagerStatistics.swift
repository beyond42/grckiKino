//
//  WagerStatistics.swift
//  GrckiKino
//
//  Created by Ivana Todorovic on 19/10/2020.
//

import Foundation

public struct WagerStatistics: Codable {
    public let columns, wagers: Int
    public let addOn: [AddOn]
}
