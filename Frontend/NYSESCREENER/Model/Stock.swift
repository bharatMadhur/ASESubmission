//
//  Stock.swift
//  NYSESCREENER
//
//  Created by roshan polasa on 4/26/22.
//


import Foundation

struct Stock: Decodable, Identifiable {
    
    let id: UUID = UUID.init()
    
    let symbol: String
    let description: String
    let price: Double
    let change: String
}
