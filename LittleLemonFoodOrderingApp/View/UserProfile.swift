//
//  UserProfile.swift
//  LittleLemonFoodOrderingApp
//
//  Created by doxuto on 07/03/2023.
//

import SwiftUI

struct UserProfile: View {
    @Environment(\.presentationMode) var presentation
    @Environment(\.dismiss) private var dismiss

    let firstName = UserDefaults.standard.string(forKey: firstNameK)
    let lastName = UserDefaults.standard.string(forKey: lastNameK)
    let email = UserDefaults.standard.string(forKey: emailK)
    let phone = UserDefaults.standard.string(forKey: phoneNumberK)

    @State var firstNameTextFieldText: String = ""
    @State var lastNameTextFieldText: String = ""
    @State var emailTextFieldText: String = ""
    @State var phoneTextFieldText: String = ""

    let persistence = PersistenceController.shared

    @State var isLoggedOut = false

    var body: some View {
        NavigationStack {
            VStack {
                Text("Personal Information")
                    .font(.system(size: 22))
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .padding(.top, 20)

                HStack {
                    Image("profile-image-placeholder")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .padding(.horizontal, 10)
                    Button {} label: {
                        Text("Change")
                            .frame(width: 100, height: 50)
                            .foregroundColor(Color.white)
                            .background(littleLemonGreen)
                            .clipShape(RoundedRectangle(cornerRadius: 14))
                    }
                    .padding(.horizontal)
                    Button {} label: {
                        Text("Remove")
                            .frame(width: 100, height: 50)
                            .foregroundColor(Color.gray)
                            .background(Color.white)
                            .border(.gray, width: 2)
                    }
                }
                .padding()
                VStack(alignment: .leading) {
                    Text("First name")
                        .foregroundColor(.gray)
                        .fontWeight(.bold)
                        .frame(alignment: .leading)
                    TextField(firstName ?? "", text: $firstNameTextFieldText)
                        .frame(alignment: .leading)
                        .foregroundColor(.black)
                        .textFieldStyle(.roundedBorder)

                    Text("Last name")
                        .foregroundColor(.gray)
                        .fontWeight(.bold)
                    TextField(lastName ?? "", text: $lastNameTextFieldText)
                        .foregroundColor(.black)
                        .textFieldStyle(.roundedBorder)
                    Text("Email")
                        .foregroundColor(.gray)
                        .fontWeight(.bold)
                    TextField(email ?? "", text: $emailTextFieldText)
                        .foregroundColor(.black)
                        .textFieldStyle(.roundedBorder)
                }

                VStack(alignment: .leading) {
                    Spacer()

                    Text("Email Notifications")
                        .font(.headline)
                        .fontWeight(.bold)
                    HStack {
                        Image(systemName: "checkmark")
                            .padding(6)
                            .foregroundColor(.white)
                            .background(littleLemonGreen)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                        Text("Order Statuses")
                            .font(.subheadline)
                    }
                    HStack {
                        Image(systemName: "checkmark")
                            .padding(6)
                            .foregroundColor(.white)
                            .background(littleLemonGreen)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                        Text("Password Changes")
                            .font(.subheadline)
                    }
                    HStack {
                        Image(systemName: "checkmark")
                            .padding(6)
                            .foregroundColor(.white)
                            .background(littleLemonGreen)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                        Text("Special Offers")
                            .font(.subheadline)
                    }
                    HStack {
                        Image(systemName: "checkmark")
                            .padding(6)
                            .foregroundColor(.white)
                            .background(littleLemonGreen)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                        Text("Newsletter")
                            .font(.subheadline)
                    }

                    Spacer()

                    Button {
                        UserDefaults.standard.set(false, forKey: isLoggedInK)
                        isLoggedOut = true
                    } label: {
                        Text("Log out ")
                            .fontWeight(.semibold)
                            .frame(width: 340, height: 50)
                            .foregroundColor(Color.black)
                            .background(littleLemonYellow)
                            .clipShape(RoundedRectangle(cornerRadius: 14))
                    }
                    HStack {
                        Button {} label: {
                            Text("Remove")
                                .fontWeight(.semibold)
                                .frame(width: 170, height: 50)
                                .foregroundColor(Color.gray)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(.gray, lineWidth: 2)
                                )
                        }

                        Button {
                            UserDefaults.standard.set(firstNameTextFieldText, forKey: firstNameK)
                            UserDefaults.standard.set(lastNameTextFieldText, forKey: lastNameK)
                            UserDefaults.standard.set(emailTextFieldText, forKey: emailK)
                            UserDefaults.standard.set(phoneTextFieldText, forKey: phoneNumberK)

                        } label: {
                            Text("Save Changes")
                                .frame(width: 170, height: 50)
                                .foregroundColor(Color.white)
                                .background(littleLemonGreen)
                                .clipShape(RoundedRectangle(cornerRadius: 14))
                        }
                    }
                }
                .padding(.bottom, 10)
                NavigationLink(destination: Onboarding(), isActive: $isLoggedOut) {
                    EmptyView()
                }
            }.padding(.horizontal, 10)

        }.frame(maxHeight: .infinity)
            .navigationBarBackButtonHidden()
            .environment(\.managedObjectContext, persistence.container.viewContext)
            .navigationBarTitleDisplayMode(.inline)
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
            })
    }
}

struct UserProfile_Previews: PreviewProvider {
    static var previews: some View {
        UserProfile()
    }
}
