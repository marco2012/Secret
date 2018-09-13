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
    var comments_url : String
    var sesso : String
    var like: Int
    var dislike: Int

    init(title : String, message : String, date_time : String, comments_url:String, like_dislike:String) {
        self.title  = title
        self.message  = message
        self.date_time  = date_time
        self.comments_url = comments_url
        
        let index = title.index(title.startIndex, offsetBy: 5)
        self.sesso = String( title.substring(to: index).trimmingCharacters(in: .whitespaces) )
        
        self.like = Int(like_dislike.split(separator: " ")[0])!
        self.dislike = Int(like_dislike.split(separator: " ")[1])!
    }
    
}
