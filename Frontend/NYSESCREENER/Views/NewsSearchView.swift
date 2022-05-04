//
//  NewsSearchView.swift
//  NYSESCREENER
//
//  Created by roshan polasa on 5/1/22.
//



import SwiftUI

struct NewsSearchView: View {
    @StateObject var newsViewModel = newsSearchVM()
    @State var searchText: String = ""
    
    var body: some View {
        NavigationView {
            VStack{
//                Text("Searched News Results")
                HStack{
                Image(systemName: "magnifyingglass")
                TextField("Enter ticker symbol", text: $searchText)
                }
                Button{
                    Task{
                        await newsViewModel.refresh(ticker: searchText)
                    }
                } label: {
                    Text("Click to search for news")
                }
                
                List(newsViewModel.newsData, id: \.self){ item in
                    Link(item.title, destination: URL(string: item.url)!)
                }
                .animation(.default, value: newsViewModel.newsData)
            }
            .overlay{
                if newsViewModel.fetching {
                    ProgressView("Data Fetching in progress")
                        .progressViewStyle(CircularProgressViewStyle(tint: .accentColor))
                }
            }
            .navigationTitle("Search Results").padding()
        }
        //        .task {
        //            await newsViewModel.refresh(ticker: "aapl")
        //        }
        
    }
}

struct NewsSearchView_Previews: PreviewProvider {
    static var previews: some View {
        NewsSearchView()
    }
}
