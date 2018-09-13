//
//  API.swift
//  Secrets
//
//  Created by Marco on 31/08/2018.
//  Copyright © 2018 Vikings. All rights reserved.
//

import Foundation
import SwiftSoup

class API {
    
    // current document
    var document: Document = Document.init("")
    
    //Download HTML
    func getSecrets(link:String="", numero_pagina:Int, search:Bool=false, query:String="", gender:Int=0) -> [Secret] {
        
        var secrets: [Secret] = []

        var link = "\(link)?page=\(numero_pagina)"
        if search {
            link = "https://insegreto.com/it/search?query=\(query)&partial=1&age_from=13&age_to=70&gender=\(gender)&page=\(numero_pagina)"
        }
        let url = URL(string: link)
        
        do {
            // content of url
            let html = try String.init(contentsOf: url!)
            // parse it into a Document
            document = try SwiftSoup.parse(html)
            // parse css query
        
            // firn css selector
            let articles: Elements = try document.select("article")
            //transform it into a local object (Item)
            for article in articles {
            
                let title: Elements = try article.select(".secret__head > .secret__title")
                let t = try title.text()
            
                let message: Elements = try article.select(".secret__message")
                let m = try message.text()
            
                let info: Elements = try article.select(".secret__info > .secret__date > .secret__date--full")
                let i = try info.text()
                
                let comments_url: Elements = try article.select(".secret__foot > .secret__actions-secondary > .secret__button")
                let c = try comments_url.attr("href")
                
                let like_dislike: Elements = try article.select(".secret__foot > .secret__actions-primary")
                let l = try like_dislike.text()
            
                secrets.append(Secret(title: t, message: m, date_time: i, comments_url: c, like_dislike: l))
            }
            
        } catch let error {
            // an error occurred
            print("Error: \(error)")
        }
        
        return secrets
    }
    
    
}
