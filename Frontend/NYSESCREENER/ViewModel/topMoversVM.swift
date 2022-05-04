//
//  topMoversVM.swift
//  NYSESCREENER
//
//  Created by roshan polasa on 5/2/22.
//

import Foundation

class topMoversVM : ObservableObject{
    
    @Published var moversData = [topMoversModel]()
    @Published var fetching = false
    
    public init() {}
    
    public func fetchNewsResults(type: String) async -> [topMoversModel]{
        
        let url = URL(string:"https://financialmodelingprep.com/api/v3/stock_market/\(type)?")
        ///string:"https://financialmodelingprep.com/api/v3/stock_market/\(type)?apikey=f4d3c493d808c26a4d6f1e6ff87f7be8"
        
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
            
            let moversData = try JSONDecoder().decode([topMoversModel].self, from: data)
            return moversData
        }
        catch {
            return []
        }
        
        
    }
    @MainActor
    func refresh(ticker: String) async {
        fetching = true
        let result = await fetchNewsResults(type: ticker)
        moversData = result
        fetching = false
    }
}
