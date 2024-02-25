//
//  ProfileView.swift
//  Fillup
//
//  Created by Nathan on 2/24/24.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20.0)
                .frame(width: 500, height: 300)
                .foregroundColor(.white)
                .opacity(0.7)
            Image("portrait")
                .resizable()
                .frame(maxWidth: 200)
                .aspectRatio(contentMode: .fit)
                .mask {
                    Circle()
                        .frame(width: 200, height: 200)
                }
        }
    }
}

#Preview {
    ProfileView()
}
