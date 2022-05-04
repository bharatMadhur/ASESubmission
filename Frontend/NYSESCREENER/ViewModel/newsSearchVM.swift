//
//  newsSearchVM.swift
//  NYSESCREENER
//
//  Created by roshan polasa on 5/2/22.
//

import Foundation


class newsSearchVM : ObservableObject{
    
    @Published var newsData = [newsModel]()
    @Published var fetching = false
    
    public init() {}
    
    public func fetchNewsResults(tckr: String) async -> [newsModel]{
        
        let url = URL(string:"https://api.tiingo.com/tiingo/news?tickers=\(tckr)&tags=Tiingo+Top&limit=25&token=2f7e85db1869a38072f3348bdae03512c8438e30")
        
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
            
            let newsdata = try JSONDecoder().decode([newsModel].self, from: data)
            return newsdata
        }
        catch {
            return []
        }
        
        
    }
    @MainActor
    func refresh(ticker: String) async {
        fetching = true
        let result = await fetchNewsResults(tckr: ticker)
        newsData = result
        fetching = false
    }
}
