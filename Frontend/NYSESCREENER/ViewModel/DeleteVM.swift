//
//  DeleteVM.swift
//  NYSESCREENER
//
//  Created by roshan polasa on 5/2/22.
//

import Foundation

func deleteaccount() {
    let user = FirebaseManager.shared.auth.currentUser
    
//        let uid = FirebaseManager.shared.auth.currentUser?.uid
    user?.delete{ error in
        if error != nil {
          // An error happened.
        } else {
          print("deleted")
            exit(0)
        }
      }
//        print(uid as Any)
    
}
