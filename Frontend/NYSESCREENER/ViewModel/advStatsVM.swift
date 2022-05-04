//
//  advStatsVM.swift
//  NYSESCREENER
//
//  Created by roshan polasa on 5/4/22.
//

import Foundation

import SwiftUI

class advStatsVM: ObservableObject {
    
    @Published var stockData = [advStatsModel]()
    @Published var fetching = false
    
    
    public init() {}
    
    public func fetchStockPrice(tckr: String) async -> [advStatsModel]{
        
        let url = URL(string:"https://dry-crag-17442.herokuapp.com/search?name=\(tckr)")

        
        guard url != nil else {
            print("Error creating url object")
            return []
        }
        //URL Request
        var request = URLRequest(url: url!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 30.0)
        let headers = [
            "Content-Type": "application/json"
        ]
        
        request.allHTTPHeaderFields = headers
        request.httpMethod = "GET"
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                print("URL response error")
                return []
            }
//            print(data)
            let newsdata = try JSONDecoder().decode(advStatsModel.self, from: data)
            print(newsdata)
            return [newsdata]
        }
        catch {
            print(error)
            return []
        }
        
        
    }
    @MainActor
    func refresh(ticker: String) async {
        fetching = true
        let result = await fetchStockPrice(tckr: ticker)
        stockData = result
        fetching = false
//        print(result)
    }
}
