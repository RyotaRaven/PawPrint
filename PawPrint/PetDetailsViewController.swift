//
//  PetDetailsViewController.swift
//  PawPrint
//
//  Created by Rachael on 4/1/17.
//  Copyright © 2017 Rachael. All rights reserved.
//

import UIKit

class PetDetailsViewController: UIViewController {
    
    public var petToDetail:Pet!

    @IBOutlet weak var petShelter: UILabel!
    @IBOutlet weak var petImage: UIImageView!
    @IBOutlet weak var petName: UILabel!
    @IBOutlet weak var petSex: UILabel!
    @IBOutlet weak var petAge: UILabel!
    @IBOutlet weak var petBreed: UILabel!
    @IBOutlet weak var petSize: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        petImage.layer.cornerRadius = 10
        petImage.layer.masksToBounds = true
        
        let url = NSURL(string:petToDetail.imageBigURL)
        let data = NSData(contentsOf : url as! URL)
        let image = UIImage(data : data as! Data)
        petImage.image = image
        
        petName.text = petToDetail.name
        self.title = petToDetail.name
        petSex.text = petToDetail.sex
        petAge.text = petToDetail.age
        petBreed.text = petToDetail.breed
        petSize.text = petToDetail.size
        petShelter.text = petToDetail.shelterName

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
