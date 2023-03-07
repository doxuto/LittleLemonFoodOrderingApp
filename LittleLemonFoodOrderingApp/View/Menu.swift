//
//  Menu.swift
//  LittleLemonFoodOrderingApp
//
//  Created by doxuto on 07/03/2023.
//

import SwiftUI

struct Menu: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss

    @State var searchText = ""
    @State var goToProfile = false

    var body: some View {
        NavigationStack {
            VStack {
                VStack {
                    Hero()
                    TextField("Search Menu...", text: $searchText)
                        .padding(EdgeInsets(top: 10, leading: 40, bottom: 0, trailing: 0))
                        .background(.white)
                        .overlay(
                            HStack {
                                Image(systemName: "magnifyingglass")
                                    .padding(EdgeInsets(top: 10, leading: 20, bottom: 0, trailing: 0))
                                    .foregroundColor(.gray)
                                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            }).frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, 10)
                }.background(littleLemonGreen)
                    .padding([.top], 10)

                Divider()

                Categories()

                FetchedObjects(
                    predicate: buildPredicate(),
                    sortDescriptors: buildSortDescriptors()
                ) { (dishes: [Dish]) in
                    List {
                        ForEach(dishes) { dish in
                            HStack {
                                VStack(alignment: .leading) {
                                    Text("\(dish.title ?? "dish")")
                                        .fontWeight(.bold)
                                    Text("\(dish.detail ?? "")")
                                        .font(.caption)
                                    Text("$\(dish.price ?? "0.00")")
                                        .fontWeight(.semibold)
                                }.frame(width: 220, alignment: .leading)

                                AsyncImage(url: URL(string: dish.image!)) { image in
                                    image
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 120, height: 130,
                                               alignment: .trailing)
                                } placeholder: {
                                    Image("")
                                }
                            }
                        }
                    }
                }

            }.onAppear {
                getMenuData()
            }.navigationBarTitleDisplayMode(.inline)
                .toolbar(content: {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            dismiss()
                        } label: {
                            Label("", systemImage: "arrow.backward.circle.fill")
                                .foregroundColor(littleLemonGreen)
                        }
                    }
                    ToolbarItem(placement: .principal) {
                        Image("Logo")
                            .resizable()
                            .frame(width: 220, height: 50)
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Image("profile-image-placeholder")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .onTapGesture {
                                goToProfile.toggle()
                            }
                    }
                })
            NavigationLink(destination: UserProfile(), isActive: $goToProfile) {
                EmptyView()
            }
        }
    }

    func getMenuData() {
        PersistenceController.shared.clear()

        let url = URL(string: "https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/menu.json")

        let urlRequest = URLRequest(url: url!)

        let urlTask = URLSession.shared.dataTask(with: urlRequest) { data, _, _ in

            if let data = data {
                let decoder = try! JSONDecoder().decode(MenuList.self, from: data)

                decoder.menu.forEach { item in
                    let dish = Dish(context: viewContext)
                    dish.title = item.title
                    dish.price = item.price
                    dish.image = item.image
                    dish.detail = item.detail
                }
            }
        }

        urlTask.resume()
    }

    func buildSortDescriptors() -> [NSSortDescriptor] {
        return [NSSortDescriptor(key: "title", ascending: true, selector: #selector(NSString.localizedStandardCompare))]
    }

    func buildPredicate() -> NSPredicate {
        if searchText.isEmpty {
            return NSPredicate(value: true)
        } else {
            return NSPredicate(format: "title CONTAINS[cd] %@", searchText)
        }
    }
}

struct Menu_Previews: PreviewProvider {
    static var previews: some View {
        Menu()
    }
}
