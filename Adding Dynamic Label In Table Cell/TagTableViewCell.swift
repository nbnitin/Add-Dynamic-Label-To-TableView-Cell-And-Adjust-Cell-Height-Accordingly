//
//  TagTableViewCell.swift
//  Adding Dynamic Label In Table Cell
//
//  Created by Nitin Bhatia on 23/05/18.
//  Copyright © 2018 Nitin Bhatia. All rights reserved.
//

import UIKit

class TagTableViewCell: UITableViewCell {

    @IBOutlet weak var lblTag: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
