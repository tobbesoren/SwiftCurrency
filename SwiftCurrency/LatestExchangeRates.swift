//
//  latestExchangeRates.swift
//  SwiftCurrency
//
//  Created by Tobias Sörensson on 2023-04-16.
//

import Foundation

struct LatestExchangeRates: Codable {
    
    let success: Bool
    let timestamp: Int?
    let base: String?
    let date: String?
    let rates: [String: Double]?
}
