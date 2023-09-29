//
//  ArtistsView.swift
//  EventSearch
//
//  Created by mac on 4/11/23.
//

import SwiftUI
import SwiftyJSON
import Kingfisher

struct ArtistsView: View {
    @State var artistsDetail: [JSON]
    
    var body: some View {
        if artistsDetail.count == 0 {
            Text("No music related artist details to show")
                .font(.largeTitle)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
        } else{
            ScrollView {
                VStack{
                    ForEach(0..<10) { num in
                        if num < artistsDetail.count{
                            Aritst(artist: artistsDetail[num])
                                .padding(.vertical)
                        }
                    }
                }
            }
            .padding(.top, 5)
        }
    }
}


struct ArtistsView_Previews: PreviewProvider {
    static var previews: some View {
        ArtistsView(artistsDetail: [[
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
        ], [
            "followers" : "4M",
            "album" : [
                "https://i.scdn.co/image/ab67616d0000b2733e36f41145dfc8a38a488020",
                "https://i.scdn.co/image/ab67616d0000b273039f0bcf97bf66ca8e1f736d",
                "https://i.scdn.co/image/ab67616d0000b273675fc8cf82a0c1024862a9dc"
            ],
            "image" : "https://i.scdn.co/image/ab6761610000e5eb64575cc66fdce98eba7cee22",
            "id" : "1z7b1Pr1rSlvWRzsW3HOrS",
            "popularity" : 79,
            "name" : "Russ",
            "url" : "https://open.spotify.com/artist/1z7b1Pr1rSlvWRzsW3HOrS"
        ], [
            "album" : [
                "https://i.scdn.co/image/ab67616d0000b273084229044ca0f2f9f43584cc",
                "https://i.scdn.co/image/ab67616d0000b273d4d5ddbcc086f6017df445a6",
                "https://i.scdn.co/image/ab67616d0000b273c3a593c88f9e49d78b0a8e01"
            ],
            "image" : "https://i.scdn.co/image/ab6761610000e5ebb22bbb3a26e8b3d6ed50d7ab",
            "id" : "2RVvqRBon9NgaGXKfywDSs",
            "followers" : "475K",
            "url" : "https://open.spotify.com/artist/2RVvqRBon9NgaGXKfywDSs",
            "name" : "Maisie Peters",
            "popularity" : 67
        ]
                                   ])
    }
}

