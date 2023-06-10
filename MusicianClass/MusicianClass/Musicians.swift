//
//  Musicians.swift
//  MusicianClass
//
//  Created by mac on 6/7/23.
//

import Foundation

enum MusicianType {
    case LeadGuitar
    case Vocalist
    case Drummer
    case Bassist
    case Violenist
}

class Musicians {
    var name : String
    var age : Int
    var instrument : String
    var type : MusicianType
    
    // Initializer (Constructor)
    init() {
        self.name = ""
        self.age = 50
        self.instrument = ""
        self.type = MusicianType.Vocalist
    }
    
    init(name: String, age: Int, instrument: String, type: MusicianType) {
        self.name = name
        self.age = age
        self.instrument = instrument
        self.type = type
    }
    
    func sing(){
        print("nothing else matters")
    }
}
