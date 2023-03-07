//
//  Onboarding.swift
//  LittleLemonFoodOrderingApp
//
//  Created by doxuto on 07/03/2023.
//

import SwiftUI

let firstNameK = "First Name Key"
let lastNameK = "Last Name Key"
let emailK = "Email Key"
let phoneNumberK = "Phone Key"
let isLoggedInK = "LoggedIn Key"

struct Onboarding: View {
    @State var firstNameTextFieldText: String = ""
    @State var lastNameTextFieldText: String = ""
    @State var emailTextFieldText: String = ""
    @State var isLoggedIn = false
    @State var showAlert = false

    @Environment(\.presentationMode) var presentation

    var body: some View {
        NavigationStack {
            VStack {
                Spacer()

                Hero()

                VStack(alignment: .leading) {
                    Text(" First Name *")
                        .foregroundColor(.gray)
                        .fontWeight(.bold)
                        .frame(alignment: .leading)

                    TextField(" Please enter your first name", text: $firstNameTextFieldText)
                        .textFieldStyle(.roundedBorder)

                    Text(" Last Name *")
                        .foregroundColor(.gray)
                        .fontWeight(.bold)
                        .frame(alignment: .leading)

                    TextField(" Please enter your last name", text: $lastNameTextFieldText)
                        .textFieldStyle(.roundedBorder)

                    Text(" Email *")
                        .foregroundColor(.gray)
                        .fontWeight(.bold)
                        .frame(alignment: .leading)

                    TextField(" Please enter your Email", text: $emailTextFieldText)
                        .textFieldStyle(.roundedBorder)
                        .keyboardType(.emailAddress)
                }
                .padding()

                Button("Register") {
                    if validateFieldsNotEmpty() {
                        UserDefaults.standard.set(firstNameTextFieldText, forKey: firstNameK)
                        UserDefaults.standard.set(lastNameTextFieldText, forKey: lastNameK)
                        UserDefaults.standard.set(emailTextFieldText, forKey: emailK)
                        UserDefaults.standard.set(true, forKey: isLoggedInK)
                        self.isLoggedIn = true
                    } else {
                        self.showAlert.toggle()
                    }
                }
                .frame(width: 200, height: 60)
                .foregroundColor(littleLemonGreen)
                .background(littleLemonYellow)
                .cornerRadius(12)
                .padding(5)
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Important message"), message: Text("Text Fields can't be empty"), dismissButton: .default(Text("Got it!")))
                }
                Spacer()
                NavigationLink(
                    destination: Home(),
                    isActive: $isLoggedIn,
                    label: { EmptyView() }
                )
            }
            .onAppear {
                if let loggedIn = UserDefaults.standard.object(forKey: isLoggedInK) as? Bool, loggedIn {
                    isLoggedIn = true
                }
            }.navigationBarBackButtonHidden()
        }
    }

    func validateFieldsNotEmpty() -> Bool {
        return !firstNameTextFieldText.isEmpty && !lastNameTextFieldText.isEmpty && !emailTextFieldText.isEmpty ? true : false
    }
}

struct Registration_Previews: PreviewProvider {
    static var previews: some View {
        Onboarding()
    }
}
