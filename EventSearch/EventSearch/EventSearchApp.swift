//
//  EventSearchApp.swift
//  EventSearch
//
//  Created by mac on 4/8/23.
//

import SwiftUI

@main
struct EventSearchApp: App {
    @EnvironmentObject var eventData: EventData
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(EventData())
        }
    }
}
