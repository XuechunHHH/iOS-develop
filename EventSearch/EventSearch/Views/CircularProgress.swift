//
//  CircularProgress.swift
//  EventSearch
//
//  Created by mac on 4/15/23.
//

import SwiftUI

struct CircularProgress: View {
    @State var popularity: Int
    var body: some View {
        ZStack {
            Circle()
                .stroke(
                    Color.orange.opacity(0.5),
                    lineWidth: 15
            )
            Circle()
                .trim(from: 0, to: CGFloat(popularity)/100)
                .stroke(
                    Color(red: 0.947, green: 0.604, blue: 0.212),
                    lineWidth: 15
            )
            Text(String(popularity))
                .foregroundColor(Color.white)
        }
        .frame(width: 60,height: 60)
    }
}

struct CircularProgress_Previews: PreviewProvider {
    static var previews: some View {
        CircularProgress(popularity: 89)
    }
}
