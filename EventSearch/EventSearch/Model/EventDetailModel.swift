//
//  EventDetailModel.swift
//  EventSearch
//
//  Created by mac on 4/16/23.
//

import Foundation
import SwiftUI
import SwiftyJSON

struct EventDetail: Hashable, Codable, Identifiable{
    var localDate: String
    var icon: String
    var id : String
    var venue: String
    var localDate: String
    var localTime: String
    var genre: String
}
