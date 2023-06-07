import UIKit

var myFavoriteMovies = ["Pulp Fiction", "Kill Bill", "Reservoir Dogs", 5, true] as [Any]

//as -> casting
//any - > any object

//index
myFavoriteMovies[0]
myFavoriteMovies[1]
myFavoriteMovies[2]
myFavoriteMovies[3]
myFavoriteMovies[4]

var myStringArray = ["Test6", "Test2", "Test1", "Test4"]

myStringArray[0].uppercased()
myStringArray.count
myStringArray[myStringArray.count - 2]
myStringArray.last
myStringArray.sort()
myStringArray

var myNumberArray = [1,2,3,4,5,6,7]
myNumberArray.append(8)
myNumberArray[0]

// Set
// do not have indexs and order
var mySet: Set = [1,2,3,4,5,1,]
mySet.first

var myInternetArray = [1,2,3,1,2,5,6,2,1]
var myInternetSet = Set(myInternetArray)
myInternetArray
myInternetSet

// Dictionary
// key-value pairing

var myFavoriteDirectors = ["Pulp Fiction" : "Tarantino", "Lock, Stock" : "Guy Ritchie", "The Dark Knight" : "Christopher Nolan"]
myFavoriteDirectors["Pulp Fiction"]
myFavoriteDirectors["Pulp Fiction"] = "Quentin Tarantino"

myFavoriteDirectors["Seven Samurai"] = "Akira Kurisowa"
