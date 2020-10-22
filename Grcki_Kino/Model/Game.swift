//
//  Game.swift
//  GrckiKino
//
//  Created by Ivana Todorovic on 19/10/2020.
//

import Foundation

public struct Game : Codable {
    public let gameId, drawId, drawTime: Int
    public let status: Status
    public let drawBreak, visualDraw: Int
    
    private enum CodingKeys: String, CodingKey {
        case gameId, drawId, drawTime, status, drawBreak, visualDraw
    }
    
    public init (from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.gameId = try! container.decodeIfPresent(Int.self, forKey: .gameId) ?? 0
        self.drawId = try! container.decodeIfPresent(Int.self, forKey: .drawId) ?? 0
        self.drawTime = try! container.decodeIfPresent(Int.self, forKey: .drawTime) ?? 0
        self.status = try! container.decodeIfPresent(Status.self, forKey: .status) ?? .future
        self.drawBreak = try! container.decodeIfPresent(Int.self, forKey: .drawBreak) ?? 0
        self.visualDraw = try! container.decodeIfPresent(Int.self, forKey: .visualDraw) ?? 0
        
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.gameId, forKey: .gameId)
        try container.encode(self.drawId, forKey: .drawId)
        try container.encode(self.drawTime, forKey: .drawTime)
        try container.encode(self.status, forKey: .status)
        try container.encode(self.drawBreak, forKey: .drawBreak)
        try container.encode(self.visualDraw, forKey: .visualDraw)
    }
}
