//
//  EventSearchForm.swift
//  EventSearch
//
//  Created by mac on 4/8/23.
//

import SwiftUI
import Alamofire
import SwiftyJSON

struct EventSearchForm: View {
    @State private var keyword = ""
    @State private var distance = "10"
    @State private var category = "Default"
    @State private var location = ""
    @State private var autoDetect = false
    
    @State private var isSheetPresented = false
    @State private var isSugLoading = true
    @State private var suggestions: [String] = []
    @State private var showSuggestions = false
    
    @State private var resultsReady = false
    @State private var isLoading = false
    @State private var emptyDisplay = false
    @State private var eventsDisplay = false
    
    @State private var events: [JSON] = []
    
    @EnvironmentObject var eventData: EventData
    
    var isSubmit : Bool {
        return !keyword.isEmpty && !distance.isEmpty  && (!location.isEmpty || autoDetect == true)
    }
    
    func getSuggestions() {
        self.suggestions = []
        let para = [
            "keyword": self.keyword
        ]
        AF.request("https://backend-nodejs-390505.wl.r.appspot.com/suggest",parameters: para, encoding: URLEncoding.default).responseJSON { response in
            switch response.result {
            case .success(let value):
                self.isSugLoading = false
                self.showSuggestions = true
                self.suggestions = value as! [String]
                print(suggestions)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func onClickSubmit() {
        if self.isSubmit{
            self.emptyDisplay = false
            self.eventsDisplay = false
            self.resultsReady = true
            self.isLoading = true
            print("Submit")
            if self.isSubmit {
                if self.autoDetect{
                    self.getIPInfo()
                } else {
                    self.getGeocode()
                }
            }
        }
    }
    
    func clear() {
        print("Clear")
        keyword = ""
        distance = "10"
        category = "Default"
        location = ""
        autoDetect = false
        isSheetPresented = false
        isSugLoading = true
        resultsReady = false
        isLoading = false
        emptyDisplay = false
        eventsDisplay = false
        showSuggestions = false
    }
    
    func getIPInfo() {
        AF.request("https://ipinfo.io?token=b5d2f54b8937ca").responseJSON { response in
            switch response.result {
            case .success(let value):
                let ip = JSON(value)
                if let loc = ip["loc"].string {
                    let lat = String(loc.split(separator: ",")[0])
                    let lng = String(loc.split(separator: ",")[1])
                    print("Lat: \(lat) Lng: \(lng)")
                    self.search(lat: lat, lng: lng)
                } else {
                    print("Location not found in response")
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    func getGeocode() {
        let para = [
            "address": self.location,
            "key": "AIzaSyB63jkF2aaHlOMuYTc0iTH0UXwZYvBp8dA"
        ]
        
        AF.request("https://maps.googleapis.com/maps/api/geocode/json",parameters: para, encoding: URLEncoding.default).responseJSON { response in
            switch response.result {
            case .success(let value):
                let ip = JSON(value)
                if let res = ip["results"].array {
                    if res.count == 0 {
                        self.isLoading = false
                        self.showEmpty()
                        print("Empty")
                    } else {
                        let lat = String(describing: res[0]["geometry"]["location"]["lat"])
                        let lng = String(describing: res[0]["geometry"]["location"]["lng"])
                        print("Lat: \(lat) Lng: \(lng)")
                        self.search(lat: lat, lng: lng)
                    }
                } else {
                    print("Location not found in response")
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func search(lat: String, lng: String) {
        print(self.keyword)
        print(self.distance)
        print(self.category.replacingOccurrences(of: "Arts & Theatre", with: "Arts"))
        let para = [
            "keyword": self.keyword,
            "category": self.category.replacingOccurrences(of: "Arts & Theatre", with: "Arts"),
            "distance": self.distance,
            "lat": lat,
            "lng": lng
        ]
        AF.request("https://backend-nodejs-390505.wl.r.appspot.com/search",parameters: para, encoding: URLEncoding.default).responseJSON { response in
            switch response.result {
            case .success(let value):
                let events = JSON(value)
                if events.count == 0 {
                    self.isLoading = false
                    print("Empty Search")
                    self.showEmpty()
                } else {
                    self.isLoading = false
                    self.events = events.array!
                    print("Search success")
                    print(self.events[0])
                    print(self.events.count)
                    self.show()
                }
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
    func showEmpty(){
        self.isLoading = false
        self.eventsDisplay = false
        self.emptyDisplay = true
    }
    
    func show(){
        self.isLoading = false
        self.eventsDisplay = true
        self.emptyDisplay = false
    }
    
    var body: some View {
        NavigationView {
            Form {

                    HStack {
                        Text("Keyword: ")
                            .foregroundColor(Color.gray)
                        TextField("Required", text: $keyword)
                            .onSubmit{
                                self.isSheetPresented = true
                                self.getSuggestions()
                            }
                    }
                    .sheet(isPresented: $isSheetPresented){
                        if self.isSugLoading{
                            ProgressView()
                        }
                        if self.showSuggestions {
                            Text("Suggestions")
                                .font(.largeTitle)
                                .fontWeight(.medium)
                                .padding()
                            List {
                                ForEach(self.suggestions, id: \.self) { string in
                                    Text(string)
                                        .onTapGesture{
                                            self.isSugLoading = true
                                            self.isSheetPresented = false
                                            self.showSuggestions = false
                                            self.keyword = string
                                        }
                                }
                            }
                        }
                    }
                    HStack {
                        Text("Distance: ")
                            .foregroundColor(Color.gray)
                        TextField("", text: $distance)
                            .keyboardType(.numberPad)
                    }
                    HStack {
                        Text("Category: ")
                            .foregroundColor(Color.gray)
                        Spacer()
                        Picker("", selection: $category) {
                            Text("Default").tag("Default")
                            Text("Music").tag("Music")
                            Text("Sports").tag("Sports")
                            Text("Arts & Theatre").tag("Arts & Theatre")
                            Text("Film").tag("Film")
                            Text("Miscellaneous").tag("Miscellaneous")
                        }
                        .pickerStyle(MenuPickerStyle())
                    }
                    if !autoDetect {
                        HStack {
                            Text("Location: ")
                                .foregroundColor(Color.gray)
                            TextField("Required", text: $location)
                        }
                    }
                    HStack {
                        Toggle("Auto-detect my location: ", isOn: $autoDetect)
                            .foregroundColor(Color.gray)
                            .onChange(of: autoDetect){
                                newValue in
                                if newValue {
                                    
                                } else {
                                    location = ""
                                }
                            }
                    }
                    HStack {
                        Button("Submit",action:onClickSubmit)
                            .frame(width: 120, height: 50)
                            .background(self.isSubmit ? Color.red : Color.gray)
                            .foregroundColor(.white)
                            .buttonStyle(.borderless)
                            .cornerRadius(10)
                            .padding()
                        Button("Clear",action:clear)
                            .frame(width: 120, height: 50)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .buttonStyle(.borderless)
                            .cornerRadius(10)
                            .padding()
                    }
                
                .navigationTitle("Event Search")
                .navigationBarItems(
                    trailing:
                        NavigationLink(destination: Favorite()){
                            Image(systemName: "heart.circle")
                        })
                
                Section{
                    if resultsReady {
                        HStack{
                            Text("Results")
                                .font(.title)
                                .fontWeight(.bold)
                        }
                    }
                    if isLoading {
                        HStack{
                            Spacer()
                            VStack(alignment: .center) {
                                ProgressView()
                                Text("Please wait...")
                                    .foregroundColor(Color.gray)
                            }
                            Spacer()
                        }
                    }
                    if emptyDisplay {
                        HStack{
                            Text("No result available")
                                .foregroundColor(Color.red)
                        }
                    }
                    if eventsDisplay {
                        ForEach (0..<20){num in
                            if num < self.events.count {
                                NavigationLink{
                                    EventDetail(event: self.events[num], isSugLoading: true)
                                        .padding(.top, -200)
                                }
                                label: {
                                    EventTableRow(event: self.events[num])
                            }
                            }
                        }
                    }
                }
            }
        }
    }
}


struct EventSearchForm_Previews: PreviewProvider {
    static var previews: some View {
        EventSearchForm()
            .environmentObject(EventData())
    }
}
