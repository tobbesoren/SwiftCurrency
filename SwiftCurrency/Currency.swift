//
//  Currency.swift
//  SwiftCurrency
//
//  Created by Tobias Sörensson on 2023-04-14.
//

import Foundation

//I should remove Currencys and just download the symbols from fixer. Also, it makes no sense to have the Currency struct when it only handles the symbols. An array will do.
struct Currency: Hashable, Codable {
    var countryCode: String
    var euroRate: Double
    var updated: Date?
}
