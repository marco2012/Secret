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
        "NSFW",
        "Sesso",
        "Amore",
        "Ragazze",
        "Paura",
        "Random",
        "Classifica"
    ].sorted()

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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
            homeVC.url = getUrl(cat: thisCategory)
            homeVC.category = thisCategory
        }
    }
    
    private func getUrl(cat:String) -> String{
        switch cat {
        case "Nuovi":
            return "https://insegreto.com/it/fresh"
        case "Divertenti":
            return "https://insegreto.com/it/funny"
        case "VDM":
            return "https://insegreto.com/it/fml"
        case "ASK":
            return "https://insegreto.com/it/ask"
        case "Amore, Amicizie":
            return "https://insegreto.com/it/love"
        case "Figuracce":
            return "https://insegreto.com/it/fails"
        case "Tenerà età":
            return "https://insegreto.com/it/tender-age"
        case "Imbarazzanti":
            return "https://insegreto.com/it/embarassing"
        case "Sfoghi":
            return "https://insegreto.com/it/outburst"
        case "NSFW":
            return "https://insegreto.com/it/nsfw"
        case "Sesso":
            return "https://insegreto.com/it/tags/secrets/sesso"
        case "Amore":
            return "https://insegreto.com/it/tags/secrets/amore"
        case "Ragazze":
            return "https://insegreto.com/it/tags/secrets/ragazze"
        case "Paura":
            return "https://insegreto.com/it/tags/secrets/paura"
        case "Random":
            return "https://insegreto.com/it/random"
        case "Classifica":
            return "https://insegreto.com/it/rankings/secrets"
        default:
            return ""
        }
    }

}
