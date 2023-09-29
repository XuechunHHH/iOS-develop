//
//  EventsView.swift
//  EventSearch
//
//  Created by mac on 4/11/23.
//

import SwiftUI
import SwiftyJSON
import Kingfisher
import SwiftUI_SimpleToast

struct EventsView: View {
    @State var eventDetail: JSON
    @State var event: JSON
    @State var showToast = false
    @State var showRemove = false
    @EnvironmentObject var eventData: EventData
    
    private let toastOptions = SimpleToastOptions(
        alignment: .bottom,
        hideAfter: 1.5,
        modifierType: .fade
    )
    
    
    func addFavorite() {
        showToast = true
        let structEvent: Event = Event.init(event: event["event"].string ?? "", icon: event["icon"].string ?? "", id: event["id"].string ?? "", venue: event["venue"].string ?? "", localDate: event["localDate"].string ?? "", localTime: event["localTime"].string ?? "", genre: (eventDetail["genre"].array ?? []).map { $0.stringValue }.joined(separator: " | "))
        eventData.addEvent(structEvent)
        print(eventData.events)
    }
    
    func removeFavorite() {
        showRemove = true
        let structEvent: Event = Event.init(event: event["event"].string ?? "", icon: event["icon"].string ?? "", id: event["id"].string ?? "", venue: event["venue"].string ?? "", localDate: event["localDate"].string ?? "", localTime: event["localTime"].string ?? "", genre: (eventDetail["genre"].array ?? []).map { $0.stringValue }.joined(separator: " | "))
        eventData.removeEvent(structEvent)
        print(eventData.events)
    }
    
    var body: some View {
        VStack {
            Text(eventDetail["name"].string ?? "Name")
                .offset(y:-20)
                .padding(.bottom,-20)
                .font(.title2)
                .fontWeight(.bold)
                .padding(.horizontal)
                .lineLimit(1)
            HStack{
                VStack(alignment: .leading) {
                    Text("Date")
                        .fontWeight(.bold)
                    Text(eventDetail["localDate"].string ?? "")
                        .foregroundColor(Color.gray)
                        .lineLimit(1)
                }
                Spacer()
                VStack(alignment: .trailing) {
                    Text("Artist | Team")
                        .fontWeight(.bold)
                    Text((eventDetail["artist"].array ?? []).map { $0.stringValue }.joined(separator: " | "))
                        .foregroundColor(Color.gray)
                        .lineLimit(1)
                }
            }
            .padding(.horizontal)
            HStack{
                VStack(alignment: .leading) {
                    Text("Venue")
                        .fontWeight(.bold)
                    Text(eventDetail["venue"].string ?? "")
                        .foregroundColor(Color.gray)
                        .lineLimit(1)
                }
                Spacer()
                VStack(alignment: .trailing) {
                    Text("Genre")
                        .fontWeight(.bold)
                    Text((eventDetail["genre"].array ?? []).map { $0.stringValue }.joined(separator: " | "))
                        .foregroundColor(Color.gray)
                        .lineLimit(1)
                }
            }
            .padding(.top, 0.5)
            .padding(.horizontal)
            HStack{
                VStack(alignment: .leading) {
                    Text("Price Range")
                        .fontWeight(.bold)
                    Text(String(eventDetail["pricerange"]["min"].double ?? 0) + "-" + String(eventDetail["pricerange"]["max"].double ?? 0))
                        .foregroundColor(Color.gray)
                        .lineLimit(1)
                }
                Spacer()
                VStack(alignment: .trailing) {
                    Text("Ticket Status")
                        .fontWeight(.bold)
                    Button(action: {}) {
                        if (eventDetail["status"].string ?? "") == "onsale" {
                            Text("Onsale")
                                .frame(width: 100, height:25)
                                .buttonStyle(BorderlessButtonStyle())
                                .foregroundColor(.white)
                                .background(Color.green)
                                .cornerRadius(5)
                        }
                        if (eventDetail["status"].string ?? "") == "offsale" {
                            Text("Offsale")
                                .frame(width: 100, height:25)
                                .buttonStyle(BorderlessButtonStyle())
                                .foregroundColor(.white)
                                .background(Color.red)
                                .cornerRadius(5)
                        }
                        if (eventDetail["status"].string ?? "") == "cancelled" {
                            Text("Cancelled")
                                .frame(width: 100, height:25)
                                .buttonStyle(BorderlessButtonStyle())
                                .foregroundColor(.white)
                                .background(Color.black)
                                .cornerRadius(5)
                        }
                        if (eventDetail["status"].string ?? "") == "postponed" {
                            Text("Postponed")
                                .frame(width: 100, height:25)
                                .buttonStyle(BorderlessButtonStyle())
                                .foregroundColor(.white)
                                .background(Color.yellow)
                                .cornerRadius(5)
                        }
                        if (eventDetail["status"].string ?? "") == "rescheduled" {
                            Text("Rescheduled")
                                .frame(width: 100, height:25)
                                .buttonStyle(BorderlessButtonStyle())
                                .foregroundColor(.white)
                                .background(Color.yellow)
                                .cornerRadius(5)
                        }
                    }
                    
                }
            }
            .padding(.top, 0.5)
            .padding(.horizontal)
            if eventData.containsEvent(event: Event.init(event: event["event"].string ?? "", icon: event["icon"].string ?? "", id: event["id"].string ?? "", venue: event["venue"].string ?? "", localDate: event["localDate"].string ?? "", localTime: event["localTime"].string ?? "", genre: (eventDetail["genre"].array ?? []).map { $0.stringValue }.joined(separator: " | "))) {
                Button("Remove From Favorite",action:removeFavorite)
                    .padding(.horizontal)
                    .frame(width: 120, height: 45)
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .lineLimit(1)
                    .buttonStyle(BorderlessButtonStyle())
            } else {
                Button("Save Event",action:addFavorite)
                    .frame(width: 120, height: 45)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .buttonStyle(BorderlessButtonStyle())
            }
            if eventDetail.contains(where: { $0.0 == "seatmap" }) {
                KFImage(URL(string: eventDetail["seatmap"].string ?? ""))
                    .resizable()
                    .frame(width:270,height:270)
            }
            HStack {
                Text("Buy Tickey At: ")
                    .fontWeight(.bold)
                Link("Ticketmaster", destination: URL(string: (eventDetail["url"].string ?? ""))!)
                    .foregroundColor(Color.blue)
            }
            HStack {
                Text("Share on: ")
                    .fontWeight(.bold)
                Link(destination: {
                    var components = URLComponents(string: "https://www.facebook.com/sharer/sharer.php")!
                    components.queryItems = [
                        URLQueryItem(name: "u", value: (eventDetail["url"].string ?? "")),
                    ]
                    return components.url!
                }()) {
                    Image("facebook")
                        .resizable()
                        .frame(width: 40, height: 40)
                }
                Link(destination: {
                    var components = URLComponents(string: "https://twitter.com/intent/tweet")!
                    components.queryItems = [
                        URLQueryItem(name: "text", value:  (eventDetail["name"].string ?? "") + "\r\n" + (eventDetail["url"].string ?? "")),
                    ]
                    return components.url!
                }()) {
                    Image("twitter")
                        .resizable()
                        .frame(width: 40, height: 40)
                }
            }
            Spacer()
        }
        .padding(.top, 30)
        .simpleToast(isShowing: $showToast, options: toastOptions) {
            HStack {
                Text("Added to favorites.")
            }
            .frame(width: 280, height: 80)
            .background(Color.gray.opacity(0.4))
            .foregroundColor(Color.black)
            .cornerRadius(10)
        }
        .simpleToast(isShowing: $showRemove, options: toastOptions) {
            HStack {
                Text("Remove favorite.")
            }
            .frame(width: 280, height: 80)
            .background(Color.gray.opacity(0.4))
            .foregroundColor(Color.black)
            .cornerRadius(10)
        }
    }
}

struct EventsView_Previews: PreviewProvider {
    static var previews: some View {
        EventsView(eventDetail: [
            "genre" : [
                "Music",
                "Pop"
            ],
            "url" : "https://www.ticketmaster.com/ed-sheeran-x-tour-santa-clara-california-09-16-2023/event/1C005D3ED8B28DF0",
            "artist" : [
                "Ed Sheeran",
                "Russ",
                "Maisie Peters"
            ],
            "name" : "Ed Sheeran: +-=÷x Tour",
            "localDate" : "2023-09-16",
            "id" : "G5vYZ9KDbiIMY",
            "venue" : "Levi's® Stadium",
            "seatmap" : "https://maps.ticketmaster.com/maps/geometry/3/event/1C005D3ED8B28DF0/staticImage?type=png&systemId=HOST",
            "status" : "onsale",
            "pricerange" : [
                "currency" : "USD",
                "type" : "standard",
                "min" : 49,
                "max" : 159
            ]
        ], event: [
            "localTime" : "18:00:00",
            "genre" : "Music",
            "event" : "Ed Sheeran: +-=÷x Tour",
            "icon" : "https://s1.ticketm.net/dam/a/7d5/97b67038-f926-4676-be88-ebf94cb5c7d5_1802151_TABLET_LANDSCAPE_3_2.jpg",
            "venue" : "Levi's® Stadium",
            "localDate" : "2023-09-16",
            "id" : "G5vYZ9KDbiIMY"
        ])
        .environmentObject(EventData())
    }
}
