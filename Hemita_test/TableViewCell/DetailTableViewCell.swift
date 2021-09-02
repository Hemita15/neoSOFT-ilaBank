//
//  DetailTableViewCell.swift
//  Hemita_test
//
//  Created by apple on 30/08/21.
//

import UIKit

class DetailTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblText: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
