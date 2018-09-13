//
//  ContentTableViewCell.swift
//  Secrets
//
//  Created by Marco on 31/08/2018.
//  Copyright © 2018 Vikings. All rights reserved.
//

import UIKit

class ContentTableViewCell: UITableViewCell {

    @IBOutlet weak var titolo: UILabel!
    @IBOutlet weak var messaggio: UILabel!
    @IBOutlet weak var info: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        titolo.font = UIFont.boldSystemFont(ofSize: 16.0)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
