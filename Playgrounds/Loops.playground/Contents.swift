import UIKit

var myNumber = 1
myNumber = myNumber + 1
myNumber += 1

var number = 0

// while loop

while number < 10 {
    print(number)
    number += 1
}

var characterAlive = true
while characterAlive == true {
    print("character alive")
    characterAlive = false
}

var myFruitArray = ["Banana","Apple","Orange"]

for fruit in myFruitArray {
    print(fruit)
}

var myNumbers = [10,20,30,40,50,60]

for num in myNumbers{
    print(num / 5)
}

for mynewinteger in 1 ... 5 {
    print (mynewinteger * 2)
}
