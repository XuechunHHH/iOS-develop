//
//  PlaceModel.swift
//  FoursquareClone
//
//  Created by mac on 6/22/23.
//

import Foundation
import UIKit

class PlaceModel {
    static let sharedInstance = PlaceModel()
    
    var placeName = ""
    var placeType = ""
    var placeAtmosphere = ""
    var placeImage = UIImage()
    var placeLatitude = ""
    var placeLongtitude = ""
    
    private init(){}
}
