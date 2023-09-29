//
//  ContentView.swift
//  EventSearch
//
//  Created by mac on 4/8/23.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var eventData: EventData
    var body: some View {
        EventSearchForm()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(EventData())
    }
}
