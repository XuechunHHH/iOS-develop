//
//  EventData.swift
//  EventSearch
//
//  Created by mac on 4/16/23.
//

import Foundation
import SwiftUI

class EventData: ObservableObject {
    // access the events stored in AppStorage
    @AppStorage("events") var eventsData: Data = Data()
    
    // store the events fetched from storage
    @Published var events: [Event] = []
    
    init() {
        // fetch the events from storage on initialization
        let decoder = JSONDecoder()
        if let decodedData = try? decoder.decode([Event].self, from: eventsData) {
            events = decodedData
        }
    }
    
    // save the updated events to AppStorage
    func saveEvents() {
        let encoder = JSONEncoder()
        if let encodedData = try? encoder.encode(events) {
            eventsData = encodedData
        }
    }
    
    func addEvent(_ event: Event) {
        events.append(event)
        saveEvents()
    }
    
    func removeEvent(_ event: Event) {
        if let index = events.firstIndex(where: { $0.id == event.id }) {
            events.remove(at: index)
            saveEvents()
        }
    }
    
    func containsEvent(event: Event) -> Bool {
        return events.contains { $0.id == event.id }
    }
}
