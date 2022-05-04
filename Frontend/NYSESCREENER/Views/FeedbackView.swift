//
//  FeedbackView\.swift
//  NYSESCREENER
//
//  Created by roshan polasa on 5/2/22.
//

import Foundation
import SwiftUI

struct FeedBack : View {
    
    @Binding var ratings : Int
    @Binding var show : Bool
    
    var body : some View{
        
        VStack{
            
            HStack{
                
                Text("Please Rate The Quality Of The Product").fontWeight(.bold).foregroundColor(.white)
                
                Spacer()
                
            }.padding()
            .background(Color.blue)
            
            VStack{
                
                if self.ratings != 0{
                    
                    if self.ratings == 5{
                        
                        Text("Excellent").fontWeight(.bold).foregroundColor(.green)
                    }
                    else if self.ratings == 4 {
                        
                        Text("Good").fontWeight(.bold).foregroundColor(.green)
                    }
                    else{
                        
                        Text("Okay").fontWeight(.bold).foregroundColor(.green)
                    }
                }
                
            }.padding(.top, 20)
            
            HStack(spacing: 15){
                
                ForEach(1...5,id: \.self){i in
                    
                    Image(systemName: self.ratings == 0 ? "star" : "star.fill")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .foregroundColor(i <= self.ratings ? .green : Color.black.opacity(0.2))
                        .onTapGesture {
                            
                            self.ratings = i
                    }
                }
                
            }.padding()
            
            HStack{
                
                Spacer()
                
                Button(action: {
                    
                    self.ratings = 0
                    self.show.toggle()
                    
                }) {
                    
                    Text("Cancel").foregroundColor(.gray).fontWeight(.bold)
                }
                
                Button(action: {
                    
                    self.show.toggle()
                    feedback(review: String(self.ratings))
                }) {
                    
                    Text("Submit").foregroundColor(self.ratings != 0 ? .green : Color.black.opacity(0.2)).fontWeight(.bold)
                    
                }.padding(.leading, 20)
                .disabled(self.ratings != 0 ? false : true)
                
            }.padding()
            
        }
        .background(Color.white)
        .cornerRadius(10)
    }
}

private func feedback(review : String){
    
    guard let uid = FirebaseManager.shared.auth.currentUser?.uid else{return}
    let userData = ["Review": review ]
    FirebaseManager.shared.firestore.collection("Review").document(uid).setData(userData) { err in
        if let err = err {
            print(err)
            return
        }
        
        print("success")
    }
    
}
