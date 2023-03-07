//
//  Categories.swift
//  LittleLemonFoodOrderingApp
//
//  Created by doxuto on 07/03/2023.
//

import SwiftUI

private var categories = ["Starters", "Mains", "Desserts", "Drinks"]

struct Categories: View {
    var body: some View {
        VStack {
            Text("ORDER FOR DELIVERY!")
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 30)
            LazyHStack {
                ForEach(categories, id: \.self) { category in
                    Button("\(category)") {}.tint(littleLemonLightGray)
                        .foregroundColor(.black)
                        .controlSize(.small)
                        .buttonStyle(.borderedProminent)
                }
            }
        }.frame(height: 80)
            .padding(.top, 10)
    }
}

struct Categories_Previews: PreviewProvider {
    static var previews: some View {
        Categories()
    }
}
