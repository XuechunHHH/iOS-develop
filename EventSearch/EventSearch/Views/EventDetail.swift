//
//  EventDetail.swift
//  EventSearch
//
//  Created by mac on 4/10/23.
//

import SwiftUI
import SwiftyJSON
import Alamofire
import MapKit

struct EventDetail: View {
    var event:JSON
    @State var isSugLoading:Bool
    @State var isShowTab = false
    
    @State var eventDetail: JSON = []
    @State var artists: [JSON] = []
    @State var artistsDetail: [JSON] = []
    @State var venue: JSON = []
    @State var cnt = 0
    @State var coordinateRegion = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 0, longitude: 0),
        span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    )
    
    @EnvironmentObject var eventData: EventData
    
    func getEventDetail() {
        cnt = 0
        AF.request("https://backend-nodejs-390505.wl.r.appspot.com/event?id=" + self.event["id"].string! ).responseJSON { response in
            switch response.result {
            case .success(let value):
                self.eventDetail = JSON(value)
                self.artists = eventDetail["artist"].array!
                print(artists)
                print(eventDetail)
                let genre = eventDetail["genre"].array ?? []
                for i in 0..<genre.count{
                    if genre[i].string == "Music"{
                        for _ in 0..<self.artists.count{
                            artistsDetail.append(JSON())
                        }
                        for idx in 0..<self.artists.count{
                            getArtistDetail(idx: idx)
                        }
                        break
                    } else {
                        if i == genre.count - 1 {
                            getVenue()
                        }
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getArtistDetail(idx: Int){
        let para = [
            "name": self.artists[idx].string!
        ]
        AF.request("https://backend-nodejs-390505.wl.r.appspot.com/artist", parameters: para, encoding: URLEncoding.default).responseJSON { response in
            switch response.result {
            case .success(let value):
                let artistDetail = JSON(value)
                artistsDetail[idx] = artistDetail
                getAlbum(idx: idx, id: artistDetail["id"].string ?? "")
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getAlbum(idx: Int, id: String){
        let para = [
            "id": id
        ]
        AF.request("https://backend-nodejs-390505.wl.r.appspot.com/album", parameters: para, encoding: URLEncoding.default).responseJSON { response in
            switch response.result {
            case .success(let value):
                var dic = artistsDetail[idx].dictionaryObject!
                dic["album"] = JSON(value)
                artistsDetail[idx] = JSON(dic)
                cnt = cnt + 1
                if cnt == artists.count {
                    getVenue()
                    print(artistsDetail)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getVenue(){
        let para = [
            "str": event["venue"].string!
        ]
        AF.request("https://backend-nodejs-390505.wl.r.appspot.com/venue", parameters: para, encoding: URLEncoding.default).responseJSON { response in
            switch response.result {
            case .success(let value):
                self.venue = JSON(value)
                print(venue)
                getMap()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getMap() {
        let address = venue["address"].string ?? ""
        let city = venue["city"].string ?? ""
        let state = venue["state"].string ?? ""
        let com = address + "," + city + "," + state
        let para = [
            "address": com,
            "key": "AIzaSyB63jkF2aaHlOMuYTc0iTH0UXwZYvBp8dA"
        ]
        AF.request("https://maps.googleapis.com/maps/api/geocode/json",parameters: para, encoding: URLEncoding.default).responseJSON { response in
            switch response.result {
            case .success(let value):
                let ip = JSON(value)
                if let res = ip["results"].array {
                    print(res)
                    let lat = res[0]["geometry"]["location"]["lat"].double ?? 0
                    let lng = res[0]["geometry"]["location"]["lng"].double ?? 0
                    print("Lat: \(lat) Lng: \(lng)")
                    coordinateRegion = MKCoordinateRegion(
                        center: CLLocationCoordinate2D(latitude: lat, longitude: lng),
                        span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
                    )
                    isSugLoading = false
                    isShowTab = true
                } else {
                    print("Location not found in response")
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    var body: some View {
        VStack{
            if isSugLoading{
                VStack() {
                    ProgressView()
                    Text("Please wait...")
                        .foregroundColor(Color.gray)
                }
                .onAppear{
                    getEventDetail()
                }
                .padding(.top, 200)
            }
                        
            if isShowTab {
                TabView {
                    EventsView(eventDetail: eventDetail, event: event)
                        .tabItem {
                            Label("Events", systemImage: "text.bubble.fill")
                        }
                    ArtistsView(artistsDetail: artistsDetail)
                        .tabItem {
                            Label("Artist/Team", systemImage: "guitars.fill")
                        }
                    VenueView(event: eventDetail["name"].string ?? "", venue: venue, coordinateRegion: self.coordinateRegion)
                        .tabItem {
                            Label("Venue", systemImage: "location.fill")
                        }
                }
            }
        }
    }
}

struct EventDetail_Previews: PreviewProvider {
    static var previews: some View {
        EventDetail(event:[
            "localTime" : "18:00:00",
            "genre" : "Music",
            "event" : "Ed Sheeran: +-=÷x Tour",
            "icon" : "https://s1.ticketm.net/dam/a/7d5/97b67038-f926-4676-be88-ebf94cb5c7d5_1802151_TABLET_LANDSCAPE_3_2.jpg",
            "venue" : "Levi's® Stadium",
            "localDate" : "2023-09-16",
            "id" : "G5vYZ9KDbiIMY"
        ], isSugLoading: true)
        .environmentObject(EventData())
    }
}
