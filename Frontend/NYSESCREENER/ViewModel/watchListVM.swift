//
//  watchListVM.swift
//  NYSESCREENER
//
//  Created by roshan polasa on 5/3/22.
//

import SwiftUI
import FirebaseFirestore
//import FirebaseFirestoreSwift


class watchListVM: ObservableObject {
    
    @Published var watchList = [String]()
    private var db = Firestore.firestore()
    
    
    func updateWatchList() {
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else{return}

        db.collection("users").firestore.collection("users").document(uid).updateData(["watchlist" : FieldValue.arrayUnion(watchList)])
    }
    
    
}
