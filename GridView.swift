//
//  GridView.swift
//  Fillup
//
//  Created by Nathan on 2/25/24.
//

import SwiftUI

struct GridView: View {
    @State var xCount: Int
    @State var yCount: Int
    
    @State var calcW = 50.0
    @State var calcH = 40.0
    
    @State var remainder = 0
    
    @State var image = "hottub"
    

    
    var body: some View {
        VStack {
//            Text("x: \(grid.x), y: \(grid.y)")
            VStack {
                ForEach(1...yCount, id: \.self) { _ in
                    HStack {
                        ForEach(1...xCount, id: \.self) { _ in
                            Image(image)
                                .resizable()
                                .frame(width: calcW, height: calcH)
                        }
                    }
                }
            }
            if remainder > 0 {
                HStack() {
                    ForEach(1...remainder, id: \.self) { _ in
                        Image(image)
                            .resizable()
                            .frame(width: calcW, height: calcH)
                    }
                    Spacer()

                }
            }
        }
    }
}

//#Preview {
//    GridView()
//}
