//
//  MovieCell.swift
//  Book
//
//  Created by 503-14 on 2018. 11. 26..
//  Copyright © 2018년 503-14. All rights reserved.
//

import UIKit

class SearchCell: UITableViewCell {

    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblWriter: UILabel!
    @IBOutlet weak var thumbnailImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

}
