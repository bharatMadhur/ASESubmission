//
//  FeedbackForm.swift
//  NYSESCREENER
//
//  Created by roshan polasa on 5/3/22.
//

import SwiftUI

struct FeedbackForm: View {
    @State var profileText = "Write Your Feedback"
    @State var showing = false
    var body: some View {
        NavigationView {
            VStack{
              TextEditor(text: $profileText)
                  .foregroundColor(.secondary)
                  .padding(.horizontal)
                  .navigationTitle("Contact Us").border(.gray)
            
            Button{
                let uuid = UUID().uuidString
                guard let uid = FirebaseManager.shared.auth.currentUser?.uid else{return}
                let userData = ["Feedback": self.profileText , "UID" : uid ]
                FirebaseManager.shared.firestore.collection("Feedback").document(uuid).setData(userData) { err in
                    if let err = err {
                        print(err)
                        return
                    }
                    
                    print("success")
                    showing = true
                }
            }label: {
                Text("Submit").alert("Feedback Submited", isPresented: $showing){
                    Button("Ok", role: .cancel){
                        profileText = " "
                       
                    }
            }
                
            }
           
        }.padding()
        Spacer()
    }
}
}

struct FeedbackForm_Previews: PreviewProvider {
    static var previews: some View {
        FeedbackForm()
    }
}
