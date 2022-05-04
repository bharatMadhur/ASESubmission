//
//  topMoverModel.swift
//  NYSESCREENER
//
//  Created by roshan polasa on 5/2/22.
//


import Foundation

struct topMoversModel: Codable, Hashable {
    
    var symbol: String
    var name: String
    var change: Double
    var price: Double
    var changesPercentage: Double
}
