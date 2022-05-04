//
//  newsModel.swift
//  NYSESCREENER
//
//  Created by roshan polasa on 5/1/22.
//

import Foundation


import Foundation

struct newsModel: Codable, Hashable {
    
    var publishedDate: String
    var source: String
    var tags: [String]
    var tickers: [String]
    var url: String
    var description: String
    var title: String
    var crawlDate: String
    var id: Int
    
}
