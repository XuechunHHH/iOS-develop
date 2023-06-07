import UIKit

func myFunction(){
    print("my function")
}

print("print")
myFunction()

// Input & Output & Return

func sumFunction(x: Int, y: Int) -> Int {
    return x + y
}

let myFucntionVariable = sumFunction(x: 10, y: 20)
print(myFucntionVariable)

func logicFuction(a:Int, b:Int) -> Bool {
    if a > b {
        return true
    } else {
        return false
    }
}

logicFuction(a: -10, b: 0)
