//
//  HeaderTableViewCell.swift
//  Hemita_test
//
//  Created by apple on 31/08/21.
//

import UIKit

class HeaderTableViewCell: UITableViewCell {
    
    //MARK:- Outlet connections
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
