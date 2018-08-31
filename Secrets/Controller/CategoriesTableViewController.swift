//
//  CategoriesTableViewController.swift
//  Secrets
//
//  Created by Marco on 31/08/2018.
//  Copyright © 2018 Vikings. All rights reserved.
//

import UIKit

class CategoriesTableViewController: UITableViewController {
    
    let categories = [
        "Nuovi",
        "Divertenti",
        "VDM",
        "ASK",
        "Amore, Amicizie",
        "Figuracce",
        "Tenerà età",
        "Imbarazzanti",
        "Sfoghi",
        "NSFW"
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return categories.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryIdentifier", for: indexPath)
        cell.textLabel?.text = categories[indexPath.row]
        return cell
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "categoriesIdentifier" {
            let homeVC = segue.destination as! HomeViewController
            let cell = sender as! UITableViewCell
            let indexPaths = self.tableView.indexPath(for: cell)
            let thisCategory = self.categories[indexPaths!.row]
            homeVC.pagina = getUrl(cat: thisCategory)
            homeVC.category = thisCategory
        }
    }
    
    private func getUrl(cat:String) -> String{
        switch cat {
        case "Nuovi":
            return "fresh"
        case "Divertenti":
            return "funny"
        case "VDM":
            return "fml"
        case "ASK":
            return "ask"
        case "Amore, Amicizie":
            return "love"
        case "Figuracce":
            return "fails"
        case "Tenerà età":
            return "tender-age"
        case "Imbarazzanti":
            return "embarassing"
        case "Sfoghi":
            return "outburst"
        case "NSFW":
            return "nsfw"
        default:
            return ""
        }
    }

}
