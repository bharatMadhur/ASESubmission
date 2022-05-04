//
//  APIManager.swift
//  NYSESCREENER
//
//  Created by roshan polasa on 4/26/22.
//


import Foundation


class APIManager {
    
    func getStocks(for urlString: String, completion: @escaping (([Stock]?, Error?) -> Void)) {
        
        guard let url = URL(string: urlString) else {
            fatalError("URL is not correct")
        }
        
        URLSession.shared.dataTask(with: url){ data, responce, error in
            
            guard let data = data, error == nil else {
                completion(nil,error)
                return
            }
            
            let stocks = try? JSONDecoder().decode([Stock].self, from: data)
            if stocks == nil{
                completion(nil,nil)
            }else{
                completion(stocks,nil)
            }
        }.resume()
        
    }
}
