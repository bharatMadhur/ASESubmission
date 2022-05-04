//
//  UpdateProfile.swift
//  NYSESCREENER
//
//  Created by roshan polasa on 5/1/22.
//

import SwiftUI

struct UpdateProfile: View {
    //    @State var first : String
    //    @ObservedObject private var m = Mainview()
    @State private var showingAlert1 = false
    @State private var Loginstatus1 = ""
    @Binding var firstname : String
    @Binding var lastname : String
    @Binding var phonenumber : String
    @Binding var email : String
    var body: some View {
        VStack(alignment: .leading, spacing: nil){
            HStack{
                Text("FIRST NAME : ").padding()
                TextField(text: $firstname, prompt: Text("\(firstname)")){
                    
                    
                }.textFieldStyle(.roundedBorder).padding()
            }
            HStack{
                Text("Last NAME : ").padding()
                TextField(text: $lastname, prompt: Text("\(lastname)")){
                    
                    
                }.textFieldStyle(.roundedBorder).padding()
                Spacer()
            }
            HStack{
                Text("Phone Number : ").padding()
                TextField(text: $phonenumber, prompt: Text("\(phonenumber)")){
                    
                    
                }.textFieldStyle(.roundedBorder).padding()
            }
            HStack{
                Text("Email : ").padding()
                TextField(text: $email, prompt: Text("\(email)")){
                    
                    
                }.textFieldStyle(.roundedBorder).padding().disabled(true)
            }
            
            Spacer()
            
            
        }
        Button{
            updatedata()
            
        }label: {
            Text("Update Profile")
        }.alert("\(self.Loginstatus1)", isPresented: $showingAlert1){
            Button("OK", role: .cancel){}
        }
        Spacer()
        
    }
    
    private func  updatedata(){
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else{return}
        let userData1 = ["FirstName" : self.firstname , "LastName" : self.lastname , "PhoneNumber" : self.phonenumber ]
        
        FirebaseManager.shared.firestore.collection("users").document(uid).updateData(userData1) { err in
            if let err = err {
                print(err)
                self.Loginstatus1 = "Failed to Update"
                return
            }
            
            self.Loginstatus1 = "Updated Profile"
            showingAlert1 = true
        }
    }
    
}



struct UpdateProfile_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
