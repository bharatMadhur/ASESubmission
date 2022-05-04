//
//  stockModel.swift
//  NYSESCREENER
//
//  Created by roshan polasa on 5/1/22.
//


import Foundation

struct stockModel: Codable, Hashable {
    
    var date: String
    var close: Double
    var high: Double
    var low: Double
    var open: Double
    var volume: Double
    var adjClose: Double
    var adjHigh: Double
    var adjLow: Double
    var adjOpen: Double
    var adjVolume: Double
    var divCash: Double
    var splitFactor: Double
//    var ticker: String
    
}
