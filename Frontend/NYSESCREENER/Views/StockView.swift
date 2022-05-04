//
//  StockView.swift
//  NYSESCREENER
//
//  Created by roshan polasa on 4/26/22.
//

import SwiftUI
import SwiftUICharts


struct StockView: View {
    var body: some View {
        NavigationView{
            ScrollView{
                VStack{
                    let apple  = Legend(color: .green, label: "Apple")
                    let points: [DataPoint] = [
                        .init(value: 2, label: "2", legend: apple),
                        .init(value: 4, label: "4", legend: apple),
                        .init(value: 6, label: "6", legend: apple),
                        .init(value: 7, label: "7", legend: apple),
                        .init(value: 1, label: "1", legend: apple),
                        .init(value: 100, label: "100", legend: apple),
                        .init(value: 45, label: "45", legend: apple),
                    ]
                    
                    LineChartView(dataPoints: points)
                }
            }
        }
    }
}

struct StockView_Previews: PreviewProvider {
    static var previews: some View {
        StockView()
    }
}
