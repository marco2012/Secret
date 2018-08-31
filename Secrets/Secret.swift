//
//  Secret.swift
//  Secrets
//
//  Created by Marco on 31/08/2018.
//  Copyright © 2018 Vikings. All rights reserved.
//

import Foundation

class Secret {
    
    var title : String
    var message : String
    var date_time : String
    var sesso : String

    init(title : String, message : String, date_time : String) {
        self.title  = title
        self.message  = message
        self.date_time  = date_time
        
        let index = title.index(title.startIndex, offsetBy: 5)
        self.sesso = String( title.substring(to: index).trimmingCharacters(in: .whitespaces) )
    }
    
}
