//
//  stockSearchModel.swift
//  NYSESCREENER
//
//  Created by roshan polasa on 5/2/22.
//
import Foundation

struct stockSearchModel: Codable, Hashable {
    
    var name: String
    var ticker: String
    var permaTicker: String
    var openFIGIComposite: String
    var assetType: String
    var isActive: Bool
    var countryCode: String
    
}
