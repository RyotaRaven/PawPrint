//
//  Pet.swift
//  PawPrint
//
//  Created by Rachael on 4/1/17.
//  Copyright © 2017 Rachael. All rights reserved.
//

import Foundation

class Pet{
    public var id:String
    public var name:String
    public var imageSmallURL:String
    public var imageBigURL:String
    public var age:String
    public var breed:String
    public var size:String
    public var sex:String
    public var animal:String
    public var shelterID:String
    public var shelterName:String
    
    init(){
        self.id=""
        self.name=""
        self.imageSmallURL=""
        self.imageBigURL=""
        self.age=""
        self.size=""
        self.sex=""
        self.animal=""
        self.breed=""
        self.shelterID=""
        self.shelterName = ""
    }
    
    init(id:String, name:String, imageSmallURL:String, imageBigURL:String, age:String, breed:String, size:String, sex:String, animal:String, shelterId:String){
        self.id = id
        self.name = name
        self.imageSmallURL = imageSmallURL
        self.imageBigURL = imageBigURL
        self.age = age
        self.breed = breed
        self.size = size
        self.sex = sex
        self.shelterID = shelterId
        self.animal = animal
        self.shelterName = ""
    }
    
    func toString() -> String{
        return "\(name) \(breed) \(animal) \(age) \(size) \(sex)"
    }
}
