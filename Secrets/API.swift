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
    func getSecrets(pagina:String, numero_pagina:Int) -> [Secret] {
        
        var secrets: [Secret] = []

        let link = "https://insegreto.com/it/\(pagina)?page=\(numero_pagina)"
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
            
                secrets.append(Secret(title: t, message: m, date_time: i))
            }
            
        } catch let error {
            // an error occurred
            print("Error: \(error)")
        }
        
        return secrets
    }
    
    
}
