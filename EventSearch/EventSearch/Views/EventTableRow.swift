//
//  EventTableRow.swift
//  EventSearch
//
//  Created by mac on 4/10/23.
//

import SwiftUI
import SwiftyJSON
import Kingfisher

struct EventTableRow: View {
    var event:JSON
    var body: some View {
        HStack{
            Text((event["localDate"].string ?? "")+"|"+(event["localTime"].string ?? ""))
                .foregroundColor(Color.gray)
                .frame(width:80,height:50)
            KFImage(URL(string: event["icon"].string!))
                        .resizable()
                        .frame(width: 55,height:55)
                        .cornerRadius(10)
            Text(event["event"].string!)
                .frame(width:72,height:80)
            Text(event["venue"].string!)
                .foregroundColor(Color.gray)
                .frame(width:70,height:50)
        }
        .padding(/*@START_MENU_TOKEN@*/.vertical/*@END_MENU_TOKEN@*/)
        
    }
}

struct EventTableRow_Previews: PreviewProvider {
    static var previews: some View {
        EventTableRow(event:[
            "localTime" : "18:00:00",
            "genre" : "Music",
            "event" : "Ed Sheeran: +-=÷x Tour",
            "icon" : "https://s1.ticketm.net/dam/a/7d5/97b67038-f926-4676-be88-ebf94cb5c7d5_1802151_TABLET_LANDSCAPE_3_2.jpg",
            "venue" : "Levi's® Stadium",
            "localDate" : "2023-09-16",
            "id" : "G5vYZ9KDbiIMY"
          ])
    }
}
