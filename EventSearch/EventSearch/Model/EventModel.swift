//
//  EventModel.swift
//  EventSearch
//
//  Created by mac on 4/10/23.
//

import Foundation
import SwiftUI
import SwiftyJSON

struct Event: Hashable, Codable, Identifiable{
    var event: String
    var icon: String
    var id : String
    var venue: String
    var localDate: String
    var localTime: String
    var genre: String
    
    func toJSON() -> JSON {
            let eventDict: [String: Any] = [
                "event": event,
                "icon": icon,
                "id": id,
                "venue": venue,
                "localDate": localDate,
                "localTime": localTime,
                "genre": genre
            ]
            return JSON(eventDict)
        }
}

