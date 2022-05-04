//
//  stockListModel.swift
//  NYSESCREENER
//
//  Created by roshan polasa on 5/1/22.
//

import Foundation
//{'quoteTimestamp': '2022-04-29T20:00:00+00:00', 'last': 412.0, 'bidSize': None, 'lastSaleTimestamp': '2022-04-29T20:00:00+00:00', 'lastSize': None, 'volume': 145491088, 'mid': None, 'bidPrice': None, 'ticker': 'SPY', 'high': 425.87, 'askSize': None, 'tngoLast': 412.0, 'prevClose': 427.81, 'timestamp': '2022-04-29T20:00:00+00:00', 'askPrice': None, 'open': 423.59, 'low': 411.21}


struct stockListModel: Codable, Hashable {
    
    var quoteTimestamp: String?
    var last: Double?
    var bidSize: Double?
    var lastSaleTimestamp: String?
    var lastSize: Double?
    var volume: Double?
    var mid: Double?
    var bidPrice: Double?
    var ticker: String?
    var high: Double?
    var askSize: Double?
    var tngoLast: Double?
    var prevClose: Double?
    var timestamp: String?
    var askPrice: Double?
    var open: Double?
    var low: Double?
    
}

