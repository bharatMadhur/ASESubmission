//
//  StockDetailView.swift
//  NYSESCREENER
//
//  Created by roshan polasa on 5/1/22.
//

import SwiftUI
import FirebaseFirestore
struct StockDetailView: View {
    @State var tckr: String
    @StateObject var stockDetailViewModel = stockDetailVM()
    @StateObject var advStatsViewModel = advStatsVM()
    @ObservedObject var vm = Mainview()
    
    var body: some View {
        VStack{
            HStack{
                Text("\(tckr) Details").padding()
                Spacer()
                VStack{
                HStack{
                    HStack{
                    Text("WatchList")
                Button{
                    addwatchlist(tcker: tckr)
                }label: {
                    Text("+").shadow(color: Color.blue, radius: 20, y: 5).frame(width: 15.0, height: 32.0)
                }
                Button{
                    removewatchlist(tcker: tckr)
                }label:{
                    Text("-").shadow(color: Color.blue, radius: 20, y: 5).frame(width: 15.0, height: 32.0)
                }.padding()
                    }
                    
            }.padding()
                    
                    
            }
                
                
            }.padding(.top,-50)
            VStack{
                chartView(ticker: $tckr)
            }
            VStack{
            List(stockDetailViewModel.stockData, id: \.self){ item in
                VStack(alignment: .leading, spacing: nil){
                    HStack{
                        Spacer()
                        Text("Open")
                        Spacer()
                        Text(String(item.open))
                        Spacer()
                    }
                    Spacer()
                    HStack{
                        Spacer()
                        Text("Close")
                        Spacer()
                        Text(String(item.close))
                        Spacer()
                    }
                    Spacer()
                    HStack{
                        Spacer()
                        Text("High")
                        Spacer()
                        Text(String(item.high))
                        Spacer()
                    }
                    Spacer()
                    HStack{
                        Spacer()
                        Text("Low")
                        Spacer()
                        Text(String(item.low))
                        Spacer()
                    }
                }
 

            }
            }
            Spacer()
            HStack{
                NavigationLink{
                    advStatsView(ticker: tckr)
                }label: {
                    Text("Advance Stats")
                }
Spacer()
            NavigationLink{
                BarGrapView(ticker: $tckr)
            }label: {
                Text("Bar Graph")
            }
            }
            VStack{
                    HStack{
                        HStack{
                        Text("Add To Flow Bar")
                    Button{
                        addflowbar(tcker: tckr)
                    }label: {
                        Text("Add")
                    }
                    Button{
                        removeflowbar(tcker: tckr)
                    }label:{
                        Text("Remove")
                    }.padding()
                        }
            
                }.padding()
            
            
                }
            
          
                
                
            }
            .animation(.default, value: stockDetailViewModel.stockData)
        
        .overlay{
            if stockDetailViewModel.fetching {
                ProgressView("Data Fetching in progress")
                    .progressViewStyle(CircularProgressViewStyle(tint: .accentColor))
            }
        }
        .task {
            await stockDetailViewModel.refresh(ticker: tckr)
        }

        
    }
}


func addwatchlist(tcker : String){
       var db = Firestore.firestore()
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else{return}
    db.collection("users").firestore.collection("users").document(uid).updateData(["watchlist" : FieldValue.arrayUnion([tcker])])
    
}

func removewatchlist(tcker : String){
       var db = Firestore.firestore()
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else{return}
    db.collection("users").firestore.collection("users").document(uid).updateData(["watchlist" : FieldValue.arrayRemove([tcker])])
    
}

func addflowbar(tcker : String){
       var db = Firestore.firestore()
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else{return}
    db.collection("users").firestore.collection("users").document(uid).updateData(["flowbar" : FieldValue.arrayUnion([tcker])])
    
}

func removeflowbar(tcker : String){
       var db = Firestore.firestore()
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else{return}
    db.collection("users").firestore.collection("users").document(uid).updateData(["flowbar" : FieldValue.arrayRemove([tcker])])
    
}



struct StockDetailView_Previews: PreviewProvider {
    static var previews: some View {
        StockDetailView(tckr: "aapl")
    }
}

//func fetchWatchList(wat) {
//    
////    @Published var watchList = [String]()
//    var db = Firestore.firestore()
//    guard let uid = FirebaseManager.shared.auth.currentUser?.uid else{return}
//
//    db.collection("users").firestore.collection("users").document(uid).updateData(["watchlist" : FieldValue.arrayUnion(watchList)])
//}

