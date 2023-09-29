//
//  VenueView.swift
//  EventSearch
//
//  Created by mac on 4/11/23.
//

import SwiftUI
import SwiftyJSON
import MapKit
import Alamofire

struct VenueView: View {
    @State var event: String
    @State var venue: JSON
    @State var isSheetPresented = false
    @State var coordinateRegion: MKCoordinateRegion

    func showMap(){
        isSheetPresented = true
    }
    
    var body: some View {
        VStack {
            Text(event)
                .font(.title3)
                .fontWeight(.bold)
                .padding(.bottom)
            VStack{
                Text("Name")
                    .fontWeight(.bold)
                Text(venue["name"].string ?? "")
                    .foregroundColor(Color.gray)
            }
            .padding(.bottom, 5)
            VStack{
                Text("Address")
                    .fontWeight(.bold)
                Text(venue["address"].string ?? "")
                    .foregroundColor(Color.gray)
            }
            .padding(.bottom, 5)
            VStack{
                Text("Phone Number")
                    .fontWeight(.bold)
                Text(venue["tel"].string ?? "")
                    .foregroundColor(Color.gray)
            }
            .padding(.bottom, 5)
            VStack{
                Text("Open Hours")
                    .fontWeight(.bold)
                ScrollView {
                    Text(venue["openHour"].string ?? "")
                        .foregroundColor(Color.gray)
                        .frame(maxWidth: .infinity)
                }
                .frame(height: 70)
                
            }
            .padding(.bottom, 5)
            VStack{
                Text("General Rule")
                    .fontWeight(.bold)
                
                ScrollView {
                    Text(venue["generalRule"].string ?? "")
                        .foregroundColor(Color.gray)
                        .frame(maxWidth: .infinity)
                }
                .frame(height: 70)
            }
            .padding(.bottom, 5)
            VStack{
                Text("Child Rule")
                    .fontWeight(.bold)
                
                ScrollView {
                    Text(venue["childRule"].string ?? "")
                        .foregroundColor(Color.gray)
                        .frame(maxWidth: .infinity)
                }
                .frame(height: 70)
            }
            Button("Show venue on maps",action:showMap)
                .frame(width: 200, height: 50)
                .background(Color.red)
                .foregroundColor(.white)
                .cornerRadius(10)
                .buttonStyle(.borderless)
                .padding()
            Spacer()
        }
        .padding(.horizontal)
        .padding(.top,30)
        .sheet(isPresented: $isSheetPresented){
            VStack {
                Map(coordinateRegion: $coordinateRegion, annotationItems: [AnnotationItem(coordinate: coordinateRegion.center)]) { place in
                    MapMarker(coordinate: place.coordinate, tint: .red)
                }
            }
            .padding()
        }
    }
}

struct AnnotationItem: Identifiable {
    let id = UUID()
    let coordinate: CLLocationCoordinate2D
}

struct VenueView_Previews: PreviewProvider {
    static var previews: some View {
        VenueView(event: "Ed Sheeran: +-=÷x Tour", venue: [
            "childRule" : "CHILDREN UNDER THE AGE OF TWO (2) ARE ADMITTED FREE PROVIDED THEY SIT ON AN ADULT'S LAP. CHILDREN, AGED TWO (2) AND OVER MUST HAVE A VALID TICKET FOR ADMISSION. For additional Stadium information including permitted and prohibited items please visit http://www.levisstadium.com/stadium-info/about-levis-stadium/ Miscellaneous For additional Stadium information including permitted and prohibited items please call 415-656-4949 or visit www.49ers.com/stadium",
            "name" : "Levi's® Stadium",
            "tel" : "415-GO-49ERS (415-464-9377)",
            "address" : "4900 Marie P. DeBartolo Way",
            "generalRule" : "ALL INDIVIDUALS AND THEIR BELONGINGS ARE SUBJECT TO SEARCH. THE FOLLOWING INFORMATION IS SUBJECT TO CHANGE WITHOUT NOTICE. You and your belongings may be searched upon entry into the Stadium. The 49ers strongly encourage fans to not bring any type of bags. Fans will be able to carry the following style and size bag, package, or container at stadium plaza areas, stadium gates, or when approaching queue lines of fans awaiting entry into the stadium: Bags that are clear plastic, vinyl or PVC and do not exceed 12 x 6 x 12. (Official NFL team logo clear plastic tote bags are available through club merchandise outlets or at nflshop.com), or One-gallon clear plastic freezer bag (Ziploc bag or similar). Small clutch bags, approximately the size of a hand, with or without a handle or strap, may be carried into the stadium along with one of the clear bag options. An exception will be made for medically necessary items after proper inspection at a gate designated for this purpose. Prohibited items include, but are not limited to: purses larger than a clutch bag, coolers, briefcases, backpacks, fanny packs, cinch bags, luggage of any kind, seat cushions, computer bags and camera bags or any bag larger than the permissible size. By tendering the ticket and entering the Stadium, you consent to such searches and waive any related claims that you might have against the NFL, its member clubs, their affiliates and stadium landlord, or their agents. If you elect not to consent to the searches, you will be denied entry into the Stadium. PLEASE ARRIVE EARLY TO AVOID LAST MINUTE GATE PRESSURE.",
            "openHour" : "9AM to 5PM Monday through Friday,",
            "state" : "California",
            "city" : "Santa Clara"
        ], coordinateRegion: MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 37.4030513, longitude: -121.9696477),
            span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        )
        )
    }
}
