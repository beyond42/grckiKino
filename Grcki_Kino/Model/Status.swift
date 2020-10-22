//
//  Status.swift
//  GrckiKino
//
//  Created by Ivana Todorovic on 19/10/2020.
//

import Foundation

public enum Status: String {
    case active = "active"
    case future = "future"
}

extension Status : Codable {
    public init (from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let rawStringValue = try container.decode(String.self)
        switch rawStringValue {
        case "active":
            self = .active
        case "future":
            self = .future
        default:
            self = .future
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .active:
            try container.encode("active")
        case .future:
            try container.encode("future")
        }
    }
}
