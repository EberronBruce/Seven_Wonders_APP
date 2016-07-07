//
//  WonderCell.swift
//  Seven Wonders
//
//  Created by Bruce Burgess on 7/6/16.
//  Copyright © 2016 Red Raven Computing Studios. All rights reserved.
//

/*
 This class is used to create a custom cell for the table view.
 
 */

import UIKit

class WonderCell: UITableViewCell {
    @IBOutlet weak var woderImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var materialView: MaterialView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        woderImage.layer.cornerRadius = woderImage.frame.width / 2
        woderImage.clipsToBounds = true
    }

    //Mark: - This function is used to populate the cell with a title and an image
    func updateCell(title: String, image: UIImage){
        self.titleLabel.text = title
        self.woderImage.image = image
    }

}
