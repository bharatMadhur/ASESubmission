//
//  ForgetPassword.swift
//  NYSESCREENER
//
//  Created by roshan polasa on 5/2/22.
//

import SwiftUI

struct ForgetPassword: View {
    @State var Email : String = ""
    @State private var showingAlert3 = false
    var body: some View {
        VStack{
            
            HStack{
        Text("Email Address :")
        TextField(text: $Email){

        }
            }.padding().overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color.blue, lineWidth: 4)
            )
            Button{
                resetpass()
            }label: {
                Text ("Submit")
            }.alert("Check Your Mail To Reset", isPresented: $showingAlert3){
                Button("OK", role: .cancel){}
            }
            Spacer()
        }.navigationTitle("Forgot Password")
    }
   private func resetpass(){
//       guard let uid = FirebaseManager.shared.auth.currentUser?.uid else{return}
       FirebaseManager.shared.auth.sendPasswordReset(withEmail: self.Email) { error in
         // ...
       }
       showingAlert3 = true
        
    }
}

struct ForgetPassword_Previews: PreviewProvider {
    static var previews: some View {
        ForgetPassword()
    }
}
