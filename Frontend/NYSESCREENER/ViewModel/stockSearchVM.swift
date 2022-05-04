//
//  stockSearchVM.swift
//  NYSESCREENER
//
//  Created by roshan polasa on 5/2/22.
//

import SwiftUI

class stockSearchVM: ObservableObject {
    
    @Published var stockData = [stockSearchModel]()
    @Published var fetching = false
    
    public init() {}
    
    public func searchTickers(tckr: String) async -> [stockSearchModel]{
        
        let url = URL(string:"https://api.tiingo.com/tiingo/utilities/search?query=\(tckr)&token=2f7e85db1869a38072f3348bdae03512c8438e30")

        
        guard url != nil else {
            print("Error creating url object")
            return []
        }
        //URL Request
        var request = URLRequest(url: url!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
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
            let newsdata = try JSONDecoder().decode([stockSearchModel].self, from: data)
            return newsdata
        }
        catch {
            print("error")
            return []
        }
        
        
    }
    @MainActor
    func refresh(ticker: String) async {
        fetching = true
        let result = await searchTickers(tckr: ticker)
        stockData = result
        fetching = false
//        print(result)
    }
}
