//
//  SuperMusician.swift
//  MusicianClass
//
//  Created by mac on 6/7/23.
//

import Foundation

class SuperMusician : Musicians {
    func sing2(){
        print("enter night")
    }
    
    override func sing() {
        super.sing()
        print("exit light")
    }
}
