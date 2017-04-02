//
//  PetTableViewCell.swift
//  PawPrint
//
//  Created by Rachael on 4/1/17.
//  Copyright © 2017 Rachael. All rights reserved.
//

import UIKit

class PetTableViewCell: UITableViewCell {

    @IBOutlet weak var petImage: UIImageView!
    @IBOutlet weak var petName: UILabel!
    @IBOutlet weak var petBreedAnimal: UILabel!
    @IBOutlet weak var petAnimal: UILabel!
    
    public var petShown:Pet!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
      
    }

}
