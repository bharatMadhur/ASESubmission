//
//  Settings.swift
//  NYSESCREENER
//
//  Created by roshan polasa on 4/26/22.
//

import SwiftUI

struct Settings: View {
    
    @Environment(\.openURL) var openURL
    @State var tickers = ["aapl", "twtr", "msft", "tsla","goog","s","f", "rivn","fsr"]
    @ObservedObject var m = Mainview()
    @State private var showingAlert2 = false
    @State var show = false
    @State var ratings = 0
    @State var newsletter = false
    
    
    var body: some View {
        ZStack{

        VStack(alignment: .leading, spacing: nil){
            NavigationView{
                VStack(alignment: .leading, spacing: nil){
                    VStack(alignment: .leading){
                        
                        NavigationLink{
                            UpdateProfile(firstname: $m.first, lastname:$m.last, phonenumber: $m.phone, email: $m.Email)
                        }label: {
                            Text("Update Profile")
                        }.padding()
                        ///
                        Button {
                            showingAlert2 = true
                        }label: {
                            Text ("Delete Account")
                        }.alert("Conform To Delete Account", isPresented: $showingAlert2){
                            Button("Conform", role: .destructive){
                                deleteaccount()
                               
                            }
                            Button("Cancle", role: .cancel){}
                        }.padding()
                        ///
                        Button{
                        let email = EmailData(recipient: "georgekj1998@gmail.com", subject: "WatchList", messageHeader: "Here is my watchlist", body: tickers.joined(separator: ","))
                                        email.send(openURL: openURL)

                                    } label:{
                                        Text("Share Watchlist")
                                    }.padding()

                        NavigationLink{
                            FeedbackForm()
                        }label: {
                            Text("Contact Us")
                        }.padding()
                        

                        Button{
                            self.ratings = 0
                            self.show.toggle()
                           
                        }label: {
                            Text("Review App")
                        }.padding()
                        
                        HStack{
                            Text("News Letter")
                            Toggle("", isOn: $newsletter).onChange(of:newsletter){newValue in
                                
                                updatenewsletter(toggle: newValue)
                            }
                            
                        }.padding()
                        
                        Text("API : https://dry-crag-17442.herokuapp.com/search?name=aapl").padding()
                        
                        
                    }
                    Spacer()
                    
                }
                
            }
        }
            if self.show{
                
                GeometryReader{_ in
                    
                    VStack{
                        
                        FeedBack(ratings: self.$ratings, show: self.$show).padding()
                    }
                    
                }.background(Color.black.opacity(0.2).edgesIgnoringSafeArea(.all))
            }

        }
    }
    

}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings()
    }
}

func updatenewsletter(toggle : Bool){
    guard let uid = FirebaseManager.shared.auth.currentUser?.uid else{return}
    let userData = ["NewsLetter": toggle ]
    FirebaseManager.shared.firestore.collection("users").document(uid).updateData(userData) { err in
        if let err = err {
            print(err)
            return
        }
        
        print("success")
    }
    
}

