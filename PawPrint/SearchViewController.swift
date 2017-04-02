//
//  ViewController.swift
//  PawPrint
//
//  Created by Rachael on 4/1/17.
//  Copyright © 2017 Rachael. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate{
    
   
    
    var petType = ""
    var petSize = ""
    var apiKey = "b08b42995a34727e55aae9eb7194a1d3"
    
    var petTypes = ["Any", "Dog", "Cat", "Bird", "Reptile"]

    @IBOutlet weak var animalTypePicker: UIPickerView!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var sizePicker: UISegmentedControl!
    @IBOutlet weak var findPetsButton: UIButton!
    
    var alertController:UIAlertController? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationTextField.delegate = self
        animalTypePicker.delegate = self
        animalTypePicker.dataSource = self
        findPetsButton.layer.cornerRadius = 5
        petSize = sizePicker.titleForSegment(at: sizePicker.selectedSegmentIndex)!
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    @IBAction func sizeDidChange(_ sender: Any) {
        petSize = sizePicker.titleForSegment(at: sizePicker.selectedSegmentIndex)!
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return petTypes.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return petTypes[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        petType = petTypes[row].lowercased()
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String?, sender: Any?) -> Bool {
        if(locationTextField.text!.isEmpty){
            self.alertController = UIAlertController(title: "Error", message: "Please add a location", preferredStyle: UIAlertControllerStyle.alert)
            let OKAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default)
            self.alertController!.addAction(OKAction)
            self.present(self.alertController!, animated: true, completion:nil)
            return false
        }
        else{
                return true
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let petVC:PetsTableViewController = segue.destination as! PetsTableViewController;
        petVC.locationText = locationTextField.text!
        petVC.typeText = petType
        petVC.sizeText = petSize
    }
    
}

