//
//  emailModel.swift
//  NYSESCREENER
//
//  Created by roshan polasa on 5/2/22.
//

import Foundation
import UIKit
import SwiftUI

struct EmailData {
    let recipient: String
    let subject: String
    let messageHeader: String
    let body: String
    
    
    
    func send(openURL: OpenURLAction) {
        let urlString = "mailto:\(recipient)?subject=\(subject.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? "")&body=\(body.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? "")"
        guard let url = URL(string: urlString) else { return }
        openURL(url) { accepted in
            if !accepted {
                print("""
            This device does not support email
            \(body)
            """
                )
            }
        }
    }
}
