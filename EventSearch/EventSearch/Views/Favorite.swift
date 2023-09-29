//
//  Favorite.swift
//  EventSearch
//
//  Created by mac on 4/8/23.
//

import SwiftUI
import SwiftyJSON

struct Favorite: View {
    @EnvironmentObject var eventData: EventData
    
    func removeRows(at offsets: IndexSet) {
        eventData.events.remove(atOffsets: offsets)
        eventData.saveEvents()
    }
    
    var body: some View {
        if eventData.events.count == 0 {
            Text("No favorites found")
                .foregroundColor(Color.red)
                .navigationTitle("Favorites")
        } else {
            List {
                ForEach(eventData.events, id: \.self) { event in
                    ZStack {
                        NavigationLink(destination: EventDetail(event: event.toJSON(), isSugLoading: true).padding(.top,-200)){}
                            .opacity(0)
                        HStack {
                            Text(event.localDate)
                                .font(.footnote)
                                
                            Text(event.event)
                                .font(.footnote)
                                .lineLimit(2)
                            Text(event.genre)
                                .font(.footnote)
                            Text(event.venue)
                                .font(.footnote)
                        }
                        .padding(.horizontal,-12)
                    }
                }
                .onDelete(perform: removeRows)
            }
            .navigationTitle("Favorites")
        }
        
    }
}

struct Favorite_Previews: PreviewProvider {
    static var previews: some View {
        Favorite()
            .environmentObject(EventData())
    }
}
