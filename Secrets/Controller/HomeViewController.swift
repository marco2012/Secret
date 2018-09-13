//
//  HomeTableViewController.swift
//  Secrets
//
//  Created by Marco on 31/08/2018.
//  Copyright © 2018 Vikings. All rights reserved.
//

import UIKit
import PagingTableView

class HomeViewController:  UIViewController, UITableViewDataSource, PagingTableViewDelegate {
    
    @IBOutlet weak var contentTable: PagingTableView!
    @IBOutlet weak var mySegment: UISegmentedControl!
    
    let api = API()
    var secrets: [Secret] = []
    var uominiSecrets: [Secret] = []
    var donneSecrets: [Secret] = []
    var numero_pagina = 1
    
    var url:String = "https://insegreto.com/it"
    var category:String = "Popolari"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        secrets = api.getSecrets(link: url, numero_pagina: numero_pagina)
        
        contentTable.dataSource = self
        contentTable.pagingDelegate = self
        contentTable.estimatedRowHeight = 44.0
        contentTable.rowHeight = UITableView.automaticDimension
        
        title = category //navigation bar
    }
    

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch mySegment.selectedSegmentIndex {
        case 1:
            return uominiSecrets.count
        case 2:
            return donneSecrets.count
        default:
            return secrets.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContentCell", for: indexPath) as? ContentTableViewCell
        
        var data:[Secret]
        switch mySegment.selectedSegmentIndex {
        case 1:
            data=uominiSecrets
        case 2:
            data=donneSecrets
        default:
            data = secrets
        }
        
        let s = data[indexPath.row]
        cell?.titolo.text = s.title
        cell?.messaggio.text = s.message
        cell?.info.text = "\(s.like) Like - \(s.dislike) dislike • \(s.date_time)"
        
        return cell!
    }
    
    func paginate(_ tableView: PagingTableView, to page: Int) {
        contentTable.isLoading = true
        
        numero_pagina += 1
        
        switch mySegment.selectedSegmentIndex {
        case 1:
            uominiSecrets += api.getSecrets(link: url, numero_pagina: numero_pagina).filter { $0.sesso == "Uomo" }
        case 2:
            donneSecrets += api.getSecrets(link: url, numero_pagina: numero_pagina).filter { $0.sesso == "Donna" }
        default:
            secrets += api.getSecrets(link: url, numero_pagina: numero_pagina)
        }
        
        contentTable.isLoading = false
    }

    @IBAction func sessoSegment(_ sender: UISegmentedControl) {
        switch mySegment.selectedSegmentIndex {
        case 1:
            uominiSecrets = secrets.filter { $0.sesso == "Uomo" }
        case 2:
            donneSecrets = secrets.filter { $0.sesso == "Donna" }
        default:
            break
        }
        contentTable.reloadData()
    }
    
  
    
}
