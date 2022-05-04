//
//  StockSearchiew.swift
//  NYSESCREENER
//
//  Created by roshan polasa on 5/2/22.
//


import SwiftUI

struct stockSearchView: View {
    
    @StateObject var stockSearchViewModel = stockSearchVM()
    @State var searchString: String = ""
    
    var body: some View {
        VStack{
            HStack{
            Image(systemName: "magnifyingglass")
            TextField("Enter Search term", text: $searchString)
            }
            Button{
                Task{
                    await stockSearchViewModel.refresh(ticker: searchString)
                }
            } label: {
                Text("Search")
            }
            NavigationView {
                List(stockSearchViewModel.stockData, id: \.self){ item in
                    //                    NavigationLink(destination: Text(item.ticker!)){
                    NavigationLink(destination: StockDetailView(tckr:item.ticker)){
                        HStack{
                            Text(item.name)
                            Text(item.ticker)
                        }
                    }
                    
                }
                .animation(.default, value: stockSearchViewModel.stockData)
            }
        }.padding()
    }
}

struct stockSearchView_Previews: PreviewProvider {
    static var previews: some View {
        stockSearchView()
    }
}
