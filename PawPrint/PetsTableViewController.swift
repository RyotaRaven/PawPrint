//
//  PetsTableViewController.swift
//  PawPrint
//
//  Created by Rachael on 4/1/17.
//  Copyright © 2017 Rachael. All rights reserved.
//

import UIKit

class PetsTableViewController: UITableViewController {
    
    var pets:[Pet] = []
    
    public var locationText:String!
    public var sizeText:String!
    public var typeText:String!
    
     var alertController:UIAlertController? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Pets"
        getPets()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return pets.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellid", for: indexPath) as! PetTableViewCell
        
        let petShown = pets[indexPath.row]
        
        let url = NSURL(string:"\(petShown.imageSmallURL)")
        let data = NSData(contentsOf : url as! URL)
        let image = UIImage(data : data as! Data)
        
        cell.petImage.layer.cornerRadius = 15
        cell.petImage.layer.masksToBounds = true
        cell.petImage.image = image
        
        cell.petName.text = petShown.name
        cell.petBreedAnimal.text = "\(petShown.breed)"
        cell.petAnimal.text = "\(petShown.animal)"

        // Configure the cell...

        return cell
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let petVC:PetDetailsViewController = segue.destination as! PetDetailsViewController;
        petVC.petToDetail = pets[self.tableView.indexPathForSelectedRow?.row ?? 0]
    }
    
    func getPets(){
        var petsGotten:NSDictionary?
        let urlPathBase = "http://api.petfinder.com/pet.find?&key=b08b42995a34727e55aae9eb7194a1d3&format=json"
        let urlLocationPrefix = "&location="
        let urlSize = "&size="
        let urlTypePrefix = "&animal="
        
        // Compose the URL.
        var urlPath = urlPathBase
        urlPath = urlPath + urlLocationPrefix + self.locationText.replacingOccurrences(of: " ", with: "%20")
        if(sizeText != "All"){
            urlPath = urlPath + urlSize + self.sizeText
        }
        if(typeText != "" && typeText != "Any")
        {
            urlPath = urlPath + urlTypePrefix + self.typeText
        }
        
        let url:URL? = URL(string: urlPath)
        
        if (url == nil) {
            print("I AM ERROR URL")
        }
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: url!, completionHandler: { (data, response, error) -> Void in
            if error != nil {
                print("I AM ERROR")
            } else {
                //print(response)
                do {
                    let jsonResult = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary
                    if jsonResult != nil {
                        if let results: NSDictionary = jsonResult!["petfinder"] as? NSDictionary {
                            petsGotten = results["pets"] as? NSDictionary
                            if petsGotten != nil {
                                self.pets = convertToPets(pets: petsGotten!)
                                DispatchQueue.main.async {
                                    self.tableView.reloadData()
                                }
                                
                            } else {
                                self.alertController = UIAlertController(title: "No Data", message: "No Pets Found :(", preferredStyle: UIAlertControllerStyle.alert)
                                let OKAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default){ (action:UIAlertAction) in
                                    _ = self.navigationController?.popViewController(animated: true)
                                }
                                self.alertController!.addAction(OKAction)
                                self.present(self.alertController!, animated: true, completion:nil)
                                print("No data")
                            }
                        }
                    }
                } catch {
                    print("Parse Error")
                }
            }
        })
        task.resume() // start the request
    }
    
}


func getShelter(id:String, pet:Pet){
    var shelter:NSDictionary?
    let urlPathBase = "http://api.petfinder.com/shelter.get?&key=b08b42995a34727e55aae9eb7194a1d3&format=json&id="
    // Compose the URL.
    var urlPath = urlPathBase + id
    
    let url:URL? = URL(string: urlPath)
    
    if (url == nil) {
        print("I AM ERROR URL")
    }
    
    let session = URLSession.shared
    
    let task = session.dataTask(with: url!, completionHandler: { (data, response, error) -> Void in
        if error != nil {
            print("I AM ERROR")
        } else {
            do {
                let jsonResult = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary
                if jsonResult != nil {
                    if let results: NSDictionary = jsonResult!["petfinder"] as? NSDictionary {
                        shelter = results["shelter"] as? NSDictionary
                        if shelter != nil {
                            var shelterName = shelter!["name"] as! NSDictionary
                            pet.shelterName = shelterName["$t"] as! String
                            
                            
                        }
                    }
                }
            } catch {
                print("Parse Error")
            }
        }
    })
    task.resume() // start the request
    
}

func convertToPets(pets:NSDictionary) -> [Pet]{
    var convertedPets:[Pet] = []
    let petArray:NSArray = pets["pet"] as! NSArray
    for pet in petArray{
        let NSPet = pet as! NSDictionary
        let petCreated:Pet = Pet()
        let nameDict:NSDictionary = NSPet["name"] as! NSDictionary
        petCreated.name = nameDict["$t"] as! String
        let ageDict:NSDictionary = NSPet["age"] as! NSDictionary
        petCreated.age = ageDict["$t"] as! String
        let sexDict:NSDictionary = NSPet["sex"] as! NSDictionary
        petCreated.sex = sexDict["$t"] as! String
        let idDict:NSDictionary = NSPet["id"] as! NSDictionary
        petCreated.id = idDict["$t"] as! String
        let breedDict:NSDictionary = NSPet["breeds"] as! NSDictionary
        let breed = breedDict["breed"]
        if let breedArray:NSArray = breed as? NSArray{
            for i in 0...breedArray.count-1{
                let breedDict3 = breedArray[i] as! NSDictionary
                petCreated.breed += "\(breedDict3["$t"] as! String), "
            }
            petCreated.breed = petCreated.breed.substring(to: petCreated.breed.index(before: petCreated.breed.endIndex))
            petCreated.breed += " Mix"
        }
        else{
            let breedDict2 = breed as! NSDictionary
            petCreated.breed = breedDict2["$t"] as! String

        }
        let animalDict:NSDictionary = NSPet["animal"] as! NSDictionary
        petCreated.animal = animalDict["$t"] as! String
        let shelterDict:NSDictionary = NSPet["shelterId"] as! NSDictionary
        petCreated.shelterID = shelterDict["$t"] as! String
        getShelter(id: petCreated.shelterID, pet: petCreated)
        let sizeDict:NSDictionary = NSPet["size"] as! NSDictionary
        petCreated.size = sizeDict["$t"] as! String
        let mediaDict:NSDictionary = NSPet["media"] as! NSDictionary
        if let photosDict:NSDictionary = mediaDict["photos"] as? NSDictionary{
            let photoArray:NSArray = photosDict["photo"] as! NSArray
            let smallPhotoDict = photoArray[1] as! NSDictionary
            petCreated.imageSmallURL = smallPhotoDict["$t"] as! String
            let bigPhotoDict = photoArray[2] as! NSDictionary
            petCreated.imageBigURL = bigPhotoDict["$t"] as! String
            convertedPets.append(petCreated)

        }
        else{
            petCreated.imageBigURL = "http://www.clker.com/cliparts/T/q/z/U/O/6/blue-paw-print-hi.png"
            petCreated.imageSmallURL = "http://www.clker.com/cliparts/T/q/z/U/O/6/blue-paw-print-hi.png"
        }
    }
    return convertedPets
}

