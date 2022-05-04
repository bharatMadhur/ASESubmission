//
//  movingAverageChartView.swift
//  NYSESCREENER
//
//  Created by roshan polasa on 5/4/22.
//

import SwiftUI
import SwiftUICharts

struct movingAverageChartView: View {
    @State var points: [DataPoint] = [DataPoint]()
    @State var data: [Double]
    
    func generatePoints() {
        
        for (index, item) in data.enumerated() {
            let point: DataPoint = .init(value: item, label: "", legend: Legend(color: .green, label: ""))
            points.append(point)
            //            print(ticker)
        }
    }
    
    var body: some View {
        NavigationView {
            VStack{
                Section(header: Text("Moving Average")){
                    BarChartView(dataPoints: points)
                }
            }
            

            .task {

                generatePoints()
                //            print(points)
                
            }

        }
    }
}

//struct movingAverageChartView_Previews: PreviewProvider {
//    static var previews: some View {
//        movingAverageChartView()
//    }
//}
