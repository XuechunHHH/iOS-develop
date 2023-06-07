import UIKit

var myName : String?

myName?.uppercased()

var myString = "Lars"
myString.lowercased()

var myAge = "l"

//var myInteger = Int(myAge)! * 5
//var myInteger2 = (Int(myAge) ?? 0) * 5

if let myNumber = Int(myAge){
    print(myNumber * 5)
} else {
    print("Wrong Input")
}
