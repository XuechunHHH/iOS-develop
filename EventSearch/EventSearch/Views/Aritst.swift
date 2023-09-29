//
//  Aritst.swift
//  EventSearch
//
//  Created by mac on 4/14/23.
//

import SwiftUI
import SwiftyJSON
import Kingfisher

struct Aritst: View {
    @State var artist: JSON
    var body: some View {
        VStack(){
            HStack{
                VStack{
                    if artist.contains(where: { $0.0 == "image" }) {
                        KFImage(URL(string: artist["image"].string ?? ""))
                            .resizable()
                            .frame(width:105,height:105)
                            .cornerRadius(10)
                    }
                }
                VStack(alignment: .leading){
                    Text(artist["name"].string ?? "")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(Color.white)
                    Spacer()
                    HStack{
                        Text(artist["followers"].string ?? "")
                            .font(.title3)
                            .fontWeight(.medium)
                            .foregroundColor(Color.white)
                        Text("Followers")
                            .foregroundColor(Color.white)
                    }
                    Spacer()
                    HStack {
                        Link(destination: URL(string: (artist["url"].string ?? ""))!) {
                            Image("spotify")
                                .resizable()
                                .frame(width: 30, height: 30)
                        }
                        Text(" Spotify")
                            .foregroundColor(Color(red: 0.393, green: 0.846, blue: 0.383))
                    }
                }
                .frame(width: 140)
                VStack{
                    Text("Popularity")
                        .foregroundColor(Color.white)
                        .font(.title3)
                    CircularProgress(popularity: artist["popularity"].int ?? 0)
                    Spacer()
                }
                
            }
            .frame(height: 110)
            .padding(.top)
            HStack{
                Text("Popular Albums")
                    .font(.title2)
                    .fontWeight(.medium)
                    .foregroundColor(Color.white)
                    .padding(.horizontal)
                Spacer()
            }
            .padding(.top)
            HStack{
                if artist.contains(where: { $0.0 == "album" }) {
                    
                    KFImage(URL(string: artist["album"][0].string ?? ""))
                        .resizable()
                        .frame(width:100,height:100)
                        .cornerRadius(10)
                    Spacer()
                    KFImage(URL(string: artist["album"][1].string ?? ""))
                        .resizable()
                        .frame(width:100,height:100)
                        .cornerRadius(10)
                    Spacer()
                    KFImage(URL(string: artist["album"][2].string ?? ""))
                        .resizable()
                        .frame(width:100,height:100)
                        .cornerRadius(10)
                }
            }
            .padding(.horizontal)
            .padding(.bottom)
        }
        .background(Color(hue: 1.0, saturation: 0.038, brightness: 0.405))
        .cornerRadius(10)
        .padding(.horizontal, 8)
    }
}

struct Aritst_Previews: PreviewProvider {
    static var previews: some View {
        Aritst(artist: [
            "url" : "https://open.spotify.com/artist/6eUKZXaKkcviH0Ku9w2n3V",
            "popularity" : 91,
            "name" : "Ed Sheeran",
            "album" : [
                "https://i.scdn.co/image/ab67616d0000b273a9473656bdf001fd00a4fa13",
                "https://i.scdn.co/image/ab67616d0000b273dd51c567ae17b0a609be81f9",
                "https://i.scdn.co/image/ab67616d0000b273aefa57a1ad78ad4a907a5ab6"
            ],
            "followers" : "111M",
            "id" : "6eUKZXaKkcviH0Ku9w2n3V",
            "image" : "https://i.scdn.co/image/ab6761610000e5eb9e690225ad4445530612ccc9"
        ])
    }
}
