//
//  main.swift
//  MusicianClass
//
//  Created by mac on 6/7/23.
//

import Foundation

let james = Musicians()

print(james.age)
print(james.type)

james.sing()

let kirk = SuperMusician(name: "Kirk", age: 55, instrument: "Guitar", type: .LeadGuitar)
kirk.sing()
kirk.sing2()
