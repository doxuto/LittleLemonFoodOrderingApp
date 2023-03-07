//
//  Hero.swift
//  LittleLemonFoodOrderingApp
//
//  Created by doxuto on 07/03/2023.
//

import SwiftUI

struct Hero: View {
    var body: some View {
        HStack(alignment: VerticalAlignment.center) {
            VStack {
                Text("Little Lemon")
                    .font(.title)
                    .padding(.leading, 20)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(littleLemonYellow)
                Text("Chicago")
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 20)
                Text("We are a family owned Mediterranean restaurant, focused on traditional recipes served with a modern twist.")
                    .font(.subheadline)
                    .frame(width: 250, height: 130, alignment: .leading)
            }.padding(.top, 20)
            VStack {
                Image("hero")
                    .resizable()
                    .clipShape(RoundedRectangle(cornerRadius: 20.0))
                    .frame(width: 120, height: 130)
            }
            Spacer()
        }.background(littleLemonGreen)
            .foregroundColor(.white)
    }
}
