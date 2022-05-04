//
//  LoginPage.swift
//  NYSESCREENER
//
//  Created by roshan polasa on 4/11/22.
//

import SwiftUI
import Firebase


struct LoginPage: View {
    let didcompletedLoginProcess: () -> ()
    @State private var showingAlert = false
    
    @State private var isRecoverPassword = false
    @State private var isLoginMode = true
    @State private var email = ""
    @State private var password = ""
    @State private var Loginstatus = ""
    @State private var firstname = ""
    @State private var lastname = ""
    @State private var phonenumber = ""

    
    
    var body: some View {
        NavigationView {
            ScrollView {
                
                VStack{
                    Picker(selection: $isLoginMode, label: Text("Picker here")) {
                        Text("Login")
                            .tag(true)
                        Text("Create Account")
                            .tag(false)
                    }.pickerStyle(SegmentedPickerStyle())
                    
                    if !isLoginMode {
                        Button {
                            
                        } label: {
                            Image(systemName: "person.fill")
                                .font(.system(size: 64))
                                .padding()
                        }
                        Group{
                            TextField("First Name", text: $firstname)
                            TextField("Last Name", text: $lastname)
                            TextField("Phone Number", text: $phonenumber).keyboardType(.numberPad)
                            
                        }.padding(12)  .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color.blue, lineWidth: 4)
                        )
                        //                                .background(.white).foregroundColor(Color.black)
                    }
                    Group {
                        TextField("Email", text: $email)
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)
                        SecureField("Password", text: $password)
                        
                    }
                    .padding(12)  .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Color.blue, lineWidth: 4)
                    )
                    
                    Button {
                        handleAction()
                    } label: {
                        HStack {
                            Spacer()
                            Text(isLoginMode ? "Log In" : "Create Account")
                                .foregroundColor(.white)
                                .padding(.vertical, 10)
                                .font(.system(size: 14, weight: .semibold))
                            Spacer()
                        }.background(Color.blue)
                        
                    }.alert("\(self.Loginstatus)", isPresented: $showingAlert){
                        Button("OK", role: .cancel){}
                    }
                    //pssword recovery
                    NavigationLink{
                        ForgetPassword()
                        
                    }label: {
                        Text("Forgot Password ?")
                    }
//                    Button{
//                        isRecoverPassword.toggle()
//                        print(isRecoverPassword)
//                    }label: {
//                    Text("Forgot Password ?")
//                }
                
                
                
                //                        Text(self.Loginstatus).foregroundColor(.red)
            }
            .padding()
            
        }
        .navigationTitle(isLoginMode ? "Log In" : "Create Account")
        .background(Color(.init(white: 0, alpha: 0.05))
            .ignoresSafeArea())
    }
}

private func handleAction() {
    if isLoginMode {
        
        loginUser()
    } else {
        createNewaccount()
    }
}
private func loginUser(){
    FirebaseManager.shared.auth.signIn(withEmail: email, password: password){result ,err in
        if let err = err{
            print("failed to Login user", err)
            self.Loginstatus = "failed to login user"
            showingAlert = true
            
            return
        }
        
        print("succesfully logged in : \(result?.user.uid ?? "" )")
        
        self.Loginstatus = "succesfully logged in : \(result?.user.uid ?? "" )"
        self.didcompletedLoginProcess()
    }
}

private func createNewaccount(){
    FirebaseManager.shared.auth.createUser(withEmail: email, password: password) {
        result , err in
        if let err = err{
            print("failed to create", err)
            self.Loginstatus = "failed to create User "
            showingAlert = true
            return
        }
        
        print("succesfully created : \(result?.user.uid ?? "" )")
        
        self.Loginstatus = "succesfully created : \(result?.user.uid ?? "" )"
        
        StoreUserInformation()
        self.didcompletedLoginProcess()
    }
}

private func  StoreUserInformation(){
    guard let uid = FirebaseManager.shared.auth.currentUser?.uid else{return}
    let userData = ["email": self.email, "uid": uid ,"FirstName" : self.firstname , "LastName" : self.lastname , "PhoneNumber" : self.phonenumber , "Password" : self.password, "watchlist" :  ["RIVN","AAPL"],"flowbar" : ["RIVN","AAPL","GOOG","S","F"]] as [String : Any]
    
    FirebaseManager.shared.firestore.collection("users").document(uid).setData(userData) { err in
        if let err = err {
            print(err)
            self.Loginstatus = "\(err)"
            return
        }
        
        print("success")
    }
}
}

struct LoginPage_Previews: PreviewProvider {
    static var previews: some View {
        LoginPage(didcompletedLoginProcess: {
            
        })
    }
}


