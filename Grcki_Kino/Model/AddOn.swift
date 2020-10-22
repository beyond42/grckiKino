//
//  AddOn.swift
//  GrckiKino
//
//  Created by Ivana Todorovic on 19/10/2020.
//

import Foundation

public struct AddOn: Codable {
    let amount: Double
    let gameType: AddOnGameType
}

enum AddOnGameType: String, Codable {
    case kinoBonus = "KinoBonus"
    case sideBets = "SideBets"
}
