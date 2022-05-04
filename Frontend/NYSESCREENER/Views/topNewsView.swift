//
//  topNewsView.swift
//  NYSESCREENER
//
//  Created by roshan polasa on 5/2/22.
//

import SwiftUI

struct topNewsView: View {
    @StateObject var newsViewModel = newsVM()
    var body: some View {
        NavigationView {
            VStack{
                NavigationLink{
                    NewsSearchView()
                    
                }label: {
                    Text("Search").padding(.leading,300)
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
            .task {
                await newsViewModel.refresh(ticker: "")
        }
            .refreshable {
                await newsViewModel.refresh(ticker: "")
            }
            .navigationBarTitle("Top News")
        }
    }
}

struct topNewsView_Previews: PreviewProvider {
    static var previews: some View {
        topNewsView()
    }
}
