//
//  HomeVM.swift
//  NYSESCREENER
//
//  Created by roshan polasa on 4/12/22.
//

import Foundation


class Mainview: ObservableObject{
    @Published var errorMessage = ""
    @Published var Email = ""
    @Published var first = ""
    @Published var last = ""
    @Published var phone = ""
    @Published var watchList = [String]()
    @Published var flowbar = [String]()
    init(){
        DispatchQueue.main.async {
            self.isUserCurrentlyLoggedOut = FirebaseManager.shared.auth.currentUser?.uid == nil
        }
       
        fetchCurrentuser()
    }
    
     func fetchCurrentuser() {
    
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else{return}
        FirebaseManager.shared.firestore.collection("users").document(uid).addSnapshotListener { snapshot, error in
                   if let error = error {
                       self.errorMessage = "Failed to fetch current user: \(error)"
                       print("Failed to fetch current user:", error)
                       return
                   }

                   guard let data = snapshot?.data() else {
                       self.errorMessage = "No data found"
                       
                       return

                   }
            let uid = data["uid"] as? String ?? ""
            let email = data["email"] as? String ?? ""
            let First = data["FirstName"] as? String ?? ""
            let last = data["LastName"] as? String ?? ""
            let Phone = data["PhoneNumber"] as? String ?? ""
//            let watchlist = data["]
            let watchList = data["watchlist"] as? [String] ?? [String]()
            let flowbar = data["flowbar"] as? [String] ?? [String]()
            
            let mainuser = Mainuser(uid: uid , email : email, first: First , last: last , phone: Phone, watchList: watchList, flowbar: flowbar)
            self.Email = mainuser.email
            self.first = mainuser.first
            self.last = mainuser.last
            self.phone = mainuser.phone
            self.watchList = mainuser.watchList
            self.flowbar = mainuser.flowbar
//            self.errorMessage = mainuser.email
//            
//            print(data)
        
    }
    
}
    @Published var isUserCurrentlyLoggedOut = false
    func handlesignout(){
        isUserCurrentlyLoggedOut.toggle()
        try? FirebaseManager.shared.auth.signOut()
        
    }
}
