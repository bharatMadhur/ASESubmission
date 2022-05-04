//
//  advStatsView.swift
//  NYSESCREENER
//
//  Created by roshan polasa on 5/4/22.
//
//
//import SwiftUI
//
//struct advStatsView: View {
//    @ObservedObject var advstats = advStatsVM()
//    @State var tckr: String
//    var body: some View {
//        NavigationView{
//            List(advstats.stockData, id: \.self){ item in
//                Text(item.ticker ?? "")
//            }
//            .navigationTitle("Advanced Stats")
//            .overlay{
//                if advstats.fetching {
//                    ProgressView("Data Fetching in progress")
//                        .progressViewStyle(CircularProgressViewStyle(tint: .accentColor))
//                }
//            }
//            .task{
//                await advstats.refresh(ticker: tckr)
//            }
//
//        }
//    }
//}
//
//struct advStatsView_Previews: PreviewProvider {
//    static var previews: some View {
//        advStatsView(tckr: "aapl")
//    }
//}


import SwiftUI

struct displaySWOT: View {
    
    @State var Strengths: [String]
    @State var Weakness: [String]
    @State var Oppurtunities: [String]
    @State var Threats: [String]
    
    var body: some View {
        
                List{
        Section(header: Text("Strengths : ")){

            ForEach(Strengths, id:\.self){item in
                Text(String(item))
            }
        }
        }
        Spacer()

        
        List{
Section(header: Text("Weakness : ")){

            ForEach(Weakness, id:\.self){item in
                Text(String(item))
                }
         
        }
        }
        Spacer()
//        Text("Oppurtunities : ")
//        List{
        List{
Section(header: Text("Oppurtunities : ")){
            ForEach(Oppurtunities, id:\.self){item in
                Text(String(item))
            }
    
}
        }
        Spacer()
        List{
Section(header: Text("Threat : ")){
    
            ForEach(Threats, id:\.self){item in
                Text(String(item))
            }
        }
        }
        Spacer()
    }
}






struct advStatsView : View {
    
    @StateObject var advStatsViewModel = advStatsVM()
    @State var ticker: String
    
    
    var body: some View {
        NavigationView {
            VStack{
                List(advStatsViewModel.stockData, id: \.self){ item in
                    Text("Stock Name : \(item.ticker!) ")
    
                    NavigationLink(destination: displaySWOT(Strengths: item.Strength!, Weakness: item.Weakness!, Oppurtunities: item.Opportunity!, Threats: item.Threat!)){
                        Text("Display SWOT Analysis")
                    }
                    
                    Text("Recommendation : \(item.Recommendation!)")
                    Text("Sentimental : \(item.Sentimental!)")
                    Text("Risk : \(item.RisK!)")
                    Text("Fundamental : \(item.fundamental!)")
                    Text("Technical : \(item.Technical!)")
                    VStack{
                        Text("CURRENT PIVOT")
                        HStack{
                            VStack{
                                Text("S1 :\(item.S1!)")
                                Text("S2 :\(item.S2!)")
                                Text("S3 :\(item.S3!)")
                            }
                            VStack{
                                Text("R1 :\(item.R1!)")
                                Text("R2 :\(item.R2!)")
                                Text("R3 :\(item.R3!)")
                            }
                        }
                    }
                    NavigationLink(destination: movingAverageChartView(data: item.ChartMovingAverage!)){
                        Text("View Moving Average Chart")
                    }
                    
                }
                .animation(.default, value: advStatsViewModel.stockData)
            }
            .overlay{
                if advStatsViewModel.fetching {
                    ProgressView("Data Fetching in progress")
                        .progressViewStyle(CircularProgressViewStyle(tint: .accentColor))
                }
            }
            .task {
                await advStatsViewModel.refresh(ticker: self.ticker)
            }
            .refreshable {
                await advStatsViewModel.refresh(ticker: self.ticker)
            }
            .navigationBarTitle("Advanced Stock Details")
        }
    }
}

struct advStatsView_Previews: PreviewProvider {
    static var previews: some View {
        advStatsView(ticker: "tsla")
    }
}
