//
//  SearchTableViewController.swift
//  Secrets
//
//  Created by Marco on 01/09/2018.
//  Copyright © 2018 Vikings. All rights reserved.
//

import UIKit
import PagingTableView

class SearchTableViewController: UIViewController, UITableViewDataSource, PagingTableViewDelegate, UISearchBarDelegate {
    
    @IBOutlet weak var tableView: PagingTableView!
    //ricerca
    var resultSearchController: UISearchController?
    
    let api = API()
    var secrets: [Secret] = []
    var numero_pagina = 1
    var gender = 0
    var query = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSearch()
        
        tableView.dataSource = self
        tableView.pagingDelegate = self
        tableView.estimatedRowHeight = 44.0
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    //MARK: search
    
    private func setupSearch(){
        //Mark: search https://www.xcoding.it/creare-una-table-view-con-ricerca-in-swift/
        self.resultSearchController = ({
            
            let searchController = UISearchController(searchResultsController: nil)
            navigationItem.searchController = searchController
            navigationItem.hidesSearchBarWhenScrolling = false
            
            // rimuove la tableView di sottofondo in modo da poter successivamente visualizzare gli elementi cercati
            searchController.dimsBackgroundDuringPresentation = true
            
            // il searchResultsUpdater, ovvero colui che gestirà gli eventi di ricerca, sarà la ListaTableViewController (o self)
            //searchController.searchResultsUpdater = self
            
            // aggiungo gli scope button alla Search Bar
            searchController.searchBar.scopeButtonTitles = ["Entrambi", "Uomini", "Donne"]
            
            //mantengo navigation bar (importante)
            searchController.hidesNavigationBarDuringPresentation = true
            
            self.definesPresentationContext = true
            
            searchController.searchBar.delegate = self
            
            searchController.searchBar.placeholder = "Cerca segreti"
            
            // restituisco il controller creato
            return searchController
        })()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let scopes = resultSearchController!.searchBar.scopeButtonTitles
        let currentScope = scopes![resultSearchController!.searchBar.selectedScopeButtonIndex] as String
        query = searchBar.text!
        self.filtraContenuti(testoCercato: query, scope: currentScope)
        resultSearchController?.dismiss(animated: true, completion: nil)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        secrets = []
        tableView.reloadData()
    }
    
    private func filtraContenuti(testoCercato: String, scope: String, clearArray:Bool = true) {
        
        switch scope {
        case "Uomini":
            gender = 1
        case "Donne":
            gender = 2
        default:
            gender = 0
        }
        
        secrets = api.getSecrets(numero_pagina: numero_pagina, search: true, query: testoCercato, gender: gender)

        tableView.reloadData()
    }

    // MARK: - Table view data source
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return secrets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContentCell", for: indexPath) as? ContentTableViewCell
        
        let s = secrets[indexPath.row]
        cell?.titolo.text = s.title
        cell?.messaggio.text = s.message
        cell?.info.text = "\(s.date_time) • \(s.like) Like - \(s.dislike) dislike"

        return cell!
    }

    func paginate(_ tableView: PagingTableView, to page: Int) {
        tableView.isLoading = true
        
        numero_pagina += 1
        
        secrets += api.getSecrets(numero_pagina: numero_pagina, search: true, query: query, gender: gender)
        
        tableView.isLoading = false
    }

}
