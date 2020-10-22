//
//  PriceCategory.swift
//  GrckiKino
//
//  Created by Ivana Todorovic on 19/10/2020.
//

import Foundation

public struct PrizeCategory: Codable {
    public let id, divident, winners, distributed: Int
    public let jackpot: Int
    public let fixed: Double
    public let categoryType: Int
    public let gameType: PrizeCategoryGameType
}

public enum PrizeCategoryGameType: String, Codable {
    case column = "Column"
    case draw = "Draw"
    case kino = "Kino"
    case kinoBonus = "KinoBonus"
    case oddEven = "OddEven"
}

