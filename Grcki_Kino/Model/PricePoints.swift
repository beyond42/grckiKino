//
//  PricePoints.swift
//  GrckiKino
//
//  Created by Ivana Todorovic on 19/10/2020.
//

import Foundation

public struct PricePoints: Codable {
    public let addOn: [AddOn]
    public let amount: Double
}
