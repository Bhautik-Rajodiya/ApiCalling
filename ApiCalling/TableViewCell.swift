//
//  TableViewCell.swift
//  ApiCalling
//
//  Created by Bhautik Rajodiya on 11/11/22.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var lable2: UILabel!
    @IBOutlet weak var lable3: UILabel!
    @IBOutlet weak var image1: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
